use ballon_dor_contract::structs::{voter_struct::Voter, candidate_struct::Candidate};
use core::starknet::{ContractAddress};

#[starknet::interface]
pub trait IBdor<TContractState> {
    fn nominate(
        ref self: TContractState,
        candidate_fname: felt252,
        candidate_lname: felt252,
        candidate_club: felt252,
        candidate_country: felt252,
    ) -> u256;

    fn denominate(ref self: TContractState, candidate_id: u256);

    fn cast_vote(ref self: TContractState, candidate_id: u256);

    fn uncast_vote(ref self: TContractState, candidate_id: u256);
    fn get_all_nominees(self: @TContractState) -> Span<Candidate>;

    fn get_nominee(
        self: @TContractState, candidate_id: u256,
    ) -> (felt252, felt252, felt252, felt252, bool);

    fn get_all_candidates(self: @TContractState) -> Span<Candidate>;
    // fn get_candidate(self: @ContractState, id: u256) -> (felt252, felt252, felt252, felt252,
// bool);
}
