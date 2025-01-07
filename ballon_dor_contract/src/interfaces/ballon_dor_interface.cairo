use bdor_contract::structs::{Voter, Candidate};
use core::starknet::{ContractAddress};

#[starknet::interface]
pub trait IBdorContract<TContractState> {
    fn nominate(
        ref self: TContractState,
        voter: ContractAddress,
        candidate_fname: felt252,
        candidate_lname: felt252,
        candidate_club: felt252,
        candidate_country: felt252,
        candidate: Candidate,
    );

    fn add_to_nominations(ref self: TContractState, candidate_id: u256);

    fn denominate(ref self: TContractState, voter: ContractAddress, candidate: Candidate);

    fn cast_vote(ref self: TContractState, candidate_id: u256);

    fn uncast_vote(ref self: TContractState, voter: ContractAddress, candidate: Candidate);

    fn get_all_nominees(self: @TContractState) -> Span<Candidate>;

    fn get_nominee(self: @TContractState, id: u256) -> (felt252, felt252, felt252, felt252, bool);

    fn get_all_candidates(self: @TContractState) -> Span<Candidate>;
    // fn get_candidate(self: @ContractState, id: u256) -> (felt252, felt252, felt252, felt252,
// bool);
}
