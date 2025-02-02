// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4 <0.9.0;

import {Script} from 'forge-std/Script.sol';
import {CryptoAnts, ICryptoAnts} from 'src/CryptoAnts.sol';
import {Egg, IEgg} from 'src/Egg.sol';

contract Deploy is Script {
  function run() external {
    address deployer = vm.rememberKey(vm.envUint('DEPLOYER_PRIVATE_KEY'));
    address governer = address(vm.envAddress('GOVERNER_ADDRESS'));
    vm.startBroadcast(deployer);
    IEgg _eggs = IEgg(vm.computeCreateAddress(deployer, 1));
    ICryptoAnts _cryptoAnts = new CryptoAnts(address(_eggs), governer);
    _eggs = new Egg(address(_cryptoAnts));
    vm.stopBroadcast();
  }
}
