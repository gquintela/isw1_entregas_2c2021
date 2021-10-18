!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/17/2021 22:24:16'!
test03CannotAddAPortfolioToItself

	| anEmptyPortfolio  |
	
	anEmptyPortfolio := self createAnEmptyPortfolio.

	self assertThatCannotAddPortfolio: anEmptyPortfolio to: anEmptyPortfolio ! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/17/2021 22:21:22'!
test04CannotAddAPortfolioInAPortfolioAlreadyContainingIt

	| aRootPortfolio aChildPortfolio aGrandchildPortfolio |
	
	aGrandchildPortfolio := self createAnEmptyPortfolio.
	aChildPortfolio := self createAPortfolioWithPortfolio: aGrandchildPortfolio.
	aRootPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.

	self assertThatCannotAddPortfolio: aGrandchildPortfolio to: aRootPortfolio! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/17/2021 22:21:27'!
test05CannotAddAReceptiveAccountInAPortfolioAlreadyContainingIt

	| aRootPortfolio aChildPortfolio aGrandchildPortfolio aReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	
	aGrandchildPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount .
	aChildPortfolio := self createAPortfolioWithPortfolio: aGrandchildPortfolio.
	aRootPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.

	self assertThatCannotAddReceptiveAccount: aReceptiveAccount to: aRootPortfolio ! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/17/2021 22:21:32'!
test06CannotAddAReceptiveAccountInAPortfolioContainedInAnotherAlreadyContainigIt

	| aRootPortfolio aChildPortfolio anotherChildPortfolio aGrandchildPortfolio aReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aGrandchildPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	aChildPortfolio := self createAnEmptyPortfolio.
	anotherChildPortfolio := self createAPortfolioWithPortfolio: aGrandchildPortfolio.
	aRootPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.
	aRootPortfolio addPortfolio: anotherChildPortfolio.
	
	self assertThatCannotAddReceptiveAccount: aReceptiveAccount to: aChildPortfolio! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/17/2021 22:21:37'!
test07CannotAddAPortfolioInAPortfolioContainedInAnotherWhichSharesAReceptiveAccount

	| aRootPortfolio aChildPortfolio anotherChildPortfolio aGrandchildPortfolio anotherGrandchildPortfolio aReceptiveAccount|
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aGrandchildPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	aChildPortfolio := self createAPortfolioWithPortfolio: aGrandchildPortfolio.
	anotherChildPortfolio := self createAnEmptyPortfolio.
	aRootPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.
	aRootPortfolio addPortfolio: anotherChildPortfolio.
	anotherGrandchildPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	
	self assertThatCannotAddPortfolio: anotherGrandchildPortfolio to: anotherChildPortfolio.! !


!PortfolioTest methodsFor: 'assertions' stamp: 'JD 10/16/2021 17:21:03'!
assertThatCannotAddPortfolio: aPortfolioToAdd to: aPortfolio

	self
		should: [ aPortfolio addPortfolio: aPortfolioToAdd ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio cannotAddPortfolioErrorDescription ]! !

!PortfolioTest methodsFor: 'assertions' stamp: 'JD 10/16/2021 17:21:14'!
assertThatCannotAddReceptiveAccount: aReceptiveAccountToAdd to: aPortfolio

	self
		should: [ aPortfolio addReceptiveAccount: aReceptiveAccountToAdd ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio receptiveAccountAlreadyContainedErrorDescription ]! !


!PortfolioTest methodsFor: 'balance tests' stamp: 'JD 10/17/2021 21:05:05'!
test01AnEmptyPortfolioBalanceIsZero
	
	| anEmptyPortfolio |
	
	anEmptyPortfolio := self createAnEmptyPortfolio.
	
	self assert: 0 equals: anEmptyPortfolio balance! !

!PortfolioTest methodsFor: 'balance tests' stamp: 'JD 10/17/2021 21:23:46'!
test02APortfolioWithManyPortfoliosAndReceptiveAccountsBalanceIsCorrect
	
	| aPortfolio aPortfolioToAdd anotherPortfolioToAdd aReceptiveAccount anotherReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aPortfolioToAdd := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	
	anotherReceptiveAccount := self createAReceptiveAccountWithADepositOf: 50.
	anotherPortfolioToAdd := self createAPortfolioWithReceptiveAccount: anotherReceptiveAccount.
	
	aPortfolio := self createAPortfolioWithPortfolio: aPortfolioToAdd.
	aPortfolio addPortfolio: anotherPortfolioToAdd.

	self assert: (aReceptiveAccount balance + anotherReceptiveAccount balance) equals: aPortfolio balance! !


!PortfolioTest methodsFor: 'creation' stamp: 'JD 10/16/2021 17:21:03'!
createAPortfolioWithPortfolio: aPortfolioToAdd
	
	| aPortfolio |
	
	aPortfolio := self createAnEmptyPortfolio.

	aPortfolio addPortfolio: aPortfolioToAdd.
	
	^ aPortfolio! !

