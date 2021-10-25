!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportCalculatorTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportCalculatorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportCalculatorTest methodsFor: 'account summary tests' stamp: 'JD 10/22/2021 21:45:11'!
test01CanCalculateTheAccountSummaryOfAnEmptyReceptiveAccount
	
	| aReceptiveAccount anExpectedAccountSummary |
	
	aReceptiveAccount := self createAnEmptyReceptiveAccount.
	anExpectedAccountSummary := OrderedCollection with: 'Balance = 0'.

	self assertThatAccountSummaryFor: aReceptiveAccount is: anExpectedAccountSummary 
! !

!ReportCalculatorTest methodsFor: 'account summary tests' stamp: 'JD 10/22/2021 21:44:10'!
test02CanCalculateTheAccountSummaryOfAReceptiveAccountWithADeposit
	
	| aReceptiveAccount expectedAccountSummary |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf100.
	expectedAccountSummary := OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100'.

	self assertThatAccountSummaryFor: aReceptiveAccount is: expectedAccountSummary! !

!ReportCalculatorTest methodsFor: 'account summary tests' stamp: 'JD 10/22/2021 21:46:34'!
test03CanCalculateTheAccountSummaryOfAnEmptyReceptiveAWithdraw
	
	| aReceptiveAccount anExpectedAccountSummary |
	
	aReceptiveAccount := self createAReceptiveAccountWithAWithdrawOf100.
	anExpectedAccountSummary := OrderedCollection with: 'Extracción por 100.' with: 'Balance = -100'.

	self assertThatAccountSummaryFor: aReceptiveAccount is: anExpectedAccountSummary! !

!ReportCalculatorTest methodsFor: 'account summary tests' stamp: 'JD 10/22/2021 21:59:04'!
test04CanCalculateTheAccountSummaryOfATransferEmitterReceptiveAccount
	
	| aTransferEmitter anExpectedAccountSummary |
	
	aTransferEmitter := self createATransferEmitterOf100.
	anExpectedAccountSummary := (OrderedCollection with: 'Salida por transferencia de 100.' with: 'Balance = -100').

	self assertThatAccountSummaryFor: aTransferEmitter is: anExpectedAccountSummary! !

!ReportCalculatorTest methodsFor: 'account summary tests' stamp: 'JD 10/22/2021 22:00:18'!
test05CanCalculateTheAccountSummaryOfATransferReceiverReceptiveAccount
	
	| aTransferReceiver anExpectedAccountSummary |
	
	aTransferReceiver := self createATransferReceiverOf100.
	anExpectedAccountSummary := (OrderedCollection with: 'Entrada por transferencia de 100.' with: 'Balance = 100').

	self assertThatAccountSummaryFor: aTransferReceiver is: anExpectedAccountSummary! !

!ReportCalculatorTest methodsFor: 'account summary tests' stamp: 'JD 10/22/2021 21:55:10'!
test06CanCalculateTheAccountSummaryOfAnEmptyPortfolio
	
	| anExpectedAccountSummary anEmptyPortfolio |
	
	anEmptyPortfolio := Portfolio new.
	anExpectedAccountSummary := OrderedCollection with: 'Balance = 0'.
	
	self assertThatAccountSummaryFor: anEmptyPortfolio is: anExpectedAccountSummary! !

!ReportCalculatorTest methodsFor: 'account summary tests' stamp: 'JD 10/22/2021 21:52:54'!
test07CanCalculateTheAccountSummaryOfAPortfolioWithAReceptiveAccount
	
	| aPortfolio aReceptiveAccount anExpectedAccountSummary |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf100.
	aPortfolio := Portfolio with: aReceptiveAccount.
	anExpectedAccountSummary := OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100'.

	self assertThatAccountSummaryFor: aPortfolio is: anExpectedAccountSummary! !


!ReportCalculatorTest methodsFor: 'transfer net tests' stamp: 'JD 10/22/2021 21:29:06'!
test08TransferNetOfAnEmptyReceptiveAccountIsZero
	
	self assertThatTransferNetFor: self createAnEmptyReceptiveAccount is: 0
	! !

!ReportCalculatorTest methodsFor: 'transfer net tests' stamp: 'JD 10/22/2021 21:58:36'!
test09EmitingATransferDecreasesTheTransferNet
	
	| aTransferEmitter |
	
	aTransferEmitter := self createATransferEmitterOf100.
	
	self assertThatTransferNetFor: aTransferEmitter is: -100! !

!ReportCalculatorTest methodsFor: 'transfer net tests' stamp: 'JD 10/22/2021 22:00:02'!
test10ReceivingATransferIncreasesTransferNet
	
	| aTransferReceiver |
	
	aTransferReceiver := self createATransferReceiverOf100.
	
	self assertThatTransferNetFor: aTransferReceiver is: 100! !

