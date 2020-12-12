package kr.co.reo.admin.pay.service;

import io.reactivex.Flowable;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.Callable;
import org.web3j.abi.EventEncoder;
import org.web3j.abi.TypeReference;
import org.web3j.abi.datatypes.Address;
import org.web3j.abi.datatypes.Bool;
import org.web3j.abi.datatypes.Event;
import org.web3j.abi.datatypes.Function;
import org.web3j.abi.datatypes.Type;
import org.web3j.abi.datatypes.Utf8String;
import org.web3j.abi.datatypes.generated.Uint256;
import org.web3j.abi.datatypes.generated.Uint64;
import org.web3j.crypto.Credentials;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.DefaultBlockParameter;
import org.web3j.protocol.core.RemoteCall;
import org.web3j.protocol.core.RemoteFunctionCall;
import org.web3j.protocol.core.methods.request.EthFilter;
import org.web3j.protocol.core.methods.response.BaseEventResponse;
import org.web3j.protocol.core.methods.response.Log;
import org.web3j.protocol.core.methods.response.TransactionReceipt;
import org.web3j.tuples.generated.Tuple7;
import org.web3j.tx.Contract;
import org.web3j.tx.TransactionManager;
import org.web3j.tx.gas.ContractGasProvider;

/**
 * <p>Auto generated code.
 * <p><strong>Do not modify!</strong>
 * <p>Please use the <a href="https://docs.web3j.io/command_line.html">web3j command line tools</a>,
 * or the org.web3j.codegen.SolidityFunctionWrapperGenerator in the 
 * <a href="https://github.com/web3j/web3j/tree/master/codegen">codegen module</a> to update.
 *
 * <p>Generated with web3j version 4.6.1.
 */
