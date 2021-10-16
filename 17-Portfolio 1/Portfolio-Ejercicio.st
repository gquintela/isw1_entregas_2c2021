!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 12:32:30'!
test07

	| aPortfolio aReceptiveAccount  |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	
	aPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.

	self assertThatCannotAddReceptiveAccount: aReceptiveAccount to: aPortfolio ! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 12:32:08'!
test08

	| aPortfolio  |
	
	aPortfolio := self createAnEmptyPortfolio.

	self assertThatCannotAddPortfolio: aPortfolio to: aPortfolio ! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 12:33:40'!
test09

	| aPortfolio aPortfolioToAdd aReceptiveAccount  |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	
	aPortfolioToAdd := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.

	self assertThatCannotAddPortfolio: aPortfolioToAdd to: aPortfolio! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 17:21:14'!
test10

	| aPortfolio aPortfolioToAdd aReceptiveAccount anotherReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	anotherReceptiveAccount := self createAReceptiveAccountWithADepositOf: 20.
	aPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	
	aPortfolioToAdd := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	aPortfolioToAdd addReceptiveAccount: anotherReceptiveAccount.
	
	self assertThatCannotAddPortfolio: aPortfolioToAdd to: aPortfolio! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 12:32:07'!
test11

	| aPortfolio aPortfolioToAdd |
	
	aPortfolio := self createAnEmptyPortfolio.
	aPortfolioToAdd := self createAPortfolioWithPortfolio: aPortfolio.

	self assertThatCannotAddPortfolio: aPortfolioToAdd to: aPortfolio ! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 12:32:30'!
test12

	| aPortfolio anotherPortfolio aReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	anotherPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	
	aPortfolio := self createAPortfolioWithPortfolio: anotherPortfolio.	

	self assertThatCannotAddReceptiveAccount: aReceptiveAccount to: aPortfolio ! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 17:21:03'!
test13

	| aPortfolio anotherPortfolio aReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.

	anotherPortfolio := self createAnEmptyPortfolio.	
	aPortfolio addPortfolio: anotherPortfolio.

	self assertThatCannotAddReceptiveAccount: aReceptiveAccount to: anotherPortfolio ! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 12:32:08'!
test14

	| aRootPortfolio aChildPortfolio aGrandchildPortfolio |
	
	aGrandchildPortfolio := self createAnEmptyPortfolio.
	aChildPortfolio := self createAPortfolioWithPortfolio: aGrandchildPortfolio.
	aRootPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.

	self assertThatCannotAddPortfolio: aGrandchildPortfolio to: aRootPortfolio! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 17:21:03'!
test15

	| aRootPortfolio aChildPortfolio anotherChildPortfolio |
	
	aChildPortfolio := self createAnEmptyPortfolio.
	anotherChildPortfolio := self createAnEmptyPortfolio.
	
	aRootPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.
	aRootPortfolio addPortfolio: anotherChildPortfolio.
	
	self assertThatCannotAddPortfolio: anotherChildPortfolio to: aChildPortfolio! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 12:32:30'!
test16

	| firstLevelPortfolio secondLevelPortfolio thirdLevelPortfolio aReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	
	thirdLevelPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount .
	secondLevelPortfolio := self createAPortfolioWithPortfolio: thirdLevelPortfolio.
	firstLevelPortfolio := self createAPortfolioWithPortfolio: secondLevelPortfolio.

	self assertThatCannotAddReceptiveAccount: aReceptiveAccount to: firstLevelPortfolio ! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 17:21:14'!
test17

	| firstLevelPortfolio secondLevelPortfolio thirdLevelPortfolio aReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	
	thirdLevelPortfolio := self createAnEmptyPortfolio.
	secondLevelPortfolio := self createAPortfolioWithPortfolio: thirdLevelPortfolio.
	firstLevelPortfolio := self createAPortfolioWithPortfolio: secondLevelPortfolio.
	firstLevelPortfolio addReceptiveAccount: aReceptiveAccount.

	self assertThatCannotAddReceptiveAccount: aReceptiveAccount to: thirdLevelPortfolio 
! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 12:32:07'!
test18

	| aRootPortfolio aChildPortfolio aGrandchildPortfolio aGreatGrandchildPortfolio |
	
	aGreatGrandchildPortfolio := self createAnEmptyPortfolio.
	aGrandchildPortfolio := self createAPortfolioWithPortfolio: aGreatGrandchildPortfolio .
	aChildPortfolio := self createAPortfolioWithPortfolio: aGrandchildPortfolio.
	aRootPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.

	self assertThatCannotAddPortfolio: aGreatGrandchildPortfolio to: aRootPortfolio! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 17:21:03'!
