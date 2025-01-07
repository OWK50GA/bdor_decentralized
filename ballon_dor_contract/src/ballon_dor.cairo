#[starknet::contract]
// #[generate_trait]
// impl Private of PrivateTrait {
//     fn has_voted {
//         self.has_voted.read(address)
//     }
// }

pub mod BDorContract {
    use ballon_dor_contract::structs::{candidate_struct::Candidate, voter_struct::Voter};
    use ballon_dor_contract::interfaces::{ballon_dor_interface::IBdorContract};
    use core::starknet::{
        get_caller_address, ContractAddress,
        storage::{Map, StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry},
    };

    #[storage]
    struct Storage {
        candidates: Map<u256, Candidate>,
        candidates_index: Map<u64, ContractAddress>,
        has_voted: Map<ContractAddress, bool>,
        total_no_of_voters: u256,
        total_no_of_candidates: u256,
    }
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[constructor]
    fn constructor(ref self: ContractState) {}

    #[abi(embed_v0)]
    impl BDorContractImpl of IBdorContract<ContractState> {
        fn nominate(
            ref self: ContractState,
            _voter: ContractAddress,
            candidate_fname: felt252,
            candidate_lname: felt252,
            candidate_club: felt252,
            candidate_country: felt252,
            candidate: Candidate,
        ) {
            let candidate = Candidate {
                fname: candidate_fname,
                lname: candidate_lname,
                club: candidate_club,
                country: candidate_country,
                no_of_nominations: 1,
                is_candidate: false,
                no_of_votes: 0,
            };

            self.candidates.write(candidate)
        }

        fn add_to_nominations(ref self: ContractState, candidate_id: u256) {
            let old_nominee = self.candidates.entry(candidate_id).read();
            let new_nominee = Candidate {
                fname: old_nominee.fname,
                lname: old_nominee.lname,
                club: old_nominee.club,
                country: old_nominee.country,
                no_of_nominations: old_nominee.no_of_nominations + 1,
                is_candidate: 1 + old_nominee.no_of_nominations >= 5,
                no_of_votes: 0,
            };
            self.candidates.entry(id).write(new_nominee)
        }

        fn denominate(ref self: ContractState, voter: ContractAddress, candidate_id: u256) {
            let old_nominee = self.candidates.entry(id).read();
            let new_nominee = Candidate {
                fname: old_nominee.fname,
                lname: old_nominee.lname,
                club: old_nominee.club,
                country: old_nominee.country,
                no_of_nominations: old_nominee.no_of_nominations - 1,
                is_candidate: false,
                no_of_votes: 0,
            };
            self.candidates.entry(id).write(new_nominee)
        }

        fn cast_vote(ref self: ContractState, candidate_id: u256) {
            let voter = get_caller_address();
            let voted = self.has_voted.read(voter);
            assert_ne!(voted, true);
            let old_candidate = self.candidates.entry(candidate_id).read();
            let new_candidate = Candidate {
                fname: old_candidate.fname,
                lname: old_candidate.lname,
                club: old_candidate.club,
                country: old_candidate.country,
                no_of_nominations: old_candidate.no_of_nominations,
                is_candidate: true,
                no_of_votes: old_candidate.no_of_votes + 1,
            };
            self.has_voted.write(voter, true)
        }

        fn uncast_vote(ref self: ContractState, voter: ContractAddress, candidate_id: u256) {
            let voter = get_caller_address();
            let voted = self.has_voted.read(voter);
            assert_eq!(voted, true);
            // assert_ne!(voted, true);
            let old_candidate = self.candidates.entry(id).read();
            let new_candidate = Candidate {
                fname: old_candidate.fname,
                lname: old_candidate.lname,
                club: old_candidate.club,
                country: old_candidate.country,
                no_of_nominations: old_candidate.no_of_nominations,
                is_candidate: true,
                no_of_votes: old_candidate.no_of_votes - 1,
            };
            self.has_voted.write(voter, false);
        }

        fn get_all_nominees(self: @ContractState) -> Span<Candidate> {
            // empty array to store all nominees
            let mut all_nominees: Array<Candidate> = array![];
            // total number of candidates
            let candidates_count = self.total_no_of_candidates.read();
            // counter
            let mut i = 1;
            // loop through candidates, and return those who are just nominees yet
            while i < candidates_count + 1 {
                let current_candidate_data = self.candidates.entry(i).read();
                // return those who are just nominees
                if !current_candidate_data.is_candidate {
                    all_nominees.append(current_candidate_data)
                }

                i += 1
            }

            all_nominees.span()
        }

        fn get_nominee(
            self: @ContractState, candidate_id: u256,
        ) -> (felt252, felt252, felt252, felt252, bool) {
            let nominee = self.candidates.entry(candidate_id).read();
            (nominee.fname, nominee.lname, nominee.club, nominee.country, nominee.is_candidate)
        }

        fn get_all_candidates(self: @ContractState) -> Span<Candidate> {
            let mut all_candidates: Array<Candidate> = array![];
            // total number of candidates
            let candidates_count = self.total_no_of_candidates.read();
            // counter
            let mut i = 1;
            // loop through candidates, and return those who are just nominees yet
            while i < candidates_count + 1 {
                let current_candidate_data = self.candidates.entry(i).read();
                // return those who are just nominees
                if current_candidate_data.is_candidate {
                    all_candidates.append(current_candidate_data)
                }

                i += 1
            }

            all_candidates.span()
        }
    }
}