!ReportCalculatorTest methodsFor: 'transfer net tests' stamp: 'JD 10/22/2021 21:34:45'!
test11TransferNetIsTheDifferenceBetweenTheReceivedAndEmittedTransfers
	
	| aReceptiveAccount anotherReceptiveAccount |
	
	aReceptiveAccount := self createAnEmptyReceptiveAccount.
	anotherReceptiveAccount := self createAnEmptyReceptiveAccount.
	Transfer register: 100 from: aReceptiveAccount to: anotherReceptiveAccount.
	Transfer register: 10 from: anotherReceptiveAccount to: aReceptiveAccount.

	self assertThatTransferNetFor: aReceptiveAccount is: -90
	! !

!ReportCalculatorTest methodsFor: 'transfer net tests' stamp: 'JD 10/22/2021 21:31:21'!
test12DepositDoesNotAffectTransferNet
	
	| aReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf100.
	
	self assertThatTransferNetFor: aReceptiveAccount is: 0! !

!ReportCalculatorTest methodsFor: 'transfer net tests' stamp: 'JD 10/22/2021 21:32:00'!
test13WithdrawDoesNotAffectTransferNet
	
	| aReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithAWithdrawOf100.
	
	self assertThatTransferNetFor: aReceptiveAccount is: 0
	! !


!ReportCalculatorTest methodsFor: 'assertions' stamp: 'JD 10/22/2021 21:41:35'!
assertThatAccountSummaryFor: anAccount is: anExpectedAccountSummary
	
	| anAccountSummaryCalculator |
	
	anAccountSummaryCalculator := AccountSummaryCalculator for: anAccount.
	
	self assert: anExpectedAccountSummary equals: anAccountSummaryCalculator calculate! !

!ReportCalculatorTest methodsFor: 'assertions' stamp: 'JD 10/24/2021 22:30:15'!
assertThatPortfolioStructureFor: aPortfolio is: anExpectedPortfolioStructure	
	
	| aPortfolioStructureCalculator |
	
	aPortfolioStructureCalculator := PortfolioStructureCalculator for: aPortfolio.
	
	self assert: anExpectedPortfolioStructure equals: aPortfolioStructureCalculator calculate
	! !

!ReportCalculatorTest methodsFor: 'assertions' stamp: 'JD 10/24/2021 23:53:06'!
assertThatPortfolioStructureWithSummaryFor: aPortfolio is: anExpectedPortfolioStructure	
	
	| aPortfolioStructureCalculator |
	
	aPortfolioStructureCalculator := PortfolioStructureWithSummaryCalculator for: aPortfolio.
	
	self assert: anExpectedPortfolioStructure equals: aPortfolioStructureCalculator calculate
	! !

!ReportCalculatorTest methodsFor: 'assertions' stamp: 'JD 10/22/2021 21:28:36'!
assertThatTransferNetFor: aReceptiveAccount is: aTransferNetAmount
	
	| aTransferNetCalculator |
	
	aTransferNetCalculator := TransferNetCalculator for: aReceptiveAccount.
	self assert: aTransferNetAmount equals: aTransferNetCalculator calculate
	! !


!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/24/2021 22:58:17'!
childsPortfolioName

	^ 'Childs Portfolio'! !

!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/24/2021 22:58:26'!
createAChildsPortfolioWith: anAccount

	^ Portfolio named: self childsPortfolioName with: anAccount

	! !

!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/24/2021 22:57:48'!
createAFamilyPortfolioWith: anAccount

	^ Portfolio named: self familyPortfolioName with: anAccount! !

!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/24/2021 22:57:37'!
createAFamilyPortfolioWith: anAccount with: anotherAccount
	
	^ Portfolio named: self familyPortfolioName with: anAccount with: anotherAccount

	! !

!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/24/2021 22:47:18'!
createAJuanReceptiveAccount

	^ ReceptiveAccount named: 'Juan Account'! !

!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/22/2021 21:26:18'!
createAReceptiveAccountWithADepositOf100
	
	| aReceptiveAccount |
	
	aReceptiveAccount := self createAnEmptyReceptiveAccount.
	Deposit register: 100 on: aReceptiveAccount.
	
	^ aReceptiveAccount ! !

!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/22/2021 21:24:58'!
createAReceptiveAccountWithAWithdrawOf100
	
	|  aReceptiveAccount |
	
	aReceptiveAccount := self createAnEmptyReceptiveAccount.
	Withdraw register: 100 on: aReceptiveAccount.

	^ aReceptiveAccount ! !

