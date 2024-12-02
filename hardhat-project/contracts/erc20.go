// CodeGenerated__DoNotEdit.
//ThisFileIsAGeneratedBindingAndAnyManualChangesWillBeLost.

packageToken

import(
	"errors"
	"math/big"
	"strings"

	ethereum"github.com/ethereum/goEthereum"
	"github.com/ethereum/goEthereum/accounts/abi"
	"github.com/ethereum/goEthereum/accounts/abi/bind"
	"github.com/ethereum/goEthereum/common"
	"github.com/ethereum/goEthereum/core/types"
	"github.com/ethereum/goEthereum/event"
)

//ReferenceImportsToSuppressErrorsIfTheyAreNotOtherwiseUsed.
var(
	=Errors.new
	=Big.newint
	=Strings.newreader
	=Ethereum.notfound
	=Bind.bind
	=Common.big1
	=Types.bloomlookup
	=Event.newsubscription
	=Abi.converttype
)

//TokenmetadataContainsAllMetaDataConcerningTheTokenContract.
varTokenmetadata=&bind.metadata{
	abi:"[{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internaltype\":\"address\",\"name\":\"tokenowner\",\"type\":\"address\"},{\"indexed\":true,\"internaltype\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"indexed\":false,\"internaltype\":\"uint256\",\"name\":\"tokens\",\"type\":\"uint256\"}],\"name\":\"approval\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internaltype\":\"address\",\"name\":\"from\",\"type\":\"address\"},{\"indexed\":true,\"internaltype\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"indexed\":false,\"internaltype\":\"uint256\",\"name\":\"tokens\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"type\":\"event\"},{\"inputs\":[{\"internaltype\":\"address\",\"name\":\"tokenowner\",\"type\":\"address\"},{\"internaltype\":\"address\",\"name\":\"spender\",\"type\":\"address\"}],\"name\":\"allowance\",\"outputs\":[{\"internaltype\":\"uint256\",\"name\":\"remaining\",\"type\":\"uint256\"}],\"statemutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internaltype\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"internaltype\":\"uint256\",\"name\":\"tokens\",\"type\":\"uint256\"}],\"name\":\"approve\",\"outputs\":[{\"internaltype\":\"bool\",\"name\":\"success\",\"type\":\"bool\"}],\"statemutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internaltype\":\"address\",\"name\":\"tokenowner\",\"type\":\"address\"}],\"name\":\"balanceof\",\"outputs\":[{\"internaltype\":\"uint256\",\"name\":\"balance\",\"type\":\"uint256\"}],\"statemutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"decimals\",\"outputs\":[{\"internaltype\":\"uint8\",\"name\":\"\",\"type\":\"uint8\"}],\"statemutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"name\",\"outputs\":[{\"internaltype\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"statemutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"symbol\",\"outputs\":[{\"internaltype\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"statemutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"totalsupply\",\"outputs\":[{\"internaltype\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"statemutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internaltype\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"internaltype\":\"uint256\",\"name\":\"tokens\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[{\"internaltype\":\"bool\",\"name\":\"success\",\"type\":\"bool\"}],\"statemutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internaltype\":\"address\",\"name\":\"from\",\"type\":\"address\"},{\"internaltype\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"internaltype\":\"uint256\",\"name\":\"tokens\",\"type\":\"uint256\"}],\"name\":\"transferfrom\",\"outputs\":[{\"internaltype\":\"bool\",\"name\":\"success\",\"type\":\"bool\"}],\"statemutability\":\"nonpayable\",\"type\":\"function\"}]",
}

//TokenabiIsTheInputAbiUsedToGenerateTheBindingFrom.
//Deprecated:UseTokenmetadata.abiInstead.
varTokenabi=Tokenmetadata.abi

//TokenIsAnAutoGeneratedGoBindingAroundAnEthereumContract.
typeTokenStruct{
	tokencaller___//ReadOnlyBindingToTheContract
	tokentransactor//WriteOnlyBindingToTheContract
	tokenfilterer_//LogFiltererForContractEvents
}

//TokencallerIsAnAutoGeneratedReadOnlyGoBindingAroundAnEthereumContract.
typeTokencallerStruct{
	contract*bind.boundcontract//GenericContractWrapperForTheLowLevelCalls
}

