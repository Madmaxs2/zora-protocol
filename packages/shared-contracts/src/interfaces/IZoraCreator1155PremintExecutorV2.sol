// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ContractCreationConfig, ContractWithAdditionalAdminsCreationConfig, PremintConfigV2, PremintResult, MintArguments} from "../entities/Premint.sol";
import {IGetContractAddress} from "./IGetContractAddress.sol";

interface IZoraCreator1155PremintExecutorV2 is IGetContractAddress {
    function premintV2WithSignerContract(
        ContractCreationConfig calldata contractConfig,
        PremintConfigV2 calldata premintConfig,
        bytes calldata signature,
        uint256 quantityToMint,
        MintArguments calldata mintArguments,
        address firstMinter,
        address signerContract
    ) external payable returns (PremintResult memory result);

    /// Creates a new token on the given erc1155 contract on behalf of a creator, and mints x tokens to the executor of this transaction.
    /// If the erc1155 contract hasn't been created yet, it will be created with the given config within this same transaction.
    /// The creator must sign the intent to create the token, and must have mint new token permission on the erc1155 contract,
    /// or match the contract admin on the contract creation config if the contract hasn't been created yet.
    /// Contract address of the created contract is deterministically generated from the contract config and this contract's address.
    /// @dev For use with of any version of premint config
    /// @param contractConfig Parameters for creating a new contract, if one doesn't exist yet.  Used to resolve the deterministic contract address.
    /// @param encodedPremintConfig abi encoded premint config
    /// @param premintConfigVersion corresponding version for premint config
    /// @param signature Signature of the creator of the token, which must match the signer of the premint config, or have permission to create new tokens on the erc1155 contract if it's already been created
    /// @param quantityToMint How many tokens to mint to the mintRecipient
    /// @param mintArguments mint arguments specifying the token mint recipient, mint comment, and mint referral
    /// @param firstMinter account to get the firstMinter reward for the token
    /// @param signerContract If a smart wallet was used to create the premint, the address of that smart wallet. Otherwise, set to address(0)
    function premintNewContract(
        ContractWithAdditionalAdminsCreationConfig calldata contractConfig,
        bytes calldata encodedPremintConfig,
        string calldata premintConfigVersion,
        bytes calldata signature,
        uint256 quantityToMint,
        MintArguments calldata mintArguments,
        address firstMinter,
        address signerContract
    ) external payable returns (PremintResult memory);

    /// Creates a new token on the given erc1155 contract on behalf of a creator, and mints x tokens to the executor of this transaction.
    /// Only works on contracts that have already been created.
    /// The creator must sign the intent to create the token, and must have mint new token permission on the erc1155 contract,
    /// or match the contract admin on the contract creation config if the contract hasn't been created yet.
    /// Contract address of the created contract is deterministically generated from the contract config and this contract's address.
    /// @dev For use with of any version of premint config
    /// @param tokenContract Contract that premint was signed against.
    /// @param encodedPremintConfig abi encoded premint config
    /// @param premintConfigVersion corresponding version for premint config
    /// @param signature Signature of the creator of the token, which must match the signer of the premint config, or have permission to create new tokens on the erc1155 contract if it's already been created
    /// @param quantityToMint How many tokens to mint to the mintRecipient
    /// @param mintArguments mint arguments specifying the token mint recipient, mint comment, and mint referral
    /// @param firstMinter account to get the firstMinter reward for the token
    /// @param signerContract If a smart wallet was used to create the premint, the address of that smart wallet. Otherwise, set to address(0)
    function premintExistingContract(
        address tokenContract,
        bytes calldata encodedPremintConfig,
        string calldata premintConfigVersion,
        bytes calldata signature,
        uint256 quantityToMint,
        MintArguments calldata mintArguments,
        address firstMinter,
        address signerContract
    ) external payable returns (uint256 tokenId);
}
