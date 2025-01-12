#[starknet::contract]
pub mod BDorContract {
    use starknet::storage::VecTrait;
    use ballon_dor_contract::structs::{candidate_struct::Candidate};
    use ballon_dor_contract::interfaces::{ballon_dor_interface::IBdor};
    use core::starknet::{
        get_caller_address, ContractAddress,
        storage::{
            Map, StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry, Vec,
            MutableVecTrait,
        },
    };
    use core::poseidon::{PoseidonTrait};
    use core::hash::{HashStateTrait, HashStateExTrait};

    // The has_voted maps the voter to a tuple of bool "voted" and the id of the candidate the
    // caller voted for
    #[storage]
    struct Storage {
        candidates: Map<u256, Option<Candidate>>,
        has_voted: Map<ContractAddress, (bool, u256)>,
        total_no_of_voters: u256,
        total_no_of_candidates: u64,
        candidates_array: Vec::<u256>,
        owner: ContractAddress,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.owner.write(owner);
    }

    #[abi(embed_v0)]
    impl BDorContractImpl of IBdor<ContractState> {
        fn nominate(
            ref self: ContractState,
            candidate_fname: felt252,
            candidate_lname: felt252,
            candidate_club: felt252,
            candidate_country: felt252,
        ) -> u256 {
            let id: u256 = generate_id(candidate_fname, candidate_lname);
            if let Option::Some(mut candidate) = self.candidates.entry(id).read() {
                assert!(
                    !candidate.is_candidate, "Err: Nominee is already a Candidate. Vote Instead.",
                );
                candidate.no_of_nominations += 1;
                if candidate.no_of_nominations == 5 {
                    candidate.is_candidate = true;
                    let n = self.total_no_of_candidates.read();
                    self.total_no_of_candidates.write(n + 1);
                }

                self.candidates.entry(id).write(Option::Some(candidate));
            } else {
                let candidate = Candidate {
                    id,
                    fname: candidate_fname,
                    lname: candidate_lname,
                    club: candidate_club,
                    country: candidate_country,
                    no_of_nominations: 1,
                    is_candidate: false,
                    no_of_votes: 0,
                };
                self.candidates.entry(id).write(Option::Some(candidate));
                self.candidates_array.append().write(id);
            }

            id
        }

        fn denominate(ref self: ContractState, candidate_id: u256) {
            let mut nominee = self.candidates.entry(candidate_id).read();

            assert!(nominee.is_some(), "Err: Nominee does not exist.");

            if let Option::Some(mut nominee) = nominee {
                assert!(!nominee.is_candidate, "Err: Nominee is already a Candidate.");
                nominee.no_of_nominations -= 1;
                if nominee.no_of_nominations == 0 {
                    self.candidates.entry(candidate_id).write(Option::None);
                    let n = self.total_no_of_candidates.read();
                    self.total_no_of_candidates.write(n - 1);
                } else {
                    self.candidates.entry(candidate_id).write(Option::Some(nominee));
                }
            }
        }

        fn cast_vote(ref self: ContractState, candidate_id: u256) {
            // assert if candidate is a candidate first
            let voter = get_caller_address();
            let (voted, _) = self.has_voted.entry(voter).read();
            assert!(!voted, "Err: Caller has already cast a vote.");
            let candidate: Option<Candidate> = self.candidates.entry(candidate_id).read();
            assert!(candidate.is_some(), "Err: Candidate does not exist.");

            if let Option::Some(mut candidate) = candidate {
                assert!(candidate.is_candidate, "Err: Candidate is not a nominee.");
                candidate.no_of_votes += 1;
                self.candidates.entry(candidate_id).write(Option::Some(candidate));
            }
            self.has_voted.entry(voter).write((true, candidate_id));
            self.total_no_of_voters.write(self.total_no_of_voters.read() + 1);
        }

        fn uncast_vote(ref self: ContractState, candidate_id: u256) {
            let voter = get_caller_address();
            let (voted, _) = self.has_voted.entry(voter).read();
            assert!(voted, "Err: Caller has no casted vote.");
            let candidate = self.candidates.entry(candidate_id).read();
            assert!(candidate.is_some(), "Err: Candidate does not exist");

            if let Option::Some(mut candidate) = candidate {
                assert!(candidate.is_candidate, "Err: Candidate is not a nominee.");
                candidate.no_of_votes -= 1;
                self.candidates.entry(candidate_id).write(Option::Some(candidate));
            }
            self.has_voted.entry(voter).write((false, candidate_id));
            self.total_no_of_voters.write(self.total_no_of_voters.read() - 1);
        }

        fn get_all_nominees(self: @ContractState) -> Span<Candidate> {
            let mut nominees: Array<Candidate> = array![];
            let candidates_array = self.candidates_array;

            for i in 0..candidates_array.len() {
                let candidate_id = self.candidates_array.at(i).read();
                let candidate_ref = self.candidates.entry(candidate_id).read();
                if candidate_ref.is_some() && !candidate_ref.unwrap().is_candidate {
                    nominees.append(candidate_ref.unwrap());
                }
            };

            nominees.span()
        }

        fn get_nominee(
            self: @ContractState, candidate_id: u256,
        ) -> (felt252, felt252, felt252, felt252, bool) {
            let nominee_ref = self.candidates.entry(candidate_id).read();
            assert!(nominee_ref.is_some(), "Err: Nominee does not exist.");
            let nominee = nominee_ref.unwrap();
            (nominee.fname, nominee.lname, nominee.club, nominee.country, nominee.is_candidate)
        }

        fn get_all_candidates(self: @ContractState) -> Span<Candidate> {
            let mut candidates: Array<Candidate> = array![];
            let candidates_array = self.candidates_array;

            for i in 0..candidates_array.len() {
                let candidate_id = self.candidates_array.at(i.try_into().unwrap()).read();
                let candidate_ref = self.candidates.entry(candidate_id).read();
                if candidate_ref.is_some() && candidate_ref.unwrap().is_candidate {
                    candidates.append(candidate_ref.unwrap());
                }
            };

            candidates.span()
        }
    }

    fn generate_id(fname: felt252, lname: felt252) -> u256 {
        let id = PoseidonTrait::new().update_with(fname).update_with(lname).finalize();
        id.into()
    }
}

