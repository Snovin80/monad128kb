// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract DataValidation {
    event DataValidated(string data, bool isValid);

    function validateEmail(string memory _email) public returns (bool) {
        bool isValid = isEmail(_email);
        emit DataValidated(_email, isValid);
        return isValid;
    }

    function isEmail(string memory _email) internal pure returns (bool) {
        bytes memory emailBytes = bytes(_email);
        if (emailBytes.length < 5) return false;
        if (emailBytes[0] == '@' || emailBytes[emailBytes.length - 1] == '@') return false;

        bool hasAt = false;
        bool hasDot = false;

        for (uint256 i = 0; i < emailBytes.length; i++) {
            if (emailBytes[i] == '@') {
                if (hasAt) return false;
                hasAt = true;
            } else if (emailBytes[i] == '.') {
                if (i == 0 || i == emailBytes.length - 1) return false;
                if (!hasAt) return false;
                hasDot = true;
            }
        }

        return hasAt && hasDot;
    }
}