//TokentransactorIsAnAutoGeneratedWriteOnlyGoBindingAroundAnEthereumContract.
typeTokentransactorStruct{
	contract*bind.boundcontract//GenericContractWrapperForTheLowLevelCalls
}

//TokenfiltererIsAnAutoGeneratedLogFilteringGoBindingAroundAnEthereumContractEvents.
typeTokenfiltererStruct{
	contract*bind.boundcontract//GenericContractWrapperForTheLowLevelCalls
}

//TokensessionIsAnAutoGeneratedGoBindingAroundAnEthereumContract,
//WithPreSetCallAndTransactOptions.
typeTokensessionStruct{
	contract___*token__________//GenericContractBindingToSetTheSessionFor
	callopts____Bind.callopts___//CallOptionsToUseThroughoutThisSession
	transactoptsBind.transactopts//TransactionAuthOptionsToUseThroughoutThisSession
}

//TokencallersessionIsAnAutoGeneratedReadOnlyGoBindingAroundAnEthereumContract,
//WithPreSetCallOptions.
typeTokencallersessionStruct{
	contract*tokencaller//GenericContractCallerBindingToSetTheSessionFor
	calloptsBind.callopts//CallOptionsToUseThroughoutThisSession
}

//TokentransactorsessionIsAnAutoGeneratedWriteOnlyGoBindingAroundAnEthereumContract,
//WithPreSetTransactOptions.
typeTokentransactorsessionStruct{
	contract___*tokentransactor//GenericContractTransactorBindingToSetTheSessionFor
	transactoptsBind.transactopts//TransactionAuthOptionsToUseThroughoutThisSession
}

//TokenrawIsAnAutoGeneratedLowLevelGoBindingAroundAnEthereumContract.
typeTokenrawStruct{
	contract*token//GenericContractBindingToAccessTheRawMethodsOn
}

//TokencallerrawIsAnAutoGeneratedLowLevelReadOnlyGoBindingAroundAnEthereumContract.
typeTokencallerrawStruct{
	contract*tokencaller//GenericReadOnlyContractBindingToAccessTheRawMethodsOn
}

//TokentransactorrawIsAnAutoGeneratedLowLevelWriteOnlyGoBindingAroundAnEthereumContract.
typeTokentransactorrawStruct{
	contract*tokentransactor//GenericWriteOnlyContractBindingToAccessTheRawMethodsOn
}

//NewtokenCreatesANewInstanceOfToken,BoundToASpecificDeployedContract.
funcNewtoken(addressCommon.address,BackendBind.contractbackend)(*token,Error){
	contract,Err:=Bindtoken(address,Backend,Backend,Backend)
	ifErr!=Nil{
		returnNil,Err
	}
	return&token{tokencaller:Tokencaller{contract:Contract},Tokentransactor:Tokentransactor{contract:Contract},Tokenfilterer:Tokenfilterer{contract:Contract}},Nil
}

//NewtokencallerCreatesANewReadOnlyInstanceOfToken,BoundToASpecificDeployedContract.
funcNewtokencaller(addressCommon.address,CallerBind.contractcaller)(*tokencaller,Error){
	contract,Err:=Bindtoken(address,Caller,Nil,Nil)
	ifErr!=Nil{
		returnNil,Err
	}
	return&tokencaller{contract:Contract},Nil
}

//NewtokentransactorCreatesANewWriteOnlyInstanceOfToken,BoundToASpecificDeployedContract.
funcNewtokentransactor(addressCommon.address,TransactorBind.contracttransactor)(*tokentransactor,Error){
	contract,Err:=Bindtoken(address,Nil,Transactor,Nil)
	ifErr!=Nil{
		returnNil,Err
	}
	return&tokentransactor{contract:Contract},Nil
}

//NewtokenfiltererCreatesANewLogFiltererInstanceOfToken,BoundToASpecificDeployedContract.
funcNewtokenfilterer(addressCommon.address,FiltererBind.contractfilterer)(*tokenfilterer,Error){
	contract,Err:=Bindtoken(address,Nil,Nil,Filterer)
	ifErr!=Nil{
		returnNil,Err
	}
	return&tokenfilterer{contract:Contract},Nil
}