!PortfolioTest methodsFor: 'creation' stamp: 'JD 10/16/2021 17:21:14'!
createAPortfolioWithReceptiveAccount: aReceptiveAccount
	
	| aPortfolio |

	aPortfolio := self createAnEmptyPortfolio.	
	aPortfolio addReceptiveAccount: aReceptiveAccount.

	^ aPortfolio! !

!PortfolioTest methodsFor: 'creation' stamp: 'JD 10/15/2021 19:54:04'!
createAReceptiveAccountWithADepositOf: aDepositAmount
	
	| aReceptiveAccount |
	
	aReceptiveAccount := ReceptiveAccount new.
	aReceptiveAccount register: (Deposit for: aDepositAmount).
	
	^ aReceptiveAccount 
! !

!PortfolioTest methodsFor: 'creation' stamp: 'JD 10/15/2021 20:03:52'!
createAnEmptyPortfolio

	^ Portfolio new! !


!PortfolioTest methodsFor: 'testing tests' stamp: 'JD 10/17/2021 22:22:08'!
test10AnEmptyPortfolioHasNotRegisteredAnyTransaction
	
	| anEmptyPortfolio aDeposit |
	
	aDeposit := Deposit for: 30.
	anEmptyPortfolio := self createAnEmptyPortfolio.
	
	self deny: (anEmptyPortfolio hasRegistered: aDeposit)! !

!PortfolioTest methodsFor: 'testing tests' stamp: 'JD 10/17/2021 22:22:14'!
test11CanRegisterATransactionInAPortfolio
	
	| aPortfolio aReceptiveAccount aDeposit |

	aReceptiveAccount := ReceptiveAccount new.
	aDeposit := Deposit for: 30.
	aReceptiveAccount register: aDeposit.
	
	aPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	
	self assert: (aPortfolio hasRegistered: aDeposit)! !


!PortfolioTest methodsFor: 'transactions tests' stamp: 'JD 10/17/2021 22:21:53'!
test08AnEmptyPortfolioHasNotTransactions
	
	| anEmptyPortfolio |
	
	anEmptyPortfolio := self createAnEmptyPortfolio.
	
	self assert: anEmptyPortfolio transactions isEmpty! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'JD 10/17/2021 22:21:58'!
test09ThePortfolioTransactionsAreItsReceptiveAccountsTransactions
	
	| aPortfolio aChildPortfolio aReceptiveAccount anotherReceptiveAccount expectedTransactions |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aChildPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	anotherReceptiveAccount := self createAReceptiveAccountWithADepositOf: 20.
	aPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.
	aPortfolio addReceptiveAccount: anotherReceptiveAccount.
	
	expectedTransactions := aReceptiveAccount transactions, anotherReceptiveAccount transactions.
	self assert: expectedTransactions equals: aPortfolio transactions! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'JD 10/7/2021 21:15:51'!
updateBalance: aParcialBalanceToUpdate

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !

!Deposit methodsFor: 'initialization' stamp: 'JD 10/7/2021 21:16:24'!
updateBalance: aParcialBalanceToUpdate

	^ aParcialBalanceToUpdate + self value ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !

!Withdraw methodsFor: 'initialization' stamp: 'JD 10/7/2021 21:16:17'!
updateBalance: aParcialBalanceToUpdate

	^ aParcialBalanceToUpdate - self value ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #NullPortfolio category: 'Portfolio-Ejercicio'!
Object subclass: #NullPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!NullPortfolio methodsFor: 'testing' stamp: 'JD 10/17/2021 21:00:30'!
canAddPortfolio: aPortfolioToAdd
	
	^ true! !

!NullPortfolio methodsFor: 'testing' stamp: 'JD 10/17/2021 21:01:30'!
canAddReceptiveAccount: aReceptiveAccount
	
	^ true! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'receptiveAccounts portfolios portfolioContainer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'JD 10/17/2021 20:59:18'!
initialize
	receptiveAccounts := OrderedCollection new.
	portfolios := OrderedCollection new.
	portfolioContainer := NullPortfolio new! !


!Portfolio methodsFor: 'adding' stamp: 'JD 10/17/2021 22:30:07'!
addPortfolio: aPortfolioToAdd

	self assertThatCanAddPortfolio: aPortfolioToAdd.

	aPortfolioToAdd updatePortfolioContainerWith: self. 

	portfolios add: aPortfolioToAdd.! !

!Portfolio methodsFor: 'adding' stamp: 'JD 10/17/2021 22:30:53'!
addReceptiveAccount: aReceptiveAccountToAdd

	self assertThatCanAddReceptiveAccount: aReceptiveAccountToAdd.

	receptiveAccounts add: aReceptiveAccountToAdd! !


!Portfolio methodsFor: 'accessing' stamp: 'JD 10/17/2021 22:33:39'!
balance
	
	^ self receptiveAccountsBalance + self portfoliosBalance! !

!Portfolio methodsFor: 'accessing' stamp: 'JD 10/17/2021 22:33:15'!
portfoliosBalance

	^ portfolios sum: [ :aPortfolio | aPortfolio balance] ifEmpty: [0]! !

!Portfolio methodsFor: 'accessing' stamp: 'JD 10/17/2021 22:35:02'!
portfoliosTransactions

	^ portfolios collect: [ :aPortfolio | aPortfolio transactions]! !