!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/22/2021 21:58:36'!
createATransferEmitterOf100

	| aTransferEmitter aTransferReceiver |
	
	aTransferEmitter := self createAnEmptyReceptiveAccount.
	aTransferReceiver := self createAnEmptyReceptiveAccount.
	Transfer register: 100 from: aTransferEmitter to: aTransferReceiver.

	^ aTransferEmitter ! !

!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/22/2021 21:59:35'!
createATransferReceiverOf100
	
	| aTransferEmitter aTransferReceiver |
	
	aTransferEmitter := self createAnEmptyReceptiveAccount.
	aTransferReceiver := self createAnEmptyReceptiveAccount.
	Transfer register: 100 from: aTransferEmitter to: aTransferReceiver.
	
	^ aTransferReceiver! !

!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/24/2021 22:58:17'!
createAnEmptyChildsPortfolio

	^ Portfolio named: self childsPortfolioName

	! !

!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/24/2021 22:57:59'!
createAnEmptyFamilyPortfolio

	^ Portfolio named: self familyPortfolioName! !

!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/22/2021 21:22:41'!
createAnEmptyReceptiveAccount

	^ ReceptiveAccount new! !

!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/24/2021 22:35:03'!
createAnOwnReceptiveAccount
	
	^ ReceptiveAccount named: 'Own Account'.
	
	! !

!ReportCalculatorTest methodsFor: 'creations' stamp: 'JD 10/24/2021 22:57:37'!
familyPortfolioName

	^ 'Family Portfolio'! !


!ReportCalculatorTest methodsFor: 'portfolio structure tests' stamp: 'JD 10/24/2021 22:38:30'!
test14CanCalculateTheStructureOfAnEmptyPortfolio
	
	| anEmptyFamilyPortfolio anExpectedPortfolioStructure |
	
	anEmptyFamilyPortfolio := self createAnEmptyFamilyPortfolio.
	
	anExpectedPortfolioStructure := OrderedCollection with: anEmptyFamilyPortfolio accountName with: OrderedCollection new.
	self assertThatPortfolioStructureFor: anEmptyFamilyPortfolio is: anExpectedPortfolioStructure
	! !

!ReportCalculatorTest methodsFor: 'portfolio structure tests' stamp: 'JD 10/24/2021 22:41:27'!
test15CanCalculateTheStructureOfAPortfolioWithAReceptiveAccount
	
	| aFamilyPortfolio anOwnReceptiveAccount anExpectedPortfolioStructure |
	
	anOwnReceptiveAccount := self createAnOwnReceptiveAccount.
	aFamilyPortfolio := self createAFamilyPortfolioWith: anOwnReceptiveAccount.
	
	anExpectedPortfolioStructure := (OrderedCollection with: aFamilyPortfolio accountName with: (OrderedCollection with: anOwnReceptiveAccount accountName)).
	self assertThatPortfolioStructureFor: aFamilyPortfolio is: anExpectedPortfolioStructure
	! !

!ReportCalculatorTest methodsFor: 'portfolio structure tests' stamp: 'JD 10/24/2021 22:52:13'!
test16CanCalculateTheStructureOfAPortfolioWithAnotherPortfolio
	
	| aFamilyPortfolio aChildsPortfolio anExpectedPortfolioStructure anExpectedChildsPortfolioStructure |
	
	aChildsPortfolio := self createAnEmptyChildsPortfolio.
	aFamilyPortfolio := self createAFamilyPortfolioWith: aChildsPortfolio.
	
	anExpectedChildsPortfolioStructure := OrderedCollection with: aChildsPortfolio accountName with: OrderedCollection new.
	anExpectedPortfolioStructure := (OrderedCollection with: aFamilyPortfolio accountName with: (OrderedCollection with: anExpectedChildsPortfolioStructure)).
	self assertThatPortfolioStructureFor: aFamilyPortfolio is: anExpectedPortfolioStructure
	! !

!ReportCalculatorTest methodsFor: 'portfolio structure tests' stamp: 'JD 10/24/2021 22:50:06'!
test17CanCalculateTheStructureOfAPortfolioWithManyReceptiveAccounts
	
	| aFamilyPortfolio anOwnReceptiveAccount aJuanReceptiveAccount anExpectedPortfolioStructure |
	
	anOwnReceptiveAccount := self createAnOwnReceptiveAccount.
	aJuanReceptiveAccount := self createAJuanReceptiveAccount.
	aFamilyPortfolio := self createAFamilyPortfolioWith: anOwnReceptiveAccount with: aJuanReceptiveAccount.
	
	anExpectedPortfolioStructure := (OrderedCollection with: aFamilyPortfolio accountName with: (OrderedCollection with: anOwnReceptiveAccount accountName with: aJuanReceptiveAccount accountName)).
	self assertThatPortfolioStructureFor: aFamilyPortfolio is: anExpectedPortfolioStructure
	! !