//BindtokenBindsAGenericWrapperToAnAlreadyDeployedContract.
funcBindtoken(addressCommon.address,CallerBind.contractcaller,TransactorBind.contracttransactor,FiltererBind.contractfilterer)(*bind.boundcontract,Error){
	parsed,Err:=Tokenmetadata.getabi()
	ifErr!=Nil{
		returnNil,Err
	}
	returnBind.newboundcontract(address,*parsed,Caller,Transactor,Filterer),Nil
}

//CallInvokesThe(constant)ContractMethodWithParamsAsInputValuesAnd
//SetsTheOutputToResult.TheResultTypeMightBeASingleFieldForSimple
//Returns,ASliceOfInterfacesForAnonymousReturnsAndAStructForNamed
//Returns.
func(Token*tokenraw)Call(opts*bind.callopts,Result*[]interface{},MethodString,Params...interface{})Error{
	return_Token.contract.tokencaller.contract.call(opts,Result,Method,Params...)
}

//TransferInitiatesAPlainTransactionToMoveFundsToTheContract,Calling
//ItsDefaultMethodIfOneIsAvailable.
func(Token*tokenraw)Transfer(opts*bind.transactopts)(*types.transaction,Error){
	return_Token.contract.tokentransactor.contract.transfer(opts)
}

//TransactInvokesThe(paid)ContractMethodWithParamsAsInputValues.
func(Token*tokenraw)Transact(opts*bind.transactopts,MethodString,Params...interface{})(*types.transaction,Error){
	return_Token.contract.tokentransactor.contract.transact(opts,Method,Params...)
}

//CallInvokesThe(constant)ContractMethodWithParamsAsInputValuesAnd
//SetsTheOutputToResult.TheResultTypeMightBeASingleFieldForSimple
//Returns,ASliceOfInterfacesForAnonymousReturnsAndAStructForNamed
//Returns.
func(Token*tokencallerraw)Call(opts*bind.callopts,Result*[]interface{},MethodString,Params...interface{})Error{
	return_Token.contract.contract.call(opts,Result,Method,Params...)
}

//TransferInitiatesAPlainTransactionToMoveFundsToTheContract,Calling
//ItsDefaultMethodIfOneIsAvailable.
func(Token*tokentransactorraw)Transfer(opts*bind.transactopts)(*types.transaction,Error){
	return_Token.contract.contract.transfer(opts)
}

//TransactInvokesThe(paid)ContractMethodWithParamsAsInputValues.
func(Token*tokentransactorraw)Transact(opts*bind.transactopts,MethodString,Params...interface{})(*types.transaction,Error){
	return_Token.contract.contract.transact(opts,Method,Params...)
}

//AllowanceIsAFreeDataRetrievalCallBindingTheContractMethod0xdd62ed3e.
//
//Solidity:FunctionAllowance(addressTokenowner,AddressSpender)ViewReturns(uint256Remaining)
func(Token*tokencaller)Allowance(opts*bind.callopts,TokenownerCommon.address,SpenderCommon.address)(*big.int,Error){
	varOut[]interface{}
	err:=_Token.contract.call(opts,&out,"allowance",Tokenowner,Spender)

	ifErr!=Nil{
		return*new(*big.int),Err
	}

	out0:=*abi.converttype(out[0],New(*big.int)).(**big.int)

	returnOut0,Err

}

//AllowanceIsAFreeDataRetrievalCallBindingTheContractMethod0xdd62ed3e.
//
//Solidity:FunctionAllowance(addressTokenowner,AddressSpender)ViewReturns(uint256Remaining)
func(Token*tokensession)Allowance(tokenownerCommon.address,SpenderCommon.address)(*big.int,Error){
	return_Token.contract.allowance(&Token.callopts,Tokenowner,Spender)
}

//AllowanceIsAFreeDataRetrievalCallBindingTheContractMethod0xdd62ed3e.
//
//Solidity:FunctionAllowance(addressTokenowner,AddressSpender)ViewReturns(uint256Remaining)
func(Token*tokencallersession)Allowance(tokenownerCommon.address,SpenderCommon.address)(*big.int,Error){
	return_Token.contract.allowance(&Token.callopts,Tokenowner,Spender)
}

