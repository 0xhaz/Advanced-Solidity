// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Homework-8/Gas.sol";

contract GasTest is Test {
    GasContract public gas;
    uint256 public totalSupply = 1000000000;
    address owner = address(0x1234);
    address addr1 = address(0x5678);
    address addr2 = address(0x9101);
    address addr3 = address(0x1213);

    address[] admins = [
        address(0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2),
        address(0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46),
        address(0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf),
        address(0xeadb3d065f8d15cc05e92594523516aD36d1c834),
        owner
    ];

    function setUp() public {
        vm.startPrank(owner);
        gas = new GasContract(admins, totalSupply);
        vm.stopPrank();
    }

    function test_admins() public {
        for (uint8 i = 0; i < admins.length; i++) {
            assertEq(admins[i], gas.administrators(i));
        }
    }

    function test_onlyOwner(address _userAddrs, uint256 _tier) public {
        vm.assume(_userAddrs != address(gas));
        _tier = bound(_tier, 1, 244);
        vm.expectRevert();
        gas.addToWhitelist(_userAddrs, _tier);
    }

    function test_tiers(address _userAddrs, uint256 _tier) public {
        vm.assume(_userAddrs != address(gas));
        _tier = bound(_tier, 1, 244);
        vm.prank(owner);
        gas.addToWhitelist(_userAddrs, _tier);
    }

    event AddedToWhitelist(address userAddress, uint256 tier);

    function test_whitelistEvents(address _userAddrs, uint256 _tier) public {
        vm.startPrank(owner);
        vm.assume(_userAddrs != address(gas));
        _tier = bound(_tier, 1, 244);
        vm.expectEmit(true, true, false, true);
        emit AddedToWhitelist(_userAddrs, _tier);
        gas.addToWhitelist(_userAddrs, _tier);
        vm.stopPrank();
    }
}