!ReportCalculatorTest methodsFor: 'portfolio structure tests' stamp: 'JD 10/24/2021 22:56:03'!
test18CanCalculateTheStructureOfAPortfolioWithAReceptiveAccountAndAnotherPortfolio
	
	| aFamilyPortfolio aChildsPortfolio anOwnReceptiveAccount aJuanReceptiveAccount anExpectedChildsPortfolioStructure anExpectedFamilyPortfolioStructure |

	aJuanReceptiveAccount := self createAJuanReceptiveAccount.
	aChildsPortfolio := self createAChildsPortfolioWith: aJuanReceptiveAccount.
	anOwnReceptiveAccount := self createAnOwnReceptiveAccount.
	aFamilyPortfolio := self createAFamilyPortfolioWith: anOwnReceptiveAccount with: aChildsPortfolio.

	anExpectedChildsPortfolioStructure := (OrderedCollection with: aChildsPortfolio accountName with: (OrderedCollection with: aJuanReceptiveAccount accountName)).
	anExpectedFamilyPortfolioStructure := (OrderedCollection with: aFamilyPortfolio accountName with: (OrderedCollection with: anOwnReceptiveAccount accountName with: anExpectedChildsPortfolioStructure)).

	self assertThatPortfolioStructureFor: aFamilyPortfolio is: anExpectedFamilyPortfolioStructure 
	! !

!ReportCalculatorTest methodsFor: 'portfolio structure tests' stamp: 'JD 10/25/2021 00:01:29'!
test19CanCalculateTheStructureWithSummaryOfAPortfolioWithAReceptiveAccount

	| aFamilyPortfolio anOwnReceptiveAccount anExpectedPortfolioStructureWithSummary anExpectedOwnReceptiveAccountNameWithSummary |
	
	anOwnReceptiveAccount := self createAnOwnReceptiveAccount.
	aFamilyPortfolio := self createAFamilyPortfolioWith: anOwnReceptiveAccount.
	
	anExpectedOwnReceptiveAccountNameWithSummary := OrderedCollection with: anOwnReceptiveAccount accountName with: (OrderedCollection with: 'Balance = 0').
	anExpectedPortfolioStructureWithSummary := OrderedCollection with: aFamilyPortfolio accountName with: (OrderedCollection with: anExpectedOwnReceptiveAccountNameWithSummary).

	self assertThatPortfolioStructureWithSummaryFor: aFamilyPortfolio is: anExpectedPortfolioStructureWithSummary
	! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'transfer tests' stamp: 'JD 10/20/2021 17:13:05'!
test01CannotTransferToItself
	
	| aReceptiveAccount |
	
	aReceptiveAccount := ReceptiveAccount new.
	
	self assertThatRegister: 50 from: aReceptiveAccount to: aReceptiveAccount shouldRaiseErrorWithDescription: Transfer cannotTransferToItselfErrorDescription.
! !

!TransferTest methodsFor: 'transfer tests' stamp: 'JD 10/20/2021 17:13:10'!
test02CannotTransferANonPositiveAmount
	
	| anEmitterReceptiveAccount aReceiverReceptiveAccount |
	
	anEmitterReceptiveAccount := ReceptiveAccount new.
	aReceiverReceptiveAccount := ReceptiveAccount new.
	
	self assertThatRegister: -50 from: anEmitterReceptiveAccount to: aReceiverReceptiveAccount shouldRaiseErrorWithDescription: Transfer cannotTransferANonPositiveAmountErrorDescription.! !

!TransferTest methodsFor: 'transfer tests' stamp: 'JD 10/20/2021 17:13:17'!
test03ATransferDecreasesTheBalanceOfTheReceptiveAccountEmitter
	
	| anEmitterReceptiveAccount aReceiverReceptiveAccount |
	
	anEmitterReceptiveAccount := ReceptiveAccount new.
	aReceiverReceptiveAccount := ReceptiveAccount new.
	
	Transfer register: 50 from: anEmitterReceptiveAccount to: aReceiverReceptiveAccount.

	self assert: -50 equals: anEmitterReceptiveAccount balance! !

!TransferTest methodsFor: 'transfer tests' stamp: 'JD 10/20/2021 17:13:24'!
test04ATransferIncreasesTheBalanceOfTheReceptiveAccountReceiver
	
	| anEmitterReceptiveAccount aReceiverReceptiveAccount |
	
	anEmitterReceptiveAccount := ReceptiveAccount new.
	aReceiverReceptiveAccount := ReceptiveAccount new.
	
	Transfer register: 50 from: anEmitterReceptiveAccount to: aReceiverReceptiveAccount.
	
	self assert: 50 equals: aReceiverReceptiveAccount balance! !

