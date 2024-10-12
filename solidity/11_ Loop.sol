// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Loop {
    function loop() public pure returns (uint) {
        // for loop
        uint name;
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                // Skip to next iteration with continue
                continue;
            }
            if (i == 5) {
                // Exit loop with break
                break;
            }else{
                name=i;
            }
        }
        return  name;
    }
}