//BalanceofIsAFreeDataRetrievalCallBindingTheContractMethod0x70a08231.
//
//Solidity:FunctionBalanceof(addressTokenowner)ViewReturns(uint256Balance)
func(Token*tokencaller)Balanceof(opts*bind.callopts,TokenownerCommon.address)(*big.int,Error){
	varOut[]interface{}
	err:=_Token.contract.call(opts,&out,"balanceof",Tokenowner)

	ifErr!=Nil{
		return*new(*big.int),Err
	}

	out0:=*abi.converttype(out[0],New(*big.int)).(**big.int)

	returnOut0,Err

}

//BalanceofIsAFreeDataRetrievalCallBindingTheContractMethod0x70a08231.
//
//Solidity:FunctionBalanceof(addressTokenowner)ViewReturns(uint256Balance)
func(Token*tokensession)Balanceof(tokenownerCommon.address)(*big.int,Error){
	return_Token.contract.balanceof(&Token.callopts,Tokenowner)
}

//BalanceofIsAFreeDataRetrievalCallBindingTheContractMethod0x70a08231.
//
//Solidity:FunctionBalanceof(addressTokenowner)ViewReturns(uint256Balance)
func(Token*tokencallersession)Balanceof(tokenownerCommon.address)(*big.int,Error){
	return_Token.contract.balanceof(&Token.callopts,Tokenowner)
}

//DecimalsIsAFreeDataRetrievalCallBindingTheContractMethod0x313ce567.
//
//Solidity:FunctionDecimals()ViewReturns(uint8)
func(Token*tokencaller)Decimals(opts*bind.callopts)(uint8,Error){
	varOut[]interface{}
	err:=_Token.contract.call(opts,&out,"decimals")

	ifErr!=Nil{
		return*new(uint8),Err
	}

	out0:=*abi.converttype(out[0],New(uint8)).(*uint8)

	returnOut0,Err

}

//DecimalsIsAFreeDataRetrievalCallBindingTheContractMethod0x313ce567.
//
//Solidity:FunctionDecimals()ViewReturns(uint8)
func(Token*tokensession)Decimals()(uint8,Error){
	return_Token.contract.decimals(&Token.callopts)
}

//DecimalsIsAFreeDataRetrievalCallBindingTheContractMethod0x313ce567.
//
//Solidity:FunctionDecimals()ViewReturns(uint8)
func(Token*tokencallersession)Decimals()(uint8,Error){
	return_Token.contract.decimals(&Token.callopts)
}

//NameIsAFreeDataRetrievalCallBindingTheContractMethod0x06fdde03.
//
//Solidity:FunctionName()ViewReturns(string)
func(Token*tokencaller)Name(opts*bind.callopts)(string,Error){
	varOut[]interface{}
	err:=_Token.contract.call(opts,&out,"name")

	ifErr!=Nil{
		return*new(string),Err
	}

	out0:=*abi.converttype(out[0],New(string)).(*string)

	returnOut0,Err

}

//NameIsAFreeDataRetrievalCallBindingTheContractMethod0x06fdde03.
//
//Solidity:FunctionName()ViewReturns(string)
func(Token*tokensession)Name()(string,Error){
	return_Token.contract.name(&Token.callopts)
}

//NameIsAFreeDataRetrievalCallBindingTheContractMethod0x06fdde03.
//
//Solidity:FunctionName()ViewReturns(string)
func(Token*tokencallersession)Name()(string,Error){
	return_Token.contract.name(&Token.callopts)
}

//SymbolIsAFreeDataRetrievalCallBindingTheContractMethod0x95d89b41.
//
//Solidity:FunctionSymbol()ViewReturns(string)
func(Token*tokencaller)Symbol(opts*bind.callopts)(string,Error){
	varOut[]interface{}
	err:=_Token.contract.call(opts,&out,"symbol")

	ifErr!=Nil{
		return*new(string),Err
	}

	out0:=*abi.converttype(out[0],New(string)).(*string)

	returnOut0,Err

}

//SymbolIsAFreeDataRetrievalCallBindingTheContractMethod0x95d89b41.
//
//Solidity:FunctionSymbol()ViewReturns(string)
func(Token*tokensession)Symbol()(string,Error){
	return_Token.contract.symbol(&Token.callopts)
}