@SuppressWarnings("rawtypes")
public class REOContract extends Contract {
    public static final String BINARY = "6080604052600060055534801561001557600080fd5b506100487f01ffc9a70000000000000000000000000000000000000000000000000000000064010000000061007f810204565b61007a7f80ac58cd0000000000000000000000000000000000000000000000000000000064010000000061007f810204565b61014d565b7fffffffff00000000000000000000000000000000000000000000000000000000808216141561011057604080517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152601c60248201527f4552433136353a20696e76616c696420696e7465726661636520696400000000604482015290519081900360640190fd5b7fffffffff00000000000000000000000000000000000000000000000000000000166000908152602081905260409020805460ff19166001179055565b6119b58061015c6000396000f3fe6080604052600436106100cf5763ffffffff7c010000000000000000000000000000000000000000000000000000000060003504166301ffc9a781146100d4578063081812fc14610131578063095ea7b31461017757806314ff5ea3146101b257806323b872dd146101ee5780633725a5bf1461023157806342842e0e146103c95780635539f4031461040c5780636352211e1461054b57806370a0823114610575578063a22cb465146105a8578063a87d942c146105e3578063b88d4fde146105f8578063e985e9c5146106cb575b600080fd5b3480156100e057600080fd5b5061011d600480360360208110156100f757600080fd5b50357bffffffffffffffffffffffffffffffffffffffffffffffffffffffff1916610706565b604080519115158252519081900360200190f35b34801561013d57600080fd5b5061015b6004803603602081101561015457600080fd5b503561073a565b60408051600160a060020a039092168252519081900360200190f35b34801561018357600080fd5b506101b06004803603604081101561019a57600080fd5b50600160a060020a0381351690602001356107dd565b005b3480156101be57600080fd5b506101dc600480360360208110156101d557600080fd5b5035610975565b60408051918252519081900360200190f35b3480156101fa57600080fd5b506101b06004803603606081101561021157600080fd5b50600160a060020a03813581169160208101359091169060400135610987565b34801561023d57600080fd5b5061025b6004803603602081101561025457600080fd5b5035610a1d565b604080516060810186905267ffffffffffffffff808616608083015260a08201859052831660c082015260e08082528951908201528851909182916020808401928401916101008501918d019080838360005b838110156102c65781810151838201526020016102ae565b50505050905090810190601f1680156102f35780820380516001836020036101000a031916815260200191505b5084810383528a5181528a516020918201918c019080838360005b8381101561032657818101518382015260200161030e565b50505050905090810190601f1680156103535780820380516001836020036101000a031916815260200191505b5084810382528951815289516020918201918b019080838360005b8381101561038657818101518382015260200161036e565b50505050905090810190601f1680156103b35780820380516001836020036101000a031916815260200191505b509a505050505050505050505060405180910390f35b3480156103d557600080fd5b506101b0600480360360608110156103ec57600080fd5b50600160a060020a03813581169160208101359091169060400135610c9b565b6101b0600480360361010081101561042357600080fd5b81019060208101813564010000000081111561043e57600080fd5b82018360208201111561045057600080fd5b8035906020019184600183028401116401000000008311171561047257600080fd5b91939092909160208101903564010000000081111561049057600080fd5b8201836020820111156104a257600080fd5b803590602001918460018302840111640100000000831117156104c457600080fd5b9193909290916020810190356401000000008111156104e257600080fd5b8201836020820111156104f457600080fd5b8035906020019184600183028401116401000000008311171561051657600080fd5b919350915067ffffffffffffffff81358116916020810135821691604082013581169160608101359091169060800135610cb7565b34801561055757600080fd5b5061015b6004803603602081101561056e57600080fd5b5035610ed7565b34801561058157600080fd5b506101dc6004803603602081101561059857600080fd5b5035600160a060020a0316610f72565b3480156105b457600080fd5b506101b0600480360360408110156105cb57600080fd5b50600160a060020a038135169060200135151561101b565b3480156105ef57600080fd5b506101dc6110ea565b34801561060457600080fd5b506101b06004803603608081101561061b57600080fd5b600160a060020a0382358116926020810135909116916040820135919081019060808101606082013564010000000081111561065657600080fd5b82018360208201111561066857600080fd5b8035906020019184600183028401116401000000008311171561068a57600080fd5b91908080601f0160208091040260200160405190810160405280939291908181526020018383808284376000920191909152509295506110f1945050505050565b3480156106d757600080fd5b5061011d600480360360408110156106ee57600080fd5b50600160a060020a038135811691602001351661118a565b7bffffffffffffffffffffffffffffffffffffffffffffffffffffffff191660009081526020819052604090205460ff1690565b6000610745826111b8565b15156107c1576040805160e560020a62461bcd02815260206004820152602c60248201527f4552433732313a20617070726f76656420717565727920666f72206e6f6e657860448201527f697374656e7420746f6b656e0000000000000000000000000000000000000000606482015290519081900360840190fd5b50600090815260026020526040902054600160a060020a031690565b60006107e882610ed7565b9050600160a060020a038381169082161415610874576040805160e560020a62461bcd02815260206004820152602160248201527f4552433732313a20617070726f76616c20746f2063757272656e74206f776e6560448201527f7200000000000000000000000000000000000000000000000000000000000000606482015290519081900360840190fd5b33600160a060020a03821614806108905750610890813361118a565b151561090c576040805160e560020a62461bcd02815260206004820152603860248201527f4552433732313a20617070726f76652063616c6c6572206973206e6f74206f7760448201527f6e6572206e6f7220617070726f76656420666f7220616c6c0000000000000000606482015290519081900360840190fd5b600082815260026020526040808220805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a0387811691821790925591518593918516917f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b92591a4505050565b60009081526006602052604090205490565b61099133826111d5565b1515610a0d576040805160e560020a62461bcd02815260206004820152603160248201527f4552433732313a207472616e736665722063616c6c6572206973206e6f74206f60448201527f776e6572206e6f7220617070726f766564000000000000000000000000000000606482015290519081900360840190fd5b610a188383836112ba565b505050565b600081815260076020526040812060609182918291908190819081908101805460408051602060026001851615610100026000190190941693909304601f81018490048402820184019092528181529291830182828015610abf5780601f10610a9457610100808354040283529160200191610abf565b820191906000526020600020905b815481529060010190602001808311610aa257829003601f168201915b50505060008b815260076020526040902092995060019150610ade9050565b01805460408051602060026001851615610100026000190190941693909304601f81018490048402820184019092528181529291830182828015610b635780601f10610b3857610100808354040283529160200191610b63565b820191906000526020600020905b815481529060010190602001808311610b4657829003601f168201915b50505060008b815260076020526040902092985060029150610b829050565b01805460408051602060026001851615610100026000190190941693909304601f81018490048402820184019092528181529291830182828015610c075780601f10610bdc57610100808354040283529160200191610c07565b820191906000526020600020905b815481529060010190602001808311610bea57829003601f168201915b50505060008b81526007602052604081209398506003909301929150610c2a9050565b6004808204929092015460009a8b5260076020526040909a209091015497999698959760039091166008026101000a90950467ffffffffffffffff90811696818716966801000000000000000081048316965070010000000000000000000000000000000090049091169350915050565b610a1883838360206040519081016040528060008152506110f1565b610cbf6116dc565b6040805160806020601f8f018190040282018101909252606081018d815290918291908f908f9081908501838280828437600092019190915250505090825250604080516020601f8e018190048102820181019092528c815291810191908d908d9081908401838280828437600092019190915250505090825250604080516020601f8c018190048102820181019092528a815291810191908b908b908190840183828082843760009201919091525050509152509050610d7e611704565b50604080516020810190915267ffffffffffffffff87168152610d9f611723565b506040805160608101825267ffffffffffffffff80891682528781166020830152861691810191909152610dd1611742565b5060408051606081018252848152602080820185905281830184905260008781526007909152919091208151829190610e0d9082906003611775565b506020820151610e2390600383019060016117c5565b506040820151610e3990600483019060036117c5565b50506005805460009081526006602090815260408083208a905583546001908101909455898352928152828220805473ffffffffffffffffffffffffffffffffffffffff19163390811790915582526003905220610e97915061148a565b604051859033906000907fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef908290a4505050505050505050505050505050565b600081815260016020526040812054600160a060020a0316801515610f6c576040805160e560020a62461bcd02815260206004820152602960248201527f4552433732313a206f776e657220717565727920666f72206e6f6e657869737460448201527f656e7420746f6b656e0000000000000000000000000000000000000000000000606482015290519081900360840190fd5b92915050565b6000600160a060020a0382161515610ffa576040805160e560020a62461bcd02815260206004820152602a60248201527f4552433732313a2062616c616e636520717565727920666f7220746865207a6560448201527f726f206164647265737300000000000000000000000000000000000000000000606482015290519081900360840190fd5b600160a060020a0382166000908152600360205260409020610f6c90611493565b600160a060020a03821633141561107c576040805160e560020a62461bcd02815260206004820152601960248201527f4552433732313a20617070726f766520746f2063616c6c657200000000000000604482015290519081900360640190fd5b336000818152600460209081526040808320600160a060020a03871680855290835292819020805460ff1916861515908117909155815190815290519293927f17307eab39ab6107e8899845ad3d59bd9653f200f220920489ca2b5937696c31929181900390910190a35050565b6005545b90565b6110fc848484610987565b61110884848484611497565b1515611184576040805160e560020a62461bcd02815260206004820152603260248201527f4552433732313a207472616e7366657220746f206e6f6e20455243373231526560448201527f63656976657220696d706c656d656e7465720000000000000000000000000000606482015290519081900360840190fd5b50505050565b600160a060020a03918216600090815260046020908152604080832093909416825291909152205460ff1690565b600090815260016020526040902054600160a060020a0316151590565b60006111e0826111b8565b151561125c576040805160e560020a62461bcd02815260206004820152602c60248201527f4552433732313a206f70657261746f7220717565727920666f72206e6f6e657860448201527f697374656e7420746f6b656e0000000000000000000000000000000000000000606482015290519081900360840190fd5b600061126783610ed7565b905080600160a060020a031684600160a060020a031614806112a2575083600160a060020a03166112978461073a565b600160a060020a0316145b806112b257506112b2818561118a565b949350505050565b82600160a060020a03166112cd82610ed7565b600160a060020a031614611351576040805160e560020a62461bcd02815260206004820152602960248201527f4552433732313a207472616e73666572206f6620746f6b656e2074686174206960448201527f73206e6f74206f776e0000000000000000000000000000000000000000000000606482015290519081900360840190fd5b600160a060020a03821615156113d6576040805160e560020a62461bcd028152602060048201526024808201527f4552433732313a207472616e7366657220746f20746865207a65726f2061646460448201527f7265737300000000000000000000000000000000000000000000000000000000606482015290519081900360840190fd5b6113df81611613565b600160a060020a03831660009081526003602052604090206114009061165d565b600160a060020a03821660009081526003602052604090206114219061148a565b600081815260016020526040808220805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a0386811691821790925591518493918716917fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef91a4505050565b80546001019055565b5490565b60006114ab84600160a060020a0316611674565b15156114b9575060016112b2565b6040517f150b7a020000000000000000000000000000000000000000000000000000000081523360048201818152600160a060020a03888116602485015260448401879052608060648501908152865160848601528651600095928a169463150b7a029490938c938b938b939260a4019060208501908083838e5b8381101561154c578181015183820152602001611534565b50505050905090810190601f1680156115795780820380516001836020036101000a031916815260200191505b5095505050505050602060405180830381600087803b15801561159b57600080fd5b505af11580156115af573d6000803e3d6000fd5b505050506040513d60208110156115c557600080fd5b50517bffffffffffffffffffffffffffffffffffffffffffffffffffffffff19167f150b7a020000000000000000000000000000000000000000000000000000000014915050949350505050565b600081815260026020526040902054600160a060020a03161561165a576000818152600260205260409020805473ffffffffffffffffffffffffffffffffffffffff191690555b50565b805461167090600163ffffffff61167c16565b9055565b6000903b1190565b6000828211156116d6576040805160e560020a62461bcd02815260206004820152601e60248201527f536166654d6174683a207375627472616374696f6e206f766572666c6f770000604482015290519081900360640190fd5b50900390565b6060604051908101604052806003905b60608152602001906001900390816116ec5790505090565b6020604051908101604052806001906020820280388339509192915050565b6060604051908101604052806003906020820280388339509192915050565b60e0604051908101604052806117566116dc565b8152602001611763611704565b8152602001611770611723565b905290565b82600381019282156117b5579160200282015b828111156117b557825180516117a5918491602090910190611869565b5091602001919060010190611788565b506117c19291506118e3565b5090565b60018301918390821561185d5791602002820160005b8382111561182757835183826101000a81548167ffffffffffffffff021916908367ffffffffffffffff16021790555092602001926008016020816007010492830192600103026117db565b801561185b5782816101000a81549067ffffffffffffffff0219169055600801602081600701049283019260010302611827565b505b506117c1929150611906565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106118aa57805160ff19168380011785556118d7565b828001600101855582156118d7579182015b828111156118d75782518255916020019190600101906118bc565b506117c192915061192b565b6110ee91905b808211156117c15760006118fd8282611945565b506001016118e9565b6110ee91905b808211156117c157805467ffffffffffffffff1916815560010161190c565b6110ee91905b808211156117c15760008155600101611931565b50805460018160011615610100020316600290046000825580601f1061196b575061165a565b601f01602090049060005260206000209081019061165a919061192b56fea165627a7a72305820970ce3088c07c2f2dcdb5ff767caae8915c9d02e856c715d36412217850609160029";