test19

	| aRootPortfolio aChildPortfolio anotherChildPortfolio aGrandchildPortfolio |
	
	aGrandchildPortfolio := self createAnEmptyPortfolio.
	aChildPortfolio := self createAPortfolioWithPortfolio: aGrandchildPortfolio.
	aRootPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.
	anotherChildPortfolio := self createAnEmptyPortfolio.
	aRootPortfolio addPortfolio: anotherChildPortfolio.	

	self assertThatCannotAddPortfolio: anotherChildPortfolio to: aGrandchildPortfolio! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 17:21:14'!
test20

	| aRootPortfolio aChildPortfolio aGrandchildPortfolio aReceptiveAccount |
	
	aChildPortfolio := self createAnEmptyPortfolio.
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aRootPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.
	aRootPortfolio addReceptiveAccount: aReceptiveAccount.
	aGrandchildPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.

	self assertThatCannotAddPortfolio: aGrandchildPortfolio to: aChildPortfolio! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 17:21:03'!
test21

	| aRootPortfolio aChildPortfolio anotherChildPortfolio aReceptiveAccount |
	
	aChildPortfolio := self createAnEmptyPortfolio.
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	anotherChildPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	aRootPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.
	aRootPortfolio addPortfolio: anotherChildPortfolio.

	self assertThatCannotAddReceptiveAccount: aReceptiveAccount to: aChildPortfolio! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 14:50:39'!
test22

	| aRootPortfolio aChildPortfolio anotherChildPortfolio aReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aChildPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	aRootPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.
	anotherChildPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	
	self assertThatCannotAddPortfolio: anotherChildPortfolio to: aRootPortfolio! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 17:21:03'!
test23

	| aRootPortfolio aChildPortfolio anotherChildPortfolio aGrandchildPortfolio aReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aGrandchildPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	aChildPortfolio := self createAnEmptyPortfolio.
	anotherChildPortfolio := self createAPortfolioWithPortfolio: aGrandchildPortfolio.
	aRootPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.
	aRootPortfolio addPortfolio: anotherChildPortfolio.
	
	self assertThatCannotAddReceptiveAccount: aReceptiveAccount to: aChildPortfolio! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 17:21:03'!
test24

	| aRootPortfolio aChildPortfolio anotherChildPortfolio aGrandchildPortfolio aGreatGrandchildPortfolio |
	
	aGreatGrandchildPortfolio := self createAnEmptyPortfolio.
	aGrandchildPortfolio := self createAPortfolioWithPortfolio: aGreatGrandchildPortfolio.
	aChildPortfolio := self createAnEmptyPortfolio.
	anotherChildPortfolio := self createAPortfolioWithPortfolio: aGrandchildPortfolio.
	aRootPortfolio := self createAPortfolioWithPortfolio: aChildPortfolio.
	aRootPortfolio addPortfolio: anotherChildPortfolio.
	
	self assertThatCannotAddPortfolio: aGreatGrandchildPortfolio to: aChildPortfolio! !

!PortfolioTest methodsFor: 'add tests' stamp: 'JD 10/16/2021 17:21:03'!
test25

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


!PortfolioTest methodsFor: 'balance tests' stamp: 'JD 10/15/2021 20:03:52'!
test01
	
	| anEmptyPortfolio |
	
	anEmptyPortfolio := self createAnEmptyPortfolio.
	
	self assert: 0 equals: anEmptyPortfolio balance! !

!PortfolioTest methodsFor: 'balance tests' stamp: 'JD 10/15/2021 20:06:39'!
test02
	
	| aPortfolio aReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.

	self assert: 30 equals: aPortfolio balance! !

!PortfolioTest methodsFor: 'balance tests' stamp: 'JD 10/15/2021 20:08:30'!
test03
	
	| aPortfolio aReceptiveAccount aPortfolioToAdd |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aPortfolioToAdd := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	aPortfolio := self createAPortfolioWithPortfolio: aPortfolioToAdd.

	self assert: 30 equals: aPortfolio balance! !

