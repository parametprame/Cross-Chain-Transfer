// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;
import {IAxelarGateway} from "../interfaces/IAxelarGateway.sol";
import {IERC20} from "../interfaces/IERC20.sol";

contract AxelarCrossChainTransfer {
    IAxelarGateway axelarGateway;

    address WETHTokenAddress;
    address AxelarGateWayAddress;

    constructor(address gateway_, address _token) {
        axelarGateway = IAxelarGateway(gateway_);
        AxelarGateWayAddress = gateway_;
        WETHTokenAddress = _token;
    }

    function sendToken(
        string calldata _desChain,
        string calldata _desAddress,
        string calldata _symbol,
        uint256 amount
    ) external {
        IERC20(WETHTokenAddress).transferFrom(
            msg.sender,
            address(this),
            amount
        );
        IERC20(WETHTokenAddress).approve(AxelarGateWayAddress, amount);
        axelarGateway.sendToken(_desChain, _desAddress, _symbol, amount);
    }
}
