#[derive(Drop, Copy, Serde, PartialEq, starknet::Store)]
pub struct Candidate {
    pub id: u256,
    pub fname: felt252,
    pub lname: felt252,
    pub club: felt252,
    pub country: felt252,
    pub no_of_nominations: u256,
    pub is_candidate: bool,
    pub no_of_votes: u256,
}