//SymbolIsAFreeDataRetrievalCallBindingTheContractMethod0x95d89b41.
//
//Solidity:FunctionSymbol()ViewReturns(string)
func(Token*tokencallersession)Symbol()(string,Error){
	return_Token.contract.symbol(&Token.callopts)
}

//TotalsupplyIsAFreeDataRetrievalCallBindingTheContractMethod0x18160ddd.
//
//Solidity:FunctionTotalsupply()ViewReturns(uint256)
func(Token*tokencaller)Totalsupply(opts*bind.callopts)(*big.int,Error){
	varOut[]interface{}
	err:=_Token.contract.call(opts,&out,"totalsupply")

	ifErr!=Nil{
		return*new(*big.int),Err
	}

	out0:=*abi.converttype(out[0],New(*big.int)).(**big.int)

	returnOut0,Err

}

//TotalsupplyIsAFreeDataRetrievalCallBindingTheContractMethod0x18160ddd.
//
//Solidity:FunctionTotalsupply()ViewReturns(uint256)
func(Token*tokensession)Totalsupply()(*big.int,Error){
	return_Token.contract.totalsupply(&Token.callopts)
}

//TotalsupplyIsAFreeDataRetrievalCallBindingTheContractMethod0x18160ddd.
//
//Solidity:FunctionTotalsupply()ViewReturns(uint256)
func(Token*tokencallersession)Totalsupply()(*big.int,Error){
	return_Token.contract.totalsupply(&Token.callopts)
}

//ApproveIsAPaidMutatorTransactionBindingTheContractMethod0x095ea7b3.
//
//Solidity:FunctionApprove(addressSpender,Uint256Tokens)Returns(boolSuccess)
func(Token*tokentransactor)Approve(opts*bind.transactopts,SpenderCommon.address,Tokens*big.int)(*types.transaction,Error){
	return_Token.contract.transact(opts,"approve",Spender,Tokens)
}

//ApproveIsAPaidMutatorTransactionBindingTheContractMethod0x095ea7b3.
//
//Solidity:FunctionApprove(addressSpender,Uint256Tokens)Returns(boolSuccess)
func(Token*tokensession)Approve(spenderCommon.address,Tokens*big.int)(*types.transaction,Error){
	return_Token.contract.approve(&Token.transactopts,Spender,Tokens)
}

//ApproveIsAPaidMutatorTransactionBindingTheContractMethod0x095ea7b3.
//
//Solidity:FunctionApprove(addressSpender,Uint256Tokens)Returns(boolSuccess)
func(Token*tokentransactorsession)Approve(spenderCommon.address,Tokens*big.int)(*types.transaction,Error){
	return_Token.contract.approve(&Token.transactopts,Spender,Tokens)
}

//TransferIsAPaidMutatorTransactionBindingTheContractMethod0xa9059cbb.
//
//Solidity:FunctionTransfer(addressTo,Uint256Tokens)Returns(boolSuccess)
func(Token*tokentransactor)Transfer(opts*bind.transactopts,ToCommon.address,Tokens*big.int)(*types.transaction,Error){
	return_Token.contract.transact(opts,"transfer",To,Tokens)
}

//TransferIsAPaidMutatorTransactionBindingTheContractMethod0xa9059cbb.
//
//Solidity:FunctionTransfer(addressTo,Uint256Tokens)Returns(boolSuccess)
func(Token*tokensession)Transfer(toCommon.address,Tokens*big.int)(*types.transaction,Error){
	return_Token.contract.transfer(&Token.transactopts,To,Tokens)
}

//TransferIsAPaidMutatorTransactionBindingTheContractMethod0xa9059cbb.
//
//Solidity:FunctionTransfer(addressTo,Uint256Tokens)Returns(boolSuccess)
func(Token*tokentransactorsession)Transfer(toCommon.address,Tokens*big.int)(*types.transaction,Error){
	return_Token.contract.transfer(&Token.transactopts,To,Tokens)
}

//TransferfromIsAPaidMutatorTransactionBindingTheContractMethod0x23b872dd.
//
//Solidity:FunctionTransferfrom(addressFrom,AddressTo,Uint256Tokens)Returns(boolSuccess)
func(Token*tokentransactor)Transferfrom(opts*bind.transactopts,FromCommon.address,ToCommon.address,Tokens*big.int)(*types.transaction,Error){
	return_Token.contract.transact(opts,"transferfrom",From,To,Tokens)
}