!PortfolioTest methodsFor: 'balance tests' stamp: 'JD 10/16/2021 17:21:14'!
test04
	
	| aPortfolio aReceptiveAccount anotherReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	anotherReceptiveAccount := self createAReceptiveAccountWithADepositOf: 40.
	aPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	
	aPortfolio addReceptiveAccount: anotherReceptiveAccount.

	self assert: 70 equals: aPortfolio balance! !

!PortfolioTest methodsFor: 'balance tests' stamp: 'JD 10/16/2021 17:21:03'!
test05
	
	| aPortfolio aPortfolioToAdd anotherPortfolioToAdd aReceptiveAccount anotherReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aPortfolioToAdd := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	
	anotherReceptiveAccount := self createAReceptiveAccountWithADepositOf: 50.
	anotherPortfolioToAdd := self createAPortfolioWithReceptiveAccount: anotherReceptiveAccount.
	
	aPortfolio := self createAPortfolioWithPortfolio: aPortfolioToAdd.
	aPortfolio addPortfolio: anotherPortfolioToAdd.

	self assert: 80 equals: aPortfolio balance! !

!PortfolioTest methodsFor: 'balance tests' stamp: 'JD 10/16/2021 17:21:03'!
test06
	
	| aPortfolio aPortfolioToAdd aReceptiveAccount anotherReceptiveAccount |

	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	
	anotherReceptiveAccount := self createAReceptiveAccountWithADepositOf: 60.
	aPortfolioToAdd := self createAPortfolioWithReceptiveAccount: anotherReceptiveAccount.
	
	aPortfolio addPortfolio: aPortfolioToAdd.

	self assert: 90 equals: aPortfolio balance! !


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


!PortfolioTest methodsFor: 'testing tests' stamp: 'JD 10/16/2021 18:14:07'!
test29
	
	| anEmptyPortfolio aDeposit |
	
	aDeposit := Deposit for: 30.
	anEmptyPortfolio := self createAnEmptyPortfolio.
	
	self deny: (anEmptyPortfolio hasRegistered: aDeposit)! !

!PortfolioTest methodsFor: 'testing tests' stamp: 'JD 10/16/2021 18:16:52'!
test30
	
	| aPortfolio aReceptiveAccount aDeposit |

	aReceptiveAccount := ReceptiveAccount new.
	aDeposit := Deposit for: 30.
	aReceptiveAccount register: aDeposit.
	
	aPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	
	self assert: (aPortfolio hasRegistered: aDeposit)! !


!PortfolioTest methodsFor: 'transactions tests' stamp: 'JD 10/16/2021 17:40:31'!
test26
	
	| anEmptyPortfolio |
	
	anEmptyPortfolio := self createAnEmptyPortfolio.
	
	self assert: anEmptyPortfolio transactions isEmpty! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'JD 10/16/2021 17:43:29'!
test27
	
	| aPortfolio aReceptiveAccount |
	
	aReceptiveAccount := self createAReceptiveAccountWithADepositOf: 30.
	aPortfolio := self createAPortfolioWithReceptiveAccount: aReceptiveAccount.
	
	self assert: aReceptiveAccount transactions equals: aPortfolio transactions! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'JD 10/16/2021 17:55:59'!
test28
	
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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'receptiveAccounts portfolios portfolioContainer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'JD 10/15/2021 22:07:28'!
initialize
	receptiveAccounts := OrderedCollection new.
	portfolios := OrderedCollection new.
	portfolioContainer := nil! !


!Portfolio methodsFor: 'adding' stamp: 'JD 10/16/2021 17:21:03'!
addPortfolio: aPortfolioToAdd

	self assert: (self canAddPortfolio: aPortfolioToAdd) description: [self signalPortfolioAlreadyContained].

	aPortfolioToAdd portfolioContainer: self. 

	portfolios add: aPortfolioToAdd.! !

!Portfolio methodsFor: 'adding' stamp: 'JD 10/16/2021 17:21:14'!
addReceptiveAccount: aReceptiveAccount

	self assert: (self canAddReceptiveAccount: aReceptiveAccount) description: [self signalReceptiveAccountAlreadyContained].

	receptiveAccounts add: aReceptiveAccount! !


!Portfolio methodsFor: 'accessing' stamp: 'JD 10/15/2021 17:07:51'!
balance
	
	| totalBalance |
	
	totalBalance := 0.
	totalBalance := totalBalance + (receptiveAccounts sum: [ :aReceptiveAccount | aReceptiveAccount balance] ifEmpty: [0]).
	
	totalBalance := totalBalance + (portfolios sum: [ :aPortfolio | aPortfolio balance] ifEmpty: [0]).

	^ totalBalance ! !