!TransferTest methodsFor: 'transfer tests' stamp: 'JD 10/20/2021 17:13:29'!
test05CanNavigateFromSourceToDestinationOfATransfer

	| aTransfer |

	aTransfer := self createATransfer.
	
	self assert: aTransfer source oppositeEnd equals: aTransfer destination ! !

!TransferTest methodsFor: 'transfer tests' stamp: 'JD 10/20/2021 17:13:34'!
test06CanNavigateFromDestinationToSourceOfATransfer

	| aTransfer |

	aTransfer := self createATransfer.
	
	self assert: aTransfer destination oppositeEnd equals: aTransfer source ! !


!TransferTest methodsFor: 'creation' stamp: 'JD 10/20/2021 17:12:10'!
createATransfer
	
	| anEmitterReceptiveAccount aReceiverReceptiveAccount |
	
	anEmitterReceptiveAccount := ReceptiveAccount new.
	aReceiverReceptiveAccount := ReceptiveAccount new.
	
	^ Transfer register: 50 from: anEmitterReceptiveAccount to: aReceiverReceptiveAccount! !


!TransferTest methodsFor: 'assertions' stamp: 'JD 10/20/2021 17:12:13'!
assertThatRegister: aTransferAmount from: anEmitterReceptiveAccount to: aReceiverReceptiveAccount shouldRaiseErrorWithDescription: anErrorDescription

	self should: [Transfer register: aTransferAmount from: anEmitterReceptiveAccount to: aReceiverReceptiveAccount] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = anErrorDescription]! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'visitor accepting' stamp: 'JD 10/22/2021 20:18:45'!
accept: aVisitor 
	
	self subclassResponsibility ! !


!Account methodsFor: 'name' stamp: 'JD 10/25/2021 00:19:34'!
accountName
	
	^ name! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'JD 10/23/2021 16:04:01'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := ''! !

!Portfolio methodsFor: 'initialization' stamp: 'JD 10/23/2021 16:06:39'!
initializeWithName: aPortfolioName

	name := aPortfolioName! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'visitor accepting' stamp: 'JD 10/24/2021 20:50:59'!
accept: aVisitor 
	
	accounts do: [ :anAccount | anAccount accept: aVisitor].
	aVisitor visitPortfolio: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'JD 10/23/2021 16:05:17'!
named: aPortfolioName

	^self new initializeWithName: aPortfolioName! !

!Portfolio class methodsFor: 'instance creation' stamp: 'JD 10/23/2021 16:16:12'!
named: aPortfolioName with: anAccount

	^(self new initializeWithName: aPortfolioName)
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'JD 10/23/2021 17:25:19'!
named: aPortfolioName with: aReceptiveAccountToAdd with: anotherReceptiveAccountToAdd 
	
	^(self new initializeWithName: aPortfolioName)
		add: aReceptiveAccountToAdd;
		add: anotherReceptiveAccountToAdd;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions receptiveAccountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'JD 10/23/2021 16:18:22'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	name := ''! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'JD 10/23/2021 16:17:34'!
initializeNameWith: aReceptiveAccountName 

	name := aReceptiveAccountName! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'visitor accepting' stamp: 'JD 10/24/2021 20:51:15'!
accept: aVisitor

	transactions do: [ :aTransaction | aTransaction accept: aVisitor].
	aVisitor visitReceptiveAccount: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'JD 10/23/2021 16:17:06'!
named: aReceptiveAccountName 

	^ self new initializeNameWith: aReceptiveAccountName ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visitor accepting' stamp: 'JD 10/25/2021 00:17:56'!
accept: aVisitor
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'visitor accepting' stamp: 'JD 10/22/2021 18:54:04'!
accept: aVisitor

	aVisitor visitDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'visitor accepting' stamp: 'JD 10/22/2021 19:27:08'!
accept: aVisitor 
	
	^ aVisitor visitWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #EndpointTransfer category: 'Portfolio-Solucion'!
Object subclass: #EndpointTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!EndpointTransfer methodsFor: 'balance' stamp: 'JD 10/19/2021 21:33:03'!
affectBalance: aBalance

	self subclassResponsibility ! !


!EndpointTransfer methodsFor: 'initialization' stamp: 'JD 10/19/2021 21:37:18'!
initializeFor: aTransfer

	transfer := aTransfer! !