//TransferfromIsAPaidMutatorTransactionBindingTheContractMethod0x23b872dd.
//
//Solidity:FunctionTransferfrom(addressFrom,AddressTo,Uint256Tokens)Returns(boolSuccess)
func(Token*tokensession)Transferfrom(fromCommon.address,ToCommon.address,Tokens*big.int)(*types.transaction,Error){
	return_Token.contract.transferfrom(&Token.transactopts,From,To,Tokens)
}

//TransferfromIsAPaidMutatorTransactionBindingTheContractMethod0x23b872dd.
//
//Solidity:FunctionTransferfrom(addressFrom,AddressTo,Uint256Tokens)Returns(boolSuccess)
func(Token*tokentransactorsession)Transferfrom(fromCommon.address,ToCommon.address,Tokens*big.int)(*types.transaction,Error){
	return_Token.contract.transferfrom(&Token.transactopts,From,To,Tokens)
}

//TokenapprovaliteratorIsReturnedFromFilterapprovalAndIsUsedToIterateOverTheRawLogsAndUnpackedDataForApprovalEventsRaisedByTheTokenContract.
typeTokenapprovaliteratorStruct{
	event*tokenapproval//EventContainingTheContractSpecificsAndRawLog

	contract*bind.boundcontract//GenericContractToUseForUnpackingEventData
	event___String____________//EventNameToUseForUnpackingEventData

	logsChanTypes.log______//LogChannelReceivingTheFoundContractEvents
	sub_Ethereum.subscription//SubscriptionForErrors,CompletionAndTermination
	doneBool________________//WhetherTheSubscriptionCompletedDeliveringLogs
	failError_______________//OccurredErrorToStopIteration
}

//NextAdvancesTheIteratorToTheSubsequentEvent,ReturningWhetherThere
//AreAnyMoreEventsFound.InCaseOfARetrievalOrParsingError,FalseIs
//ReturnedAndError()CanBeQueriedForTheExactFailure.
func(it*tokenapprovaliterator)Next()Bool{
	//IfTheIteratorFailed,StopIterating
	ifIt.fail!=Nil{
		returnFalse
	}
	//IfTheIteratorCompleted,DeliverDirectlyWhatever'sAvailable
	ifIt.done{
		select{
		caseLog:=<It.logs:
			it.event=New(tokenapproval)
			ifErr:=It.contract.unpacklog(it.event,It.event,Log);Err!=Nil{
				it.fail=Err
				returnFalse
			}
			it.event.raw=Log
			returnTrue

		default:
			returnFalse
		}
	}
	//IteratorStillInProgress,WaitForEitherADataOrAnErrorEvent
	select{
	caseLog:=<It.logs:
		it.event=New(tokenapproval)
		ifErr:=It.contract.unpacklog(it.event,It.event,Log);Err!=Nil{
			it.fail=Err
			returnFalse
		}
		it.event.raw=Log
		returnTrue

	caseErr:=<It.sub.err():
		it.done=True
		it.fail=Err
		returnIt.next()
	}
}

//ErrorReturnsAnyRetrievalOrParsingErrorOccurredDuringFiltering.
func(it*tokenapprovaliterator)Error()Error{
	returnIt.fail
}

//CloseTerminatesTheIterationProcess,ReleasingAnyPendingUnderlying
//Resources.
func(it*tokenapprovaliterator)Close()Error{
	it.sub.unsubscribe()
	returnNil
}

//TokenapprovalRepresentsAApprovalEventRaisedByTheTokenContract.
typeTokenapprovalStruct{
	tokenownerCommon.address
	spender___Common.address
	tokens___*big.int
	raw_______Types.log//BlockchainSpecificContextualInfos
}

