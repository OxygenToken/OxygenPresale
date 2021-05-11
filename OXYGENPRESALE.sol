
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;



import "./openzeppelin-solidity/contracts/utils/Context.sol";
import "./openzeppelin-solidity/contracts/access/Ownable.sol";
import "./openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "./openzeppelin-solidity/contracts/utils/math/SafeMath.sol";
import "./openzeppelin-solidity/contracts/utils/Address.sol";
import "./Presale/CappedCrowdsale.sol";
import "./Presale/TimedCrowdsale.sol";
import "./Presale/PostDeliveryCrowdsale.sol";
import "./Presale/IndividuallyCappedCrowdsale.sol";

contract OXYGENPRESALE is  Context,  Ownable, CappedCrowdsale, IndividuallyCappedCrowdsale, PostDeliveryCrowdsale  {
    using SafeMath for uint256;
    using Address for address;
    
    
    
    
constructor

(uint256 _rate, address payable _wallet, ERC20 _token, uint256 _cap, uint256 _openingTime, uint256 _closingTime, uint256 _individualCap)
    CappedCrowdsale(_cap) 
    TimedCrowdsale(_openingTime, _closingTime)
    Crowdsale(_rate, _wallet, _token)
    IndividuallyCappedCrowdsale(_individualCap)
  {
  }
function _preValidatePurchase(address beneficiary, uint256 weiAmount) override(CappedCrowdsale, TimedCrowdsale, IndividuallyCappedCrowdsale) internal onlyWhileOpen view {
        super._preValidatePurchase(beneficiary, weiAmount);
        CappedCrowdsale._preValidatePurchase(beneficiary,weiAmount);
        TimedCrowdsale._preValidatePurchase(beneficiary,weiAmount);
        IndividuallyCappedCrowdsale._preValidatePurchase(beneficiary,weiAmount);
    }
    function _processPurchase(address beneficiary, uint256 tokenAmount) override(PostDeliveryCrowdsale, Crowdsale)  internal {
        PostDeliveryCrowdsale._processPurchase(beneficiary, tokenAmount);
    }
    function _updatePurchasingState(address beneficiary, uint256 weiAmount) override(IndividuallyCappedCrowdsale, Crowdsale) internal {
        IndividuallyCappedCrowdsale._updatePurchasingState(beneficiary, weiAmount);
    }
}