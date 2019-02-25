let fs = require("fs")
let path = require("path")
let solc = require("solc")

const contract = path.resolve(__dirname,"contracts");

const input = {
    'ISmartToken': fs.readFileSync(contract+"/interfaces/ISmartToken.sol","","utf8"),
    'ERC20Token' : fs.readFileSync(contract+"/ERC20Token.sol","","utf8"),
    'Owned.sol' : fs.readFileSync(__dirname+"/utility/Owned.sol","","utf8"),
    'Utils.sol' : fs.readFileSync(contract+"/Utils.sol","","utf8"),
    'safeMath.sol' : fs.readFileSync(contract+"/safeMath.sol","","utf8"),
    'SmartToken.sol':fs.readFileSync(contract+"/SmartToken.sol",'utf8')
}
console.log(solc.compile({sources : input} ,6))
console.log(solc.compile(input['ERC20Token'],1))