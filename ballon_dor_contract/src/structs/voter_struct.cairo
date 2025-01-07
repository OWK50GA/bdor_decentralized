#[derive(Drop, Serde, starknet::Store)]
use core::starknet::{
    get_caller_address, ContractAddress,
    storage::{Map, StorageMapReadAccess, StorageMapWriteAccess},
};
pub struct Voter {
    pub id: u64,
    pub address: ContractAddress,
    pub has_voted: bool,
}