!Portfolio methodsFor: 'accessing' stamp: 'JD 10/16/2021 17:37:07'!
receptiveAccounts
	
	^ receptiveAccounts copy! !

!Portfolio methodsFor: 'accessing' stamp: 'JD 10/16/2021 18:00:28'!
transactions
	
	| childsTransactions |
	
	childsTransactions := (portfolios collect: [ :aPortfolio | aPortfolio transactions]).
	^ (childsTransactions, (receptiveAccounts collect: [ :aReceptiveAccount | aReceptiveAccount transactions])) flatten! !


!Portfolio methodsFor: 'exceptions' stamp: 'JD 10/16/2021 17:09:36'!
signalPortfolioAlreadyContained

	^ self error: self class cannotAddPortfolioErrorDescription! !

!Portfolio methodsFor: 'exceptions' stamp: 'JD 10/15/2021 19:40:30'!
signalReceptiveAccountAlreadyContained

	^ self error: self class receptiveAccountAlreadyContainedErrorDescription! !


!Portfolio methodsFor: 'testing' stamp: 'JD 10/16/2021 17:20:47'!
canAddPortfolio: aPortfolioToAdd

	| canAddPortfolioInPortfolioContainer |
	
	canAddPortfolioInPortfolioContainer := true.

	portfolioContainer isNil ifFalse: [
		canAddPortfolioInPortfolioContainer := (portfolioContainer canAddPortfolio: aPortfolioToAdd)
	].

	^ canAddPortfolioInPortfolioContainer and: [self notIncludesPortfolio: aPortfolioToAdd] and: [self notIncludesAnyReceptiveAccountOf: aPortfolioToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/16/2021 17:20:35'!
canAddReceptiveAccount: aReceptiveAccount 
	
	| canAddReceptiveAccountInPortfolioContainer |
	
	canAddReceptiveAccountInPortfolioContainer := true.

	portfolioContainer isNil ifFalse: [
		canAddReceptiveAccountInPortfolioContainer := portfolioContainer canAddReceptiveAccount: aReceptiveAccount
	].
		
	^ canAddReceptiveAccountInPortfolioContainer and: [self notIncludesReceptiveAccount: aReceptiveAccount]! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/16/2021 18:17:32'!
hasRegistered: aTransaction
	
	^ self transactions includes: aTransaction! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/16/2021 16:59:36'!
notIncludesAnyReceptiveAccountOf: aPortfolioToAdd

	^ (self notIncludesAsChildAnyReceptiveAccountOf: aPortfolioToAdd) and: [portfolios allSatisfy: [ :aChildPortfolio | aChildPortfolio notIncludesAnyReceptiveAccountOf: aPortfolioToAdd]]! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/16/2021 16:57:21'!
notIncludesAsChildAnyReceptiveAccountOf: aPortfolioToAdd

	^ (receptiveAccounts includesAnyOf: aPortfolioToAdd receptiveAccounts) not.! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/16/2021 17:03:58'!
notIncludesPortfolio: aPortfolio
	
	^ (self ~= aPortfolio) and: [(self notIncludesPortfolioAsChild: aPortfolio)] and: [portfolios allSatisfy: [ :aChildPortfolio | aChildPortfolio notIncludesPortfolio: aPortfolio ]]! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/16/2021 16:32:55'!
notIncludesPortfolioAsChild: aPortfolio

	^ (portfolios includes: aPortfolio) not! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/16/2021 16:15:55'!
notIncludesReceptiveAccount: aReceptiveAccount
	
	^ (self notIncludesReceptiveAccountAsChild: aReceptiveAccount) and: [portfolios allSatisfy: [ :aPortfolio | aPortfolio notIncludesReceptiveAccount: aReceptiveAccount ]]! !

!Portfolio methodsFor: 'testing' stamp: 'JD 10/16/2021 16:33:03'!
notIncludesReceptiveAccountAsChild: aReceptiveAccount

	^ (receptiveAccounts includes: aReceptiveAccount) not.! !


!Portfolio methodsFor: 'modifiers' stamp: 'JD 10/15/2021 22:08:53'!
portfolioContainer: aPortfolio 
	
	portfolioContainer := aPortfolio! !

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