!EndpointTransfer methodsFor: 'opposite end' stamp: 'JD 10/19/2021 21:33:14'!
oppositeEnd

	self subclassResponsibility ! !


!EndpointTransfer methodsFor: 'visitor accepting' stamp: 'JD 10/25/2021 00:16:39'!
accept: aVisitor
	
	self subclassResponsibility ! !


!EndpointTransfer methodsFor: 'value' stamp: 'JD 10/22/2021 19:54:42'!
value
	
	^ transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EndpointTransfer class' category: 'Portfolio-Solucion'!
EndpointTransfer class
	instanceVariableNames: ''!

!EndpointTransfer class methodsFor: 'instance creation' stamp: 'JD 10/19/2021 21:33:40'!
for: aTransfer 

	^ self new initializeFor: aTransfer ! !

!EndpointTransfer class methodsFor: 'instance creation' stamp: 'JD 10/19/2021 21:36:01'!
register: aTransfer on: aReceptiveAccount

	| anEndpointTransfer |

	anEndpointTransfer := self for: aTransfer.
	aReceptiveAccount register: anEndpointTransfer.
	
	^ anEndpointTransfer! !


!classDefinition: #DestinationTransfer category: 'Portfolio-Solucion'!
EndpointTransfer subclass: #DestinationTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DestinationTransfer methodsFor: 'balance' stamp: 'JD 10/19/2021 21:06:31'!
affectBalance: aBalance 
	
	^ aBalance + transfer value! !


!DestinationTransfer methodsFor: 'opposite end' stamp: 'JD 10/19/2021 21:25:47'!
oppositeEnd
	
	^ transfer source! !


!DestinationTransfer methodsFor: 'visitor accepting' stamp: 'JD 10/22/2021 19:53:23'!
accept: aVisitor 
	
	aVisitor visitDestinationTransfer: self! !


!classDefinition: #SourceTransfer category: 'Portfolio-Solucion'!
EndpointTransfer subclass: #SourceTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SourceTransfer methodsFor: 'balance' stamp: 'JD 10/19/2021 21:03:58'!
affectBalance: aBalance 
	
	^ aBalance - transfer value! !


!SourceTransfer methodsFor: 'opposite end' stamp: 'JD 10/19/2021 21:25:40'!
oppositeEnd

	^ transfer destination! !


!SourceTransfer methodsFor: 'visitor accepting' stamp: 'JD 10/22/2021 19:49:06'!
accept: aVisitor 
	
	aVisitor visitSourceTransfer: self! !


!classDefinition: #ReportCalculator category: 'Portfolio-Solucion'!
Object subclass: #ReportCalculator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportCalculator methodsFor: 'calculate' stamp: 'JD 10/22/2021 21:18:16'!
calculate

	self subclassResponsibility ! !


!ReportCalculator methodsFor: 'initialization' stamp: 'JD 10/22/2021 21:18:37'!
initializeFor: anAccount

	self subclassResponsibility ! !


!ReportCalculator methodsFor: 'visit' stamp: 'JD 10/22/2021 21:18:44'!
visitDeposit: aDeposit

	self subclassResponsibility ! !

!ReportCalculator methodsFor: 'visit' stamp: 'JD 10/22/2021 21:18:49'!
visitDestinationTransfer: aDestinationTransfer 

	self subclassResponsibility ! !

!ReportCalculator methodsFor: 'visit' stamp: 'JD 10/23/2021 17:01:46'!
visitPortfolio: aPortfolioToVisit

	self subclassResponsibility ! !

!ReportCalculator methodsFor: 'visit' stamp: 'JD 10/23/2021 17:02:01'!
visitReceptiveAccount: aReceptiveAccountToVisit

	self subclassResponsibility ! !

!ReportCalculator methodsFor: 'visit' stamp: 'JD 10/22/2021 21:18:56'!
visitSourceTransfer: aSourceTransfer 

	self subclassResponsibility ! !

!ReportCalculator methodsFor: 'visit' stamp: 'JD 10/22/2021 21:19:01'!
visitWithdraw: aWithdraw 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReportCalculator class' category: 'Portfolio-Solucion'!
ReportCalculator class
	instanceVariableNames: ''!

!ReportCalculator class methodsFor: 'instance creation' stamp: 'JD 10/22/2021 21:19:43'!
for: anAccount 
	
	^ self new initializeFor: anAccount! !


!classDefinition: #AccountSummaryCalculator category: 'Portfolio-Solucion'!
ReportCalculator subclass: #AccountSummaryCalculator
	instanceVariableNames: 'account transactionsSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryCalculator methodsFor: 'calculate' stamp: 'JD 10/22/2021 21:16:34'!