!Portfolio methodsFor: 'accessing' stamp: 'JD 10/16/2021 17:37:07'!
receptiveAccounts
	
	^ receptiveAccounts copy! !

!Portfolio methodsFor: 'accessing' stamp: 'JD 10/17/2021 22:33:03'!
receptiveAccountsBalance

	^ receptiveAccounts sum: [ :aReceptiveAccount | aReceptiveAccount balance] ifEmpty: [0]! !

!Portfolio methodsFor: 'accessing' stamp: 'JD 10/17/2021 22:35:52'!
receptiveAccountsTransactions
	
	^ (receptiveAccounts collect: [ :aReceptiveAccount | aReceptiveAccount transactions]) flatten! !

!Portfolio methodsFor: 'accessing' stamp: 'JD 10/17/2021 22:37:28'!
transactions

	^ (self portfoliosTransactions, self receptiveAccountsTransactions) flatten! !


!Portfolio methodsFor: 'exceptions' stamp: 'JD 10/17/2021 22:40:25'!
signalCannotAddPortfolio

	^ self error: self class cannotAddPortfolioErrorDescription! !

!Portfolio methodsFor: 'exceptions' stamp: 'JD 10/15/2021 19:40:30'!
signalReceptiveAccountAlreadyContained

	^ self error: self class receptiveAccountAlreadyContainedErrorDescription! !


!Portfolio methodsFor: 'testing' stamp: 'JD 10/17/2021 21:03:29'!
canAddPortfolio: aPortfolioToAdd

	^ (portfolioContainer canAddPortfolio: aPortfolioToAdd) and: 
		[self notIncludesPortfolio: aPortfolioToAdd] and: 
		[self notIncludesAnyReceptiveAccountOf: aPortfolioToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/17/2021 21:03:01'!
canAddReceptiveAccount: aReceptiveAccount 
		
	^ (portfolioContainer canAddReceptiveAccount: aReceptiveAccount) and: 
		[self notIncludesReceptiveAccount: aReceptiveAccount]! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/16/2021 18:17:32'!
hasRegistered: aTransaction
	
	^ self transactions includes: aTransaction! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/17/2021 22:38:03'!
notIncludesAnyReceptiveAccountOf: aPortfolioToAdd

	^ (self notIncludesAsChildAnyReceptiveAccountOf: aPortfolioToAdd) and: 
		[portfolios allSatisfy: [ :aChildPortfolio | aChildPortfolio notIncludesAnyReceptiveAccountOf: aPortfolioToAdd]]! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/16/2021 16:57:21'!
notIncludesAsChildAnyReceptiveAccountOf: aPortfolioToAdd

	^ (receptiveAccounts includesAnyOf: aPortfolioToAdd receptiveAccounts) not.! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/17/2021 22:39:05'!
notIncludesPortfolio: aPortfolio
	
	^ (self ~= aPortfolio) and: 
		[(self notIncludesPortfolioAsChild: aPortfolio)] and: 
			[portfolios allSatisfy: [ :aChildPortfolio | aChildPortfolio notIncludesPortfolio: aPortfolio ]]! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/16/2021 16:32:55'!
notIncludesPortfolioAsChild: aPortfolio

	^ (portfolios includes: aPortfolio) not! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/17/2021 22:39:26'!
notIncludesReceptiveAccount: aReceptiveAccount
	
	^ (self notIncludesReceptiveAccountAsChild: aReceptiveAccount) and: 
		[portfolios allSatisfy: [ :aPortfolio | aPortfolio notIncludesReceptiveAccount: aReceptiveAccount ]]! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/16/2021 16:33:03'!
notIncludesReceptiveAccountAsChild: aReceptiveAccount

	^ (receptiveAccounts includes: aReceptiveAccount) not.! !


!Portfolio methodsFor: 'modifiers' stamp: 'JD 10/17/2021 22:30:07'!
updatePortfolioContainerWith: aPortfolio 
	
	portfolioContainer := aPortfolio! !


!Portfolio methodsFor: 'assertions' stamp: 'JD 10/17/2021 22:40:25'!
assertThatCanAddPortfolio: aPortfolioToAdd

	^ self assert: (self canAddPortfolio: aPortfolioToAdd) description: [self signalCannotAddPortfolio]! !

!Portfolio methodsFor: 'assertions' stamp: 'JD 10/17/2021 22:30:53'!
assertThatCanAddReceptiveAccount: aReceptiveAccountToAdd

	^ self assert: (self canAddReceptiveAccount: aReceptiveAccountToAdd) description: [self signalReceptiveAccountAlreadyContained]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'JD 10/16/2021 17:09:57'!
cannotAddPortfolioErrorDescription
	^ 'Cannot add the specified portfolio'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'JD 10/16/2021 17:10:51'!
receptiveAccountAlreadyContainedErrorDescription
	^ 'Receptive account already contained in the portfolio'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'JD 10/7/2021 21:15:29'!
balance
	
	| parcialBalance |
	
	parcialBalance := 0.
	
	transactions do: [ :aTransaction | 
		parcialBalance := aTransaction updateBalance: parcialBalance
	].
	
	^ parcialBalance.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