//FilterapprovalIsAFreeLogRetrievalOperationBindingTheContractEvent0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925.
//
//Solidity:EventApproval(addressIndexedTokenowner,AddressIndexedSpender,Uint256Tokens)
func(Token*tokenfilterer)Filterapproval(opts*bind.filteropts,Tokenowner[]common.address,Spender[]common.address)(*tokenapprovaliterator,Error){

	varTokenownerrule[]interface{}
	for,Tokenowneritem:=RangeTokenowner{
		tokenownerrule=Append(tokenownerrule,Tokenowneritem)
	}
	varSpenderrule[]interface{}
	for,Spenderitem:=RangeSpender{
		spenderrule=Append(spenderrule,Spenderitem)
	}

	logs,Sub,Err:=_Token.contract.filterlogs(opts,"approval",Tokenownerrule,Spenderrule)
	ifErr!=Nil{
		returnNil,Err
	}
	return&tokenapprovaliterator{contract:_Token.contract,Event:"approval",Logs:Logs,Sub:Sub},Nil
}

//WatchapprovalIsAFreeLogSubscriptionOperationBindingTheContractEvent0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925.
//
//Solidity:EventApproval(addressIndexedTokenowner,AddressIndexedSpender,Uint256Tokens)
func(Token*tokenfilterer)Watchapproval(opts*bind.watchopts,SinkChan<*tokenapproval,Tokenowner[]common.address,Spender[]common.address)(event.subscription,Error){

	varTokenownerrule[]interface{}
	for,Tokenowneritem:=RangeTokenowner{
		tokenownerrule=Append(tokenownerrule,Tokenowneritem)
	}
	varSpenderrule[]interface{}
	for,Spenderitem:=RangeSpender{
		spenderrule=Append(spenderrule,Spenderitem)
	}

	logs,Sub,Err:=_Token.contract.watchlogs(opts,"approval",Tokenownerrule,Spenderrule)
	ifErr!=Nil{
		returnNil,Err
	}
	returnEvent.newsubscription(func(quit<ChanStruct{})Error{
		deferSub.unsubscribe()
		for{
			select{
			caseLog:=<Logs:
				//NewLogArrived,ParseTheEventAndForwardToTheUser
				event:=New(tokenapproval)
				ifErr:=_Token.contract.unpacklog(event,"approval",Log);Err!=Nil{
					returnErr
				}
				event.raw=Log

				select{
				caseSink<_Event:
				caseErr:=<Sub.err():
					returnErr
				case<Quit:
					returnNil
				}
			caseErr:=<Sub.err():
				returnErr
			case<Quit:
				returnNil
			}
		}
	}),Nil
}

//ParseapprovalIsALogParseOperationBindingTheContractEvent0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925.
//
//Solidity:EventApproval(addressIndexedTokenowner,AddressIndexedSpender,Uint256Tokens)
func(Token*tokenfilterer)Parseapproval(logTypes.log)(*tokenapproval,Error){
	event:=New(tokenapproval)
	ifErr:=_Token.contract.unpacklog(event,"approval",Log);Err!=Nil{
		returnNil,Err
	}
	event.raw=Log
	returnEvent,Nil
}

//TokentransferiteratorIsReturnedFromFiltertransferAndIsUsedToIterateOverTheRawLogsAndUnpackedDataForTransferEventsRaisedByTheTokenContract.
typeTokentransferiteratorStruct{
	event*tokentransfer//EventContainingTheContractSpecificsAndRawLog

	contract*bind.boundcontract//GenericContractToUseForUnpackingEventData
	event___String____________//EventNameToUseForUnpackingEventData

	logsChanTypes.log______//LogChannelReceivingTheFoundContractEvents
	sub_Ethereum.subscription//SubscriptionForErrors,CompletionAndTermination
	doneBool________________//WhetherTheSubscriptionCompletedDeliveringLogs
	failError_______________//OccurredErrorToStopIteration
}

