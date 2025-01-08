use core::starknet::{ContractAddress};

#[derive(Drop, Serde, starknet::Store)]
pub struct Voter {
    pub id: u64,
    pub address: ContractAddress,
    pub has_voted: bool,
}