calculate
	
	| balanceSummary |

	transactionsSummary := OrderedCollection new.
	account accept: self.
	balanceSummary := OrderedCollection with: ('Balance = ', (account balance asString)).
	
	^ transactionsSummary, balanceSummary! !


!AccountSummaryCalculator methodsFor: 'initialization' stamp: 'JD 10/20/2021 17:45:54'!
initializeFor: anAccount
	
	account := anAccount! !


!AccountSummaryCalculator methodsFor: 'visit' stamp: 'JD 10/25/2021 00:03:00'!
visitDeposit: aDepositToVisit
	
	transactionsSummary add: ('Depósito por ', aDepositToVisit value asString, '.')! !

!AccountSummaryCalculator methodsFor: 'visit' stamp: 'JD 10/25/2021 00:03:07'!
visitDestinationTransfer: aDestinationTransferToVisit 
	
	transactionsSummary add: ('Entrada por transferencia de ', aDestinationTransferToVisit value asString, '.')! !

!AccountSummaryCalculator methodsFor: 'visit' stamp: 'JD 10/23/2021 16:52:08'!
visitPortfolio: aPortfolioToVisit! !

!AccountSummaryCalculator methodsFor: 'visit' stamp: 'JD 10/23/2021 16:51:47'!
visitReceptiveAccount: aReceptiveAccountToVisit! !

!AccountSummaryCalculator methodsFor: 'visit' stamp: 'JD 10/25/2021 00:03:13'!
visitSourceTransfer: aSourceTransferToVisit 

	transactionsSummary add: ('Salida por transferencia de ', aSourceTransferToVisit value asString, '.')! !

!AccountSummaryCalculator methodsFor: 'visit' stamp: 'JD 10/25/2021 00:03:18'!
visitWithdraw: aWithdrawToVisit 

	transactionsSummary add: ('Extracción por ', aWithdrawToVisit value asString, '.')! !


!classDefinition: #PortfolioStructureCalculator category: 'Portfolio-Solucion'!
ReportCalculator subclass: #PortfolioStructureCalculator
	instanceVariableNames: 'portfolio portfolioChildsStructure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructureCalculator methodsFor: 'calculate' stamp: 'JD 10/24/2021 22:15:21'!
calculate

	| portfolioStructure |
	
	portfolio accept: self.
	
	portfolioStructure := OrderedCollection with: portfolio accountName with: portfolioChildsStructure.

	^ portfolioStructure ! !


!PortfolioStructureCalculator methodsFor: 'initialization' stamp: 'JD 10/24/2021 22:14:08'!
initializeFor: aPortfolio

	portfolioChildsStructure := OrderedCollection new.
	portfolio := aPortfolio! !


!PortfolioStructureCalculator methodsFor: 'visit' stamp: 'JD 10/24/2021 22:17:17'!
visitDeposit: aDepositToVisit
! !

!PortfolioStructureCalculator methodsFor: 'visit' stamp: 'JD 10/24/2021 22:17:27'!
visitDestinationTransfer: aDestinationTransferToVisit
! !

!PortfolioStructureCalculator methodsFor: 'visit' stamp: 'JD 10/24/2021 22:13:18'!
visitPortfolio: aPortfolioToVisit
	
	| aPortfolioStructureCalculator portfolioToVisitIsNotRootStructurePortfolio |
	
	portfolioToVisitIsNotRootStructurePortfolio := aPortfolioToVisit ~= portfolio.
	portfolioToVisitIsNotRootStructurePortfolio ifTrue: [
		aPortfolioStructureCalculator := PortfolioStructureCalculator for: aPortfolioToVisit.
		portfolioChildsStructure add: aPortfolioStructureCalculator calculate.
	]
! !

!PortfolioStructureCalculator methodsFor: 'visit' stamp: 'JD 10/24/2021 22:00:11'!
visitReceptiveAccount: aReceptiveAccountToVisit

	(portfolio accountsIncludes: aReceptiveAccountToVisit) ifTrue: [
		portfolioChildsStructure add: aReceptiveAccountToVisit accountName.
	]
	
! !

!PortfolioStructureCalculator methodsFor: 'visit' stamp: 'JD 10/24/2021 22:17:36'!
visitSourceTransfer: aSourceTransferToVisit 
! !

!PortfolioStructureCalculator methodsFor: 'visit' stamp: 'JD 10/24/2021 22:17:44'!
visitWithdraw: aWithdrawToVisit
! !