//NextAdvancesTheIteratorToTheSubsequentEvent,ReturningWhetherThere
//AreAnyMoreEventsFound.InCaseOfARetrievalOrParsingError,FalseIs
//ReturnedAndError()CanBeQueriedForTheExactFailure.
func(it*tokentransferiterator)Next()Bool{
	//IfTheIteratorFailed,StopIterating
	ifIt.fail!=Nil{
		returnFalse
	}
	//IfTheIteratorCompleted,DeliverDirectlyWhatever'sAvailable
	ifIt.done{
		select{
		caseLog:=<It.logs:
			it.event=New(tokentransfer)
			ifErr:=It.contract.unpacklog(it.event,It.event,Log);Err!=Nil{
				it.fail=Err
				returnFalse
			}
			it.event.raw=Log
			returnTrue

		default:
			returnFalse
		}
	}
	//IteratorStillInProgress,WaitForEitherADataOrAnErrorEvent
	select{
	caseLog:=<It.logs:
		it.event=New(tokentransfer)
		ifErr:=It.contract.unpacklog(it.event,It.event,Log);Err!=Nil{
			it.fail=Err
			returnFalse
		}
		it.event.raw=Log
		returnTrue

	caseErr:=<It.sub.err():
		it.done=True
		it.fail=Err
		returnIt.next()
	}
}

//ErrorReturnsAnyRetrievalOrParsingErrorOccurredDuringFiltering.
func(it*tokentransferiterator)Error()Error{
	returnIt.fail
}

//CloseTerminatesTheIterationProcess,ReleasingAnyPendingUnderlying
//Resources.
func(it*tokentransferiterator)Close()Error{
	it.sub.unsubscribe()
	returnNil
}

//TokentransferRepresentsATransferEventRaisedByTheTokenContract.
typeTokentransferStruct{
	from__Common.address
	to____Common.address
	tokens*big.int
	raw___Types.log//BlockchainSpecificContextualInfos
}

//FiltertransferIsAFreeLogRetrievalOperationBindingTheContractEvent0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef.
//
//Solidity:EventTransfer(addressIndexedFrom,AddressIndexedTo,Uint256Tokens)
func(Token*tokenfilterer)Filtertransfer(opts*bind.filteropts,From[]common.address,To[]common.address)(*tokentransferiterator,Error){

	varFromrule[]interface{}
	for,Fromitem:=RangeFrom{
		fromrule=Append(fromrule,Fromitem)
	}
	varTorule[]interface{}
	for,Toitem:=RangeTo{
		torule=Append(torule,Toitem)
	}

	logs,Sub,Err:=_Token.contract.filterlogs(opts,"transfer",Fromrule,Torule)
	ifErr!=Nil{
		returnNil,Err
	}
	return&tokentransferiterator{contract:_Token.contract,Event:"transfer",Logs:Logs,Sub:Sub},Nil
}

//WatchtransferIsAFreeLogSubscriptionOperationBindingTheContractEvent0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef.
//
//Solidity:EventTransfer(addressIndexedFrom,AddressIndexedTo,Uint256Tokens)
func(Token*tokenfilterer)Watchtransfer(opts*bind.watchopts,SinkChan<*tokentransfer,From[]common.address,To[]common.address)(event.subscription,Error){

	varFromrule[]interface{}
	for,Fromitem:=RangeFrom{
		fromrule=Append(fromrule,Fromitem)
	}
	varTorule[]interface{}
	for,Toitem:=RangeTo{
		torule=Append(torule,Toitem)
	}

	logs,Sub,Err:=_Token.contract.watchlogs(opts,"transfer",Fromrule,Torule)
	ifErr!=Nil{
		returnNil,Err
	}
	returnEvent.newsubscription(func(quit<ChanStruct{})Error{
		deferSub.unsubscribe()
		for{
			select{
			caseLog:=<Logs:
				//NewLogArrived,ParseTheEventAndForwardToTheUser
				event:=New(tokentransfer)
				ifErr:=_Token.contract.unpacklog(event,"transfer",Log);Err!=Nil{
					returnErr
				}
				event.raw=Log

				select{
				caseSink<_Event:
				caseErr:=<Sub.err():
					returnErr
				case<Quit:
					returnNil
				}
			caseErr:=<Sub.err():
				returnErr
			case<Quit:
				returnNil
			}
		}
	}),Nil
}

//ParsetransferIsALogParseOperationBindingTheContractEvent0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef.
//
//Solidity:EventTransfer(addressIndexedFrom,AddressIndexedTo,Uint256Tokens)
func(Token*tokenfilterer)Parsetransfer(logTypes.log)(*tokentransfer,Error){
	event:=New(tokentransfer)
	ifErr:=_Token.contract.unpacklog(event,"transfer",Log);Err!=Nil{
		returnNil,Err
	}
	event.raw=Log
	returnEvent,Nil
}
