!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'aTusLibrosTestObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'JD 11/2/2021 18:29:02'!
setUp
	
	aTusLibrosTestObjectsFactory := TusLibrosTestObjectsFactory new! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/3/2021 20:12:40'!
test01NewCartsAreCreatedEmpty

	self assert: aTusLibrosTestObjectsFactory createCartWithDefaultCatalog isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/3/2021 20:12:40'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCartWithDefaultCatalog.
	
	self 
		should: [ cart add: aTusLibrosTestObjectsFactory itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/3/2021 20:12:40'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCartWithDefaultCatalog.
	
	cart add: aTusLibrosTestObjectsFactory itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/3/2021 20:12:40'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCartWithDefaultCatalog.
	
	self 
		should: [cart add: 0 of: aTusLibrosTestObjectsFactory itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/3/2021 20:12:40'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCartWithDefaultCatalog.
	
	self 
		should: [cart add: 2 of: aTusLibrosTestObjectsFactory itemNotSoldByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/3/2021 20:12:40'!
test06CartRemembersAddedItems

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCartWithDefaultCatalog.
	
	cart add: aTusLibrosTestObjectsFactory itemSoldByTheStore.
	self assert: (cart includes: aTusLibrosTestObjectsFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/3/2021 20:12:40'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCartWithDefaultCatalog.
	
	self deny: (cart includes: aTusLibrosTestObjectsFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/3/2021 20:12:40'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCartWithDefaultCatalog.
	
	cart add: 2 of: aTusLibrosTestObjectsFactory itemSoldByTheStore.
	self assert: (cart occurrencesOf: aTusLibrosTestObjectsFactory itemSoldByTheStore) = 2! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'tusLibrosTestObjectsFactory salesRecord'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'JD 11/3/2021 21:16:56'!
test01CannotCreateACashierForAnEmptyCart

	self assertThatCreatACashierFor: (tusLibrosTestObjectsFactory createCartWithDefaultCatalog) payingWith: (tusLibrosTestObjectsFactory validCreditCard) shouldRaiseErrorWithDescription: (Cashier cartCannotBeEmptyErrorMessage).! !

!CashierTest methodsFor: 'tests' stamp: 'JD 11/3/2021 21:23:20'!
test02CanCheckoutACartWithManyItems
	
	| aCashier totalCheckout aCartWithAnItem |

	aCartWithAnItem := tusLibrosTestObjectsFactory createCartWithDefaultCatalog add: 2 of: tusLibrosTestObjectsFactory itemSoldByTheStore.
	aCashier := self createACashierOnTodayFor: aCartWithAnItem payingWith: tusLibrosTestObjectsFactory validCreditCard using: tusLibrosTestObjectsFactory posnet.

	totalCheckout := aCashier checkout.
	
	self assert: 40*dollar equals: totalCheckout! !

!CashierTest methodsFor: 'tests' stamp: 'JD 11/3/2021 21:17:52'!
test03CannotCreateACashierWithAnExpiredCard
	
	| aCartWithAnItem |

	aCartWithAnItem := self createACartWithDefaultCatalogAndAnItemSoldByTheStore.

	self assertThatCreatACashierFor: aCartWithAnItem payingWith: (tusLibrosTestObjectsFactory expiredCreditCard) shouldRaiseErrorWithDescription: (Cashier creditCardIsExpiredErrorMessage).! !

!CashierTest methodsFor: 'tests' stamp: 'JD 11/3/2021 21:18:19'!
test04CannotCreateACashierWithACardWithAnInvalidCreditCardNumber
	
	| aCartWithAnItem |

	aCartWithAnItem := self createACartWithDefaultCatalogAndAnItemSoldByTheStore.

	self assertThatCreatACashierFor: aCartWithAnItem payingWith: (tusLibrosTestObjectsFactory creditCardWithInvalidNumber) shouldRaiseErrorWithDescription: (Cashier creditCardNumberMustHaveAtLeastTwelveDigitsErrorMessage).! !

!CashierTest methodsFor: 'tests' stamp: 'JD 11/3/2021 21:18:52'!
test05CannotCreateACashierWithACardWithAnInvalidOwnerName
	
	| aCartWithAnItem |

	aCartWithAnItem := self createACartWithDefaultCatalogAndAnItemSoldByTheStore.
	
	self assertThatCreatACashierFor: aCartWithAnItem payingWith: (tusLibrosTestObjectsFactory creditCardWithAnInvalidOwnerName) shouldRaiseErrorWithDescription: (Cashier creditCardOwnerNameMustHaveAtMostThirtyDigitsErrorMessage).! !

!CashierTest methodsFor: 'tests' stamp: 'JD 11/3/2021 21:23:47'!
test06CanRegisterASale
	
	| aCartWithAnItem aCashier |

	aCartWithAnItem := self createACartWithDefaultCatalogAndAnItemSoldByTheStore.
	aCashier := self createACashierOnTodayFor: aCartWithAnItem payingWith: tusLibrosTestObjectsFactory validCreditCard using: tusLibrosTestObjectsFactory posnet.
	
	aCashier checkout.
	
	self assert: (OrderedCollection with: aCartWithAnItem total) equals: salesRecord! !

!CashierTest methodsFor: 'tests' stamp: 'JD 11/3/2021 21:43:09'!
test07CannotCheckoutWithACreditCardWithoutFunds

	| aPosnet |

	aPosnet := tusLibrosTestObjectsFactory posnetPreparedForNoFundsFailure.
	
	self assertThatCheckoutACashierWith: tusLibrosTestObjectsFactory creditCardWithoutFunds using: aPosnet raiseErrorWithDescription: Cashier cannotCheckoutWithACreditCardWithoutFundsErrorMessage! !

!CashierTest methodsFor: 'tests' stamp: 'JD 11/3/2021 21:43:34'!
test08CannotCheckoutWithAStolenCreditCard
	
	| aPosnet |

	aPosnet := tusLibrosTestObjectsFactory posnetPreparedForStolenCreditCardFailure.
	
	self assertThatCheckoutACashierWith: tusLibrosTestObjectsFactory stolenCreditCard using: aPosnet raiseErrorWithDescription: Cashier cannotCheckoutWithAStolenCreditCard! !

!CashierTest methodsFor: 'tests' stamp: 'JD 11/3/2021 21:44:00'!
test09CannotCheckoutWithAnInvalidTransactionAmountFormat

	| aPosnet |

	aPosnet := tusLibrosTestObjectsFactory posnetPreparedForInvalidTransactionAmountFormatFailure.
	
	self assertThatCheckoutACashierWith: tusLibrosTestObjectsFactory validCreditCard using: aPosnet raiseErrorWithDescription: Cashier invalidTransactionAmountFormatErrorMessage! !


!CashierTest methodsFor: 'creation' stamp: 'JD 11/3/2021 21:11:29'!
createACartWithDefaultCatalogAndAnItemSoldByTheStore

	^ tusLibrosTestObjectsFactory createCartWithDefaultCatalog add: tusLibrosTestObjectsFactory itemSoldByTheStore! !

!CashierTest methodsFor: 'creation' stamp: 'JD 11/3/2021 21:22:29'!
createACashierOnTodayFor: aCart payingWith: aCreditCard using: aPosnet

	^ Cashier 
		for: aCart
		payingWith: aCreditCard
		on: tusLibrosTestObjectsFactory today
		recordingOn: salesRecord using: aPosnet
! !


!CashierTest methodsFor: 'assertions' stamp: 'JD 11/3/2021 21:32:40'!
assertThatCheckout: aCashierToCheckout raiseErrorWithDescription: anErrorDescription

	self
		should: [aCashierToCheckout checkout]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText = anErrorDescription.
			self assert: salesRecord isEmpty]! !

!CashierTest methodsFor: 'assertions' stamp: 'JD 11/3/2021 21:37:15'!
assertThatCheckoutACashierWith: aCreditCard using: aPosnet raiseErrorWithDescription: anErrorDescription
	
	| aCartWithAnItem aCashier |

	aCartWithAnItem := self createACartWithDefaultCatalogAndAnItemSoldByTheStore.
	aCashier := self createACashierOnTodayFor: aCartWithAnItem payingWith: aCreditCard using: aPosnet.

	self assertThatCheckout: aCashier raiseErrorWithDescription: anErrorDescription! !

!CashierTest methodsFor: 'assertions' stamp: 'JD 11/3/2021 21:15:58'!
assertThatCreatACashierFor: aCatalog payingWith: aCreditCard shouldRaiseErrorWithDescription: anErrorDescription

	self
		should: [Cashier 
			for: aCatalog
			payingWith: aCreditCard
			on: tusLibrosTestObjectsFactory today
			recordingOn: salesRecord using: tusLibrosTestObjectsFactory posnet]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText = anErrorDescription.
			self assert: salesRecord isEmpty]! !


!CashierTest methodsFor: 'set up' stamp: 'JD 11/3/2021 21:06:45'!
setUp
	
	tusLibrosTestObjectsFactory := TusLibrosTestObjectsFactory new.
	salesRecord := OrderedCollection new.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'JD 11/2/2021 20:22:29'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'JD 11/2/2021 20:28:08'!
total
	
	^ items sum: [:anItem | catalog at: anItem]! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cartToCheckout creditCardToPayWith cashierCreationDate salesRecord cart creditCard creationDate posnet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'JD 11/3/2021 18:15:45'!
initializeFor: aCartToCheckout payingWith: aCreditCardToPayWith on: aCashierCreationDate recordingOn: aSalesRecord using: aPosnet

	cart := aCartToCheckout.
	creditCard := aCreditCardToPayWith.
	creationDate := aCashierCreationDate.
	salesRecord := aSalesRecord.
	posnet := aPosnet! !


!Cashier methodsFor: 'checkout' stamp: 'JD 11/3/2021 20:45:50'!
checkout
	
	| total aDebitStatusResponse |
	
	total := cart total.
	aDebitStatusResponse := posnet debit: total with: creditCard.
	self assertThatThePaymentWasSuccessful: aDebitStatusResponse.
	salesRecord add: total.
	
	^ total! !


!Cashier methodsFor: 'assertions' stamp: 'JD 11/3/2021 21:52:16'!
assertThatCreditCardHasFunds: aDebitStatusResponse

	^ self assert: aDebitStatusResponse ~= posnet descriptionForCreditCardWithoutFunds description: [
		self error:	 Cashier cannotCheckoutWithACreditCardWithoutFundsErrorMessage
	]! !

!Cashier methodsFor: 'assertions' stamp: 'JD 11/3/2021 21:52:29'!
assertThatIsNotAStolenCreditCard: aDebitStatusResponse

	^ self assert: aDebitStatusResponse ~= posnet descriptionForStolenCreditCard description: [
		self error:	 Cashier cannotCheckoutWithAStolenCreditCard
	]! !

!Cashier methodsFor: 'assertions' stamp: 'JD 11/3/2021 20:45:50'!
assertThatThePaymentWasSuccessful: aDebitStatusResponse

	self assertThatCreditCardHasFunds: aDebitStatusResponse.
	self assertThatIsNotAStolenCreditCard: aDebitStatusResponse.
	self assertThatTransactionAmountFormatIsValid: aDebitStatusResponse! !

!Cashier methodsFor: 'assertions' stamp: 'JD 11/3/2021 21:52:23'!
assertThatTransactionAmountFormatIsValid: aDebitStatusResponse

	^ self assert: aDebitStatusResponse ~= posnet descriptionForInvalidTransactionAmountFormat description: [
		self error:	 Cashier invalidTransactionAmountFormatErrorMessage
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'JD 11/3/2021 19:57:14'!
for: aCartToCheckout payingWith: aCreditCardToPayWith on: aCashierCreationDate recordingOn: aSalesRecord using: aPosnet  
	
	self assertThatIsNotEmpty: aCartToCheckout.
	self assertThatIsNotExpired: aCreditCardToPayWith on: aCashierCreationDate.
	self assertThatCreditCardNumberHasAtLeastTwelveDigits: aCreditCardToPayWith.
	self assertThatOwnerNameHasAtMostThirtyDigits: aCreditCardToPayWith.

	^ self new initializeFor: aCartToCheckout payingWith: aCreditCardToPayWith on: aCashierCreationDate recordingOn: aSalesRecord using: aPosnet! !


!Cashier class methodsFor: 'error messages' stamp: 'JD 11/3/2021 19:29:01'!
cannotCheckoutWithACreditCardWithoutFundsErrorMessage

	^ 'Cannot checkout with a credit card without funds'! !

!Cashier class methodsFor: 'error messages' stamp: 'JD 11/3/2021 19:24:57'!
cannotCheckoutWithAStolenCreditCard

	^ 'Cannot checkout with a stolen credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'JD 11/2/2021 19:21:31'!
cartCannotBeEmptyErrorMessage
	
	^ 'Cart cannot be empty'! !

!Cashier class methodsFor: 'error messages' stamp: 'JD 11/2/2021 20:54:06'!
creditCardIsExpiredErrorMessage

	^ 'Credit card is expired'! !

!Cashier class methodsFor: 'error messages' stamp: 'JD 11/3/2021 17:33:36'!
creditCardNumberMustHaveAtLeastTwelveDigitsErrorMessage
	
	^ 'Credit card number must have at least twelve digits'! !

!Cashier class methodsFor: 'error messages' stamp: 'JD 11/3/2021 19:52:15'!
creditCardOwnerNameMustHaveAtMostThirtyDigitsErrorMessage
	
	^ 'Credit card owner name must have at most thirty digits'! !

!Cashier class methodsFor: 'error messages' stamp: 'JD 11/3/2021 20:35:00'!
invalidTransactionAmountFormatErrorMessage
	
	^ 'Transaction amount format is not valid'! !


!Cashier class methodsFor: 'assertions' stamp: 'JD 11/3/2021 19:57:14'!
assertThatCreditCardNumberHasAtLeastTwelveDigits: aCreditCardToPayWith

	^ self assert: (aCreditCardToPayWith number size >= 12) description: [self error: Cashier creditCardNumberMustHaveAtLeastTwelveDigitsErrorMessage]! !

!Cashier class methodsFor: 'assertions' stamp: 'JD 11/2/2021 21:01:29'!
assertThatIsNotEmpty: aCartToCheckout

	^ self assert: aCartToCheckout isEmpty not description: [self error: Cashier cartCannotBeEmptyErrorMessage]! !

!Cashier class methodsFor: 'assertions' stamp: 'JD 11/2/2021 21:00:37'!
assertThatIsNotExpired: aCreditCardToPayWith on: aCashierCreationDate
	
	| expireOnNextMonths expireOnNextYears |

	expireOnNextMonths := (aCreditCardToPayWith expiration year = aCashierCreationDate year) and: [(aCreditCardToPayWith expiration month > aCashierCreationDate month)].
	expireOnNextYears := aCreditCardToPayWith expiration year > aCashierCreationDate year.
	
	self assert: (expireOnNextMonths or: [expireOnNextYears]) description: [self error: Cashier creditCardIsExpiredErrorMessage].! !

!Cashier class methodsFor: 'assertions' stamp: 'JD 11/3/2021 19:57:02'!
assertThatOwnerNameHasAtMostThirtyDigits: aCreditCardToPayWith

	^ self assert: (aCreditCardToPayWith ownerName size <= 30) description: [self error: Cashier creditCardOwnerNameMustHaveAtMostThirtyDigitsErrorMessage]! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration ownerName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'JD 11/3/2021 20:54:21'!
initializeWithOwner: aCreditCardOwner withNumber: aCreditCardNumber expiringOn: anExpirationMonthOfYear

	number := aCreditCardNumber.
	expiration := anExpirationMonthOfYear.
	ownerName := aCreditCardOwner ! !


!CreditCard methodsFor: 'information' stamp: 'JD 11/3/2021 20:54:21'!
expiration
	
	^ expiration! !

!CreditCard methodsFor: 'information' stamp: 'JD 11/3/2021 17:34:51'!
number
	
	^ number! !

!CreditCard methodsFor: 'information' stamp: 'JD 11/3/2021 19:54:01'!
ownerName
	
	^ ownerName! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JD 11/3/2021 19:54:37'!
withOwner: aCreditCardOwner withNumber: aCreditCardNumber expiringOn: anExpirationMonthOfYear 

	^self new initializeWithOwner: aCreditCardOwner withNumber: aCreditCardNumber expiringOn: anExpirationMonthOfYear ! !


!classDefinition: #PosnetSimulator category: 'TusLibros'!
Object subclass: #PosnetSimulator
	instanceVariableNames: 'description'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PosnetSimulator methodsFor: 'initialization' stamp: 'JD 11/3/2021 18:30:25'!
initialize
	
	description := 'Ok'! !


!PosnetSimulator methodsFor: 'debit' stamp: 'JD 11/3/2021 18:26:29'!
debit: aTotalSaleAmount with: aCreditCard
	
	^ description
	! !


!PosnetSimulator methodsFor: 'context configuration' stamp: 'JD 11/3/2021 21:52:23'!
prepareForInvalidTransactionAmountFormatFailure
	
	description := self descriptionForInvalidTransactionAmountFormat! !

!PosnetSimulator methodsFor: 'context configuration' stamp: 'JD 11/3/2021 21:52:16'!
prepareForNoFundsFailure
	
	description := self descriptionForCreditCardWithoutFunds! !

!PosnetSimulator methodsFor: 'context configuration' stamp: 'JD 11/3/2021 21:52:29'!
prepareForStolenCreditCardFailure
	
	description := self descriptionForStolenCreditCard! !


!PosnetSimulator methodsFor: 'descriptions' stamp: 'JD 11/3/2021 21:52:16'!
descriptionForCreditCardWithoutFunds

	^ 'Credit card without funds'! !

!PosnetSimulator methodsFor: 'descriptions' stamp: 'JD 11/3/2021 21:52:23'!
descriptionForInvalidTransactionAmountFormat

	^ 'Invalid transaction amount format'! !

!PosnetSimulator methodsFor: 'descriptions' stamp: 'JD 11/3/2021 21:52:29'!
descriptionForStolenCreditCard

	^ 'Stolen credit card'! !


!classDefinition: #TusLibrosTestObjectsFactory category: 'TusLibros'!
Object subclass: #TusLibrosTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTestObjectsFactory methodsFor: 'credit cards' stamp: 'JD 11/3/2021 21:02:07'!
creditCardWithAnInvalidOwnerName

	^ CreditCard withOwner: 'An invalid credit card owner name' withNumber: self validCreditCardNumber expiringOn: (self futureMonthOfYear)! !

!TusLibrosTestObjectsFactory methodsFor: 'credit cards' stamp: 'JD 11/3/2021 21:02:07'!
creditCardWithInvalidNumber

	^ CreditCard withOwner: self validCreditCardOwnerName withNumber: '0' expiringOn: (self futureMonthOfYear)! !

!TusLibrosTestObjectsFactory methodsFor: 'credit cards' stamp: 'JD 11/3/2021 18:14:21'!
creditCardWithoutFunds
	
	^ self validCreditCard! !

!TusLibrosTestObjectsFactory methodsFor: 'credit cards' stamp: 'JD 11/3/2021 20:59:04'!
expiredCreditCard
	
	^ CreditCard withOwner: self validCreditCardOwnerName withNumber: self validCreditCardNumber expiringOn: (GregorianMonthOfYear year: (self today year previous) month: (self today month))! !

!TusLibrosTestObjectsFactory methodsFor: 'credit cards' stamp: 'JD 11/3/2021 19:26:58'!
stolenCreditCard
	
	^ self validCreditCard! !

!TusLibrosTestObjectsFactory methodsFor: 'credit cards' stamp: 'JD 11/3/2021 21:02:07'!
validCreditCard
	
	^ CreditCard withOwner: self validCreditCardOwnerName withNumber: self validCreditCardNumber expiringOn: (self futureMonthOfYear)! !

!TusLibrosTestObjectsFactory methodsFor: 'credit cards' stamp: 'JD 11/3/2021 20:59:04'!
validCreditCardNumber

	^ 'aValidCCNumber'! !

!TusLibrosTestObjectsFactory methodsFor: 'credit cards' stamp: 'JD 11/3/2021 19:55:42'!
validCreditCardOwnerName
	
	^ 'A Valid CC Name'! !


!TusLibrosTestObjectsFactory methodsFor: 'dates' stamp: 'JD 11/3/2021 21:02:07'!
futureMonthOfYear

	^ GregorianMonthOfYear year: (self today year next) month: (self today month)! !

!TusLibrosTestObjectsFactory methodsFor: 'dates' stamp: 'JD 11/2/2021 19:12:39'!
today

	^ FixedGregorianDate today! !


!TusLibrosTestObjectsFactory methodsFor: 'items' stamp: 'JD 11/2/2021 19:51:25'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!TusLibrosTestObjectsFactory methodsFor: 'items' stamp: 'JD 11/2/2021 19:51:13'!
itemSoldByTheStore
	
	^ 'validBook'! !


!TusLibrosTestObjectsFactory methodsFor: 'carts' stamp: 'JD 11/3/2021 20:12:07'!
createCartWithAnInvalidCatalog
	
	^Cart acceptingItemsOf: self catalogWithInvalidItemsPriceFormat! !

!TusLibrosTestObjectsFactory methodsFor: 'carts' stamp: 'JD 11/3/2021 20:12:40'!
createCartWithDefaultCatalog
	
	^Cart acceptingItemsOf: self defaultCatalog! !


!TusLibrosTestObjectsFactory methodsFor: 'catalogs' stamp: 'JD 11/3/2021 21:03:59'!
catalogWithAnItemSoldByTheStoreWithValue: anItemValue
	 
	| aCatalog |
	
	aCatalog := Dictionary new.
	aCatalog at: self itemSoldByTheStore put: anItemValue.
	
	^ aCatalog! !

!TusLibrosTestObjectsFactory methodsFor: 'catalogs' stamp: 'JD 11/3/2021 21:04:40'!
catalogWithInvalidItemsPriceFormat
	
	^ self catalogWithAnItemSoldByTheStoreWithValue: 20.001*dollar! !

!TusLibrosTestObjectsFactory methodsFor: 'catalogs' stamp: 'JD 11/3/2021 21:04:24'!
defaultCatalog

	^ self catalogWithAnItemSoldByTheStoreWithValue: 20.00*dollar
! !


!TusLibrosTestObjectsFactory methodsFor: 'posnets' stamp: 'JD 11/3/2021 18:13:19'!
posnet
	
	^ PosnetSimulator new! !

!TusLibrosTestObjectsFactory methodsFor: 'posnets' stamp: 'JD 11/3/2021 21:43:56'!
posnetPreparedForInvalidTransactionAmountFormatFailure
	
	| aPosnet |

	aPosnet := self posnet.
	aPosnet prepareForInvalidTransactionAmountFormatFailure.
	
	^ aPosnet! !

!TusLibrosTestObjectsFactory methodsFor: 'posnets' stamp: 'JD 11/3/2021 21:43:01'!
posnetPreparedForNoFundsFailure
	
	| aPosnet |

	aPosnet := self posnet.
	aPosnet prepareForNoFundsFailure.
	
	^ aPosnet! !

!TusLibrosTestObjectsFactory methodsFor: 'posnets' stamp: 'JD 11/3/2021 21:43:29'!
posnetPreparedForStolenCreditCardFailure
	
	| aPosnet |

	aPosnet := self posnet.
	aPosnet prepareForStolenCreditCardFailure.
	
	^ aPosnet! !