    public static final String FUNC_SUPPORTSINTERFACE = "supportsInterface";

    public static final String FUNC_GETAPPROVED = "getApproved";

    public static final String FUNC_APPROVE = "approve";

    public static final String FUNC_GETTOKENID = "getTokenId";

    public static final String FUNC_TRANSFERFROM = "transferFrom";

    public static final String FUNC_REOCONTRACT = "reocontract";

    public static final String FUNC_safeTransferFrom = "safeTransferFrom";

    public static final String FUNC__MINT = "_mint";

    public static final String FUNC_OWNEROF = "ownerOf";

    public static final String FUNC_BALANCEOF = "balanceOf";

    public static final String FUNC_SETAPPROVALFORALL = "setApprovalForAll";

    public static final String FUNC_GETCOUNT = "getCount";

    public static final String FUNC_ISAPPROVEDFORALL = "isApprovedForAll";

    public static final Event TRANSFER_EVENT = new Event("Transfer", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Address>(true) {}, new TypeReference<Address>(true) {}, new TypeReference<Uint256>(true) {}));
    ;

    public static final Event APPROVAL_EVENT = new Event("Approval", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Address>(true) {}, new TypeReference<Address>(true) {}, new TypeReference<Uint256>(true) {}));
    ;

    public static final Event APPROVALFORALL_EVENT = new Event("ApprovalForAll", 
            Arrays.<TypeReference<?>>asList(new TypeReference<Address>(true) {}, new TypeReference<Address>(true) {}, new TypeReference<Bool>() {}));
    ;

    @Deprecated
    protected REOContract(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        super(BINARY, contractAddress, web3j, credentials, gasPrice, gasLimit);
    }

    protected REOContract(String contractAddress, Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, web3j, credentials, contractGasProvider);
    }

    @Deprecated
    protected REOContract(String contractAddress, Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        super(BINARY, contractAddress, web3j, transactionManager, gasPrice, gasLimit);
    }

    protected REOContract(String contractAddress, Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, web3j, transactionManager, contractGasProvider);
    }

    public RemoteFunctionCall<Boolean> supportsInterface(byte[] interfaceId) {
        final Function function = new Function(FUNC_SUPPORTSINTERFACE, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.generated.Bytes4(interfaceId)), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Bool>() {}));
        return executeRemoteCallSingleValueReturn(function, Boolean.class);
    }

    public RemoteFunctionCall<String> getApproved(BigInteger tokenId) {
        final Function function = new Function(FUNC_GETAPPROVED, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.generated.Uint256(tokenId)), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Address>() {}));
        return executeRemoteCallSingleValueReturn(function, String.class);
    }

    public RemoteFunctionCall<TransactionReceipt> approve(String to, BigInteger tokenId) {
        final Function function = new Function(
                FUNC_APPROVE, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Address(160, to), 
                new org.web3j.abi.datatypes.generated.Uint256(tokenId)), 
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<BigInteger> getTokenId(BigInteger _count) {
        final Function function = new Function(FUNC_GETTOKENID, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.generated.Uint256(_count)), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Uint256>() {}));
        return executeRemoteCallSingleValueReturn(function, BigInteger.class);
    }

    public RemoteFunctionCall<TransactionReceipt> transferFrom(String from, String to, BigInteger tokenId) {
        final Function function = new Function(
                FUNC_TRANSFERFROM, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Address(160, from), 
                new org.web3j.abi.datatypes.Address(160, to), 
                new org.web3j.abi.datatypes.generated.Uint256(tokenId)), 
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<Tuple7<String, String, String, BigInteger, BigInteger, BigInteger, BigInteger>> reocontract(BigInteger tokenId) {
        final Function function = new Function(FUNC_REOCONTRACT, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.generated.Uint256(tokenId)), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Utf8String>() {}, new TypeReference<Utf8String>() {}, new TypeReference<Utf8String>() {}, new TypeReference<Uint256>() {}, new TypeReference<Uint64>() {}, new TypeReference<Uint256>() {}, new TypeReference<Uint64>() {}));
        return new RemoteFunctionCall<Tuple7<String, String, String, BigInteger, BigInteger, BigInteger, BigInteger>>(function,
                new Callable<Tuple7<String, String, String, BigInteger, BigInteger, BigInteger, BigInteger>>() {
                    @Override
                    public Tuple7<String, String, String, BigInteger, BigInteger, BigInteger, BigInteger> call() throws Exception {
                        List<Type> results = executeCallMultipleValueReturn(function);
                        return new Tuple7<String, String, String, BigInteger, BigInteger, BigInteger, BigInteger>(
                                (String) results.get(0).getValue(), 
                                (String) results.get(1).getValue(), 
                                (String) results.get(2).getValue(), 
                                (BigInteger) results.get(3).getValue(), 
                                (BigInteger) results.get(4).getValue(), 
                                (BigInteger) results.get(5).getValue(), 
                                (BigInteger) results.get(6).getValue());
                    }
                });
    }

    public RemoteFunctionCall<TransactionReceipt> safeTransferFrom(String from, String to, BigInteger tokenId) {
        final Function function = new Function(
                FUNC_safeTransferFrom, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Address(160, from), 
                new org.web3j.abi.datatypes.Address(160, to), 
                new org.web3j.abi.datatypes.generated.Uint256(tokenId)), 
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<TransactionReceipt> _mint(String _name, String _id, String _location, BigInteger _price, BigInteger _payday, BigInteger _startdate, BigInteger _enddate, BigInteger tokenId, BigInteger weiValue) {
        final Function function = new Function(
                FUNC__MINT, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Utf8String(_name), 
                new org.web3j.abi.datatypes.Utf8String(_id), 
                new org.web3j.abi.datatypes.Utf8String(_location), 
                new org.web3j.abi.datatypes.generated.Uint64(_price), 
                new org.web3j.abi.datatypes.generated.Uint64(_payday), 
                new org.web3j.abi.datatypes.generated.Uint64(_startdate), 
                new org.web3j.abi.datatypes.generated.Uint64(_enddate), 
                new org.web3j.abi.datatypes.generated.Uint256(tokenId)), 
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function, weiValue);
    }

    public RemoteFunctionCall<String> ownerOf(BigInteger tokenId) {
        final Function function = new Function(FUNC_OWNEROF, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.generated.Uint256(tokenId)), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Address>() {}));
        return executeRemoteCallSingleValueReturn(function, String.class);
    }

    public RemoteFunctionCall<BigInteger> balanceOf(String owner) {
        final Function function = new Function(FUNC_BALANCEOF, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Address(160, owner)), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Uint256>() {}));
        return executeRemoteCallSingleValueReturn(function, BigInteger.class);
    }

    public RemoteFunctionCall<TransactionReceipt> setApprovalForAll(String to, Boolean approved) {
        final Function function = new Function(
                FUNC_SETAPPROVALFORALL, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Address(160, to), 
                new org.web3j.abi.datatypes.Bool(approved)), 
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<BigInteger> getCount() {
        final Function function = new Function(FUNC_GETCOUNT, 
                Arrays.<Type>asList(), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Uint256>() {}));
        return executeRemoteCallSingleValueReturn(function, BigInteger.class);
    }

    public RemoteFunctionCall<TransactionReceipt> safeTransferFrom(String from, String to, BigInteger tokenId, byte[] _data) {
        final Function function = new Function(
                FUNC_safeTransferFrom, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Address(160, from), 
                new org.web3j.abi.datatypes.Address(160, to), 
                new org.web3j.abi.datatypes.generated.Uint256(tokenId), 
                new org.web3j.abi.datatypes.DynamicBytes(_data)), 
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<Boolean> isApprovedForAll(String owner, String operator) {
        final Function function = new Function(FUNC_ISAPPROVEDFORALL, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Address(160, owner), 
                new org.web3j.abi.datatypes.Address(160, operator)), 
                Arrays.<TypeReference<?>>asList(new TypeReference<Bool>() {}));
        return executeRemoteCallSingleValueReturn(function, Boolean.class);
    }

    public List<TransferEventResponse> getTransferEvents(TransactionReceipt transactionReceipt) {
        List<Contract.EventValuesWithLog> valueList = extractEventParametersWithLog(TRANSFER_EVENT, transactionReceipt);
        ArrayList<TransferEventResponse> responses = new ArrayList<TransferEventResponse>(valueList.size());
        for (Contract.EventValuesWithLog eventValues : valueList) {
            TransferEventResponse typedResponse = new TransferEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.from = (String) eventValues.getIndexedValues().get(0).getValue();
            typedResponse.to = (String) eventValues.getIndexedValues().get(1).getValue();
            typedResponse.tokenId = (BigInteger) eventValues.getIndexedValues().get(2).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<TransferEventResponse> transferEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, TransferEventResponse>() {
            @Override
            public TransferEventResponse apply(Log log) {
                Contract.EventValuesWithLog eventValues = extractEventParametersWithLog(TRANSFER_EVENT, log);
                TransferEventResponse typedResponse = new TransferEventResponse();
                typedResponse.log = log;
                typedResponse.from = (String) eventValues.getIndexedValues().get(0).getValue();
                typedResponse.to = (String) eventValues.getIndexedValues().get(1).getValue();
                typedResponse.tokenId = (BigInteger) eventValues.getIndexedValues().get(2).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<TransferEventResponse> transferEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(TRANSFER_EVENT));
        return transferEventFlowable(filter);
    }

    public List<ApprovalEventResponse> getApprovalEvents(TransactionReceipt transactionReceipt) {
        List<Contract.EventValuesWithLog> valueList = extractEventParametersWithLog(APPROVAL_EVENT, transactionReceipt);
        ArrayList<ApprovalEventResponse> responses = new ArrayList<ApprovalEventResponse>(valueList.size());
        for (Contract.EventValuesWithLog eventValues : valueList) {
            ApprovalEventResponse typedResponse = new ApprovalEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.owner = (String) eventValues.getIndexedValues().get(0).getValue();
            typedResponse.approved = (String) eventValues.getIndexedValues().get(1).getValue();
            typedResponse.tokenId = (BigInteger) eventValues.getIndexedValues().get(2).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<ApprovalEventResponse> approvalEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, ApprovalEventResponse>() {
            @Override
            public ApprovalEventResponse apply(Log log) {
                Contract.EventValuesWithLog eventValues = extractEventParametersWithLog(APPROVAL_EVENT, log);
                ApprovalEventResponse typedResponse = new ApprovalEventResponse();
                typedResponse.log = log;
                typedResponse.owner = (String) eventValues.getIndexedValues().get(0).getValue();
                typedResponse.approved = (String) eventValues.getIndexedValues().get(1).getValue();
                typedResponse.tokenId = (BigInteger) eventValues.getIndexedValues().get(2).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<ApprovalEventResponse> approvalEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(APPROVAL_EVENT));
        return approvalEventFlowable(filter);
    }

    public List<ApprovalForAllEventResponse> getApprovalForAllEvents(TransactionReceipt transactionReceipt) {
        List<Contract.EventValuesWithLog> valueList = extractEventParametersWithLog(APPROVALFORALL_EVENT, transactionReceipt);
        ArrayList<ApprovalForAllEventResponse> responses = new ArrayList<ApprovalForAllEventResponse>(valueList.size());
        for (Contract.EventValuesWithLog eventValues : valueList) {
            ApprovalForAllEventResponse typedResponse = new ApprovalForAllEventResponse();
            typedResponse.log = eventValues.getLog();
            typedResponse.owner = (String) eventValues.getIndexedValues().get(0).getValue();
            typedResponse.operator = (String) eventValues.getIndexedValues().get(1).getValue();
            typedResponse.approved = (Boolean) eventValues.getNonIndexedValues().get(0).getValue();
            responses.add(typedResponse);
        }
        return responses;
    }

    public Flowable<ApprovalForAllEventResponse> approvalForAllEventFlowable(EthFilter filter) {
        return web3j.ethLogFlowable(filter).map(new io.reactivex.functions.Function<Log, ApprovalForAllEventResponse>() {
            @Override
            public ApprovalForAllEventResponse apply(Log log) {
                Contract.EventValuesWithLog eventValues = extractEventParametersWithLog(APPROVALFORALL_EVENT, log);
                ApprovalForAllEventResponse typedResponse = new ApprovalForAllEventResponse();
                typedResponse.log = log;
                typedResponse.owner = (String) eventValues.getIndexedValues().get(0).getValue();
                typedResponse.operator = (String) eventValues.getIndexedValues().get(1).getValue();
                typedResponse.approved = (Boolean) eventValues.getNonIndexedValues().get(0).getValue();
                return typedResponse;
            }
        });
    }

    public Flowable<ApprovalForAllEventResponse> approvalForAllEventFlowable(DefaultBlockParameter startBlock, DefaultBlockParameter endBlock) {
        EthFilter filter = new EthFilter(startBlock, endBlock, getContractAddress());
        filter.addSingleTopic(EventEncoder.encode(APPROVALFORALL_EVENT));
        return approvalForAllEventFlowable(filter);
    }

    @Deprecated
    public static REOContract load(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        return new REOContract(contractAddress, web3j, credentials, gasPrice, gasLimit);
    }

    @Deprecated
    public static REOContract load(String contractAddress, Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        return new REOContract(contractAddress, web3j, transactionManager, gasPrice, gasLimit);
    }

    public static REOContract load(String contractAddress, Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        return new REOContract(contractAddress, web3j, credentials, contractGasProvider);
    }

    public static REOContract load(String contractAddress, Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return new REOContract(contractAddress, web3j, transactionManager, contractGasProvider);
    }

    public static RemoteCall<REOContract> deploy(Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(REOContract.class, web3j, credentials, contractGasProvider, BINARY, "");
    }

    public static RemoteCall<REOContract> deploy(Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(REOContract.class, web3j, transactionManager, contractGasProvider, BINARY, "");
    }

    @Deprecated
    public static RemoteCall<REOContract> deploy(Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        return deployRemoteCall(REOContract.class, web3j, credentials, gasPrice, gasLimit, BINARY, "");
    }

    @Deprecated
    public static RemoteCall<REOContract> deploy(Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        return deployRemoteCall(REOContract.class, web3j, transactionManager, gasPrice, gasLimit, BINARY, "");
    }

    public static class TransferEventResponse extends BaseEventResponse {
        public String from;

        public String to;

        public BigInteger tokenId;
    }

    public static class ApprovalEventResponse extends BaseEventResponse {
        public String owner;

        public String approved;

        public BigInteger tokenId;
    }

    public static class ApprovalForAllEventResponse extends BaseEventResponse {
        public String owner;

        public String operator;

        public Boolean approved;
    }
}