!classDefinition: #PortfolioStructureWithSummaryCalculator category: 'Portfolio-Solucion'!
PortfolioStructureCalculator subclass: #PortfolioStructureWithSummaryCalculator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructureWithSummaryCalculator methodsFor: 'visit' stamp: 'JD 10/24/2021 23:58:56'!
visitReceptiveAccount: aReceptiveAccountToVisit

	| aReceptiveAccountToVisitSummary aReceptiveAccountToVisitNameWithSummary |

	(portfolio accountsIncludes: aReceptiveAccountToVisit) ifTrue: [
		aReceptiveAccountToVisitSummary := (AccountSummaryCalculator for: aReceptiveAccountToVisit) calculate.
		aReceptiveAccountToVisitNameWithSummary := OrderedCollection with: aReceptiveAccountToVisit accountName with: aReceptiveAccountToVisitSummary.
		portfolioChildsStructure add: aReceptiveAccountToVisitNameWithSummary.
	]! !


!classDefinition: #TransferNetCalculator category: 'Portfolio-Solucion'!
ReportCalculator subclass: #TransferNetCalculator
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetCalculator methodsFor: 'calculate' stamp: 'JD 10/22/2021 21:16:54'!
calculate
	
	transferNet := 0.
	account accept: self.
	
	^ transferNet! !


!TransferNetCalculator methodsFor: 'initialization' stamp: 'JD 10/22/2021 20:31:53'!
initializeFor: anAccount 

	account := anAccount! !


!TransferNetCalculator methodsFor: 'visit' stamp: 'JD 10/25/2021 00:03:34'!
visitDeposit: aDepositToVisit! !

!TransferNetCalculator methodsFor: 'visit' stamp: 'JD 10/25/2021 00:03:38'!
visitDestinationTransfer: aDestinationTransferToVisit 
	
	transferNet := transferNet + aDestinationTransferToVisit value! !

!TransferNetCalculator methodsFor: 'visit' stamp: 'JD 10/23/2021 17:01:22'!
visitPortfolio: aPortfolioToVisit! !

!TransferNetCalculator methodsFor: 'visit' stamp: 'JD 10/23/2021 16:52:31'!
visitReceptiveAccount: aReceptiveAccountToVisit! !

!TransferNetCalculator methodsFor: 'visit' stamp: 'JD 10/25/2021 00:03:45'!
visitSourceTransfer: aSourceTransferToVisit 
	
	transferNet := transferNet - aSourceTransferToVisit value! !

!TransferNetCalculator methodsFor: 'visit' stamp: 'JD 10/25/2021 00:03:48'!
visitWithdraw: aWithdrawToVisit! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'source destination value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'JD 10/25/2021 00:07:50'!
initializeFor: aTransferAmount from: aTransferEmitter to: aTransferReceiver 

	self assertThatTheTransferAmountIsBiggerThanZero: aTransferAmount.
	self assertThatTransferReceiver: aTransferReceiver isNotEqualToTransferEmitter: aTransferEmitter.
	
	value := aTransferAmount.
	source := SourceTransfer register: self on: aTransferEmitter. 
	destination := DestinationTransfer register: self on: aTransferReceiver! !


!Transfer methodsFor: 'endpoints' stamp: 'JD 10/19/2021 19:10:35'!
destination

	^ destination! !

!Transfer methodsFor: 'endpoints' stamp: 'JD 10/19/2021 18:52:10'!
source

	^ source! !


!Transfer methodsFor: 'value' stamp: 'JD 10/19/2021 21:05:54'!
value

	^ value! !


!Transfer methodsFor: 'assertions' stamp: 'JD 10/25/2021 00:06:33'!
assertThatTheTransferAmountIsBiggerThanZero: aTransferAmount

	^ self assert: aTransferAmount > 0 description: [self error: self class cannotTransferANonPositiveAmountErrorDescription ]! !

!Transfer methodsFor: 'assertions' stamp: 'JD 10/25/2021 00:07:50'!
assertThatTransferReceiver: aTransferReceiver isNotEqualToTransferEmitter: aTransferEmitter

	^ self assert: aTransferEmitter ~= aTransferReceiver description: [self error: self class cannotTransferToItselfErrorDescription]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'error messages' stamp: 'JD 10/19/2021 18:31:54'!
cannotTransferANonPositiveAmountErrorDescription
	
	^ 'Cannot transfer a negative amount'! !

!Transfer class methodsFor: 'error messages' stamp: 'JD 10/19/2021 18:32:01'!
cannotTransferToItselfErrorDescription
	
	^ 'The emitter and the receiver of a transfer cannot be the same'! !


!Transfer class methodsFor: 'instance creation' stamp: 'JD 10/19/2021 18:29:10'!
register: aTransferAmount from: aTransferEmitter to: aTransferReceiver
	
	^ self new initializeFor: aTransferAmount from: aTransferEmitter to: aTransferReceiver ! !
