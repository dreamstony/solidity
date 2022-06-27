pragma solidity ^0.8.0;

import "hardhat/console.sol";
contract Tasking07{
    //发布
    //0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
    //构造
    //0x617F2E2fD72FD9D5503197092aC168c91465E7f2
    //mint
    //0x17F6AD8Ef982297579C203069C1DbfFE4348c372
    address public ownerAccount;
    address[] private adminAccounts; 
    bool private isRole;

    uint256 feeNum;
    address feeAccount;
    mapping(address=>uint256) public balances;

    constructor(address _feeAccount,uint256 _feeNum){
        feeAccount = _feeAccount;
        feeNum = _feeNum;
        ownerAccount = msg.sender;
        adminAccounts.push(ownerAccount);
        //增加一些默认管理员用户以及构造的用户 
        adminAccounts.push(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        adminAccounts.push(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
        adminAccounts.push(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);
        adminAccounts.push(_feeAccount);
    }

    modifier onlyOwner(){
        isRole = msg.sender == ownerAccount?true:false;
        console.log("isRole '%s'" , isRole);
        //判断是否为发布者合约地址
        if(!isRole){
            //循环判断是否有管理员权限
            for(uint32 i = 0; i< adminAccounts.length;i++){
                if(adminAccounts[i] == msg.sender){
                    isRole = true;
                    break;
                }
            }
        }
        require(isRole,"not is owner account");
        _;
    }

    function mint(address _account,uint256 amount) public onlyOwner{
        balances[_account] = amount;
    }

    function getBalance(address _account)public view returns(uint256){
        return balances[_account];
    }
}