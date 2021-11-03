!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'aTusLibrosTestObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'JD 11/2/2021 18:29:02'!
setUp
	
	aTusLibrosTestObjectsFactory := TusLibrosTestObjectsFactory new! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/2/2021 18:24:49'!
test01NewCartsAreCreatedEmpty

	self assert: aTusLibrosTestObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/2/2021 19:51:25'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCart.
	
	self 
		should: [ cart add: aTusLibrosTestObjectsFactory itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/2/2021 19:51:13'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCart.
	
	cart add: aTusLibrosTestObjectsFactory itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/2/2021 19:51:13'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: aTusLibrosTestObjectsFactory itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/2/2021 19:51:25'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: aTusLibrosTestObjectsFactory itemNotSoldByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/2/2021 19:51:13'!
test06CartRemembersAddedItems

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCart.
	
	cart add: aTusLibrosTestObjectsFactory itemSoldByTheStore.
	self assert: (cart includes: aTusLibrosTestObjectsFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/2/2021 19:51:13'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCart.
	
	self deny: (cart includes: aTusLibrosTestObjectsFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'JD 11/2/2021 19:51:13'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := aTusLibrosTestObjectsFactory createCart.
	
	cart add: 2 of: aTusLibrosTestObjectsFactory itemSoldByTheStore.
	self assert: (cart occurrencesOf: aTusLibrosTestObjectsFactory itemSoldByTheStore) = 2! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'tusLibrosTestObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 18:46:21'!
setUp
	
	tusLibrosTestObjectsFactory := TusLibrosTestObjectsFactory new! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 19:15:56'!
test01CannotCreateACashierForAnEmptyCart
	
	| aSalesRecord |
	aSalesRecord := OrderedCollection new.
	
	self
		should: [Cashier 
			for: tusLibrosTestObjectsFactory createCart
			payingWith: tusLibrosTestObjectsFactory validCreditCard
			on: tusLibrosTestObjectsFactory today
			recordingOn: aSalesRecord]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText = Cashier cartCannotBeEmptyErrorMessage.
			self assert: aSalesRecord isEmpty] ! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 20:29:16'!
test02CanCheckoutACartWithManyItems
	
	| aSalesRecord aCashier totalCheckout aCartWithAnItem |
	
	aSalesRecord := OrderedCollection new.
	aCartWithAnItem := tusLibrosTestObjectsFactory createCart add: 2 of: tusLibrosTestObjectsFactory itemSoldByTheStore.
	aCashier := Cashier 
				for: aCartWithAnItem
				payingWith: tusLibrosTestObjectsFactory validCreditCard
				on: tusLibrosTestObjectsFactory today
				recordingOn: aSalesRecord.
	
	totalCheckout := aCashier checkout.
	
	self assert: 40*dollar equals: totalCheckout! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 21:03:42'!
test03CannotCreateACashierWithAnExpiredCard
	
	| aSalesRecord aCartWithAnItem |
	
	aSalesRecord := OrderedCollection new.
	aCartWithAnItem := tusLibrosTestObjectsFactory createCart add: tusLibrosTestObjectsFactory itemSoldByTheStore.
	self
		should: [Cashier 
			for: aCartWithAnItem
			payingWith: tusLibrosTestObjectsFactory expiredCreditCard
			on: tusLibrosTestObjectsFactory today
			recordingOn: aSalesRecord]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText = Cashier creditCardIsExpiredErrorMessage.
			self assert: aSalesRecord isEmpty]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 21:33:50'!
test04CanRegisterASale
	
	| aSalesRecord aCartWithAnItem aCashier |
	
	aSalesRecord := OrderedCollection new.
	aCartWithAnItem := tusLibrosTestObjectsFactory createCart add: tusLibrosTestObjectsFactory itemSoldByTheStore.
	aCashier := Cashier 
				for: aCartWithAnItem
				payingWith: tusLibrosTestObjectsFactory validCreditCard
				on: tusLibrosTestObjectsFactory today
				recordingOn: aSalesRecord.
	
	aCashier checkout.
	
	self assert: (OrderedCollection with: aCartWithAnItem total) equals: aSalesRecord! !


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


!Cart methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 20:28:08'!
total
	
	^ items sum: [:anItem | catalog at: anItem]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cartToCheckout creditCardToPayWith cashierCreationDate salesRecord cart creditCard creationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'JD 11/2/2021 19:15:18'!
initializeFor: aCartToCheckout payingWith: aCreditCardToPayWith on: aCashierCreationDate recordingOn: aSalesRecord 

	cart := aCartToCheckout.
	creditCard := aCreditCardToPayWith.
	creationDate := aCashierCreationDate.
	salesRecord := aSalesRecord! !


!Cashier methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 21:34:38'!
checkout
	
	| total |

	total := cart total.
	salesRecord add: total.
	
	^ total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'JD 11/2/2021 21:01:29'!
assertThatIsNotEmpty: aCartToCheckout

	^ self assert: aCartToCheckout isEmpty not description: [self error: Cashier cartCannotBeEmptyErrorMessage]! !

!Cashier class methodsFor: 'instance creation' stamp: 'JD 11/2/2021 21:00:37'!
assertThatIsNotExpired: aCreditCardToPayWith on: aCashierCreationDate
	
	| expireOnNextMonths expireOnNextYears |

	expireOnNextMonths := (aCreditCardToPayWith expiration year = aCashierCreationDate year) and: [(aCreditCardToPayWith expiration month > aCashierCreationDate month)].
	expireOnNextYears := aCreditCardToPayWith expiration year > aCashierCreationDate year.
	
	self assert: (expireOnNextMonths or: [expireOnNextYears]) description: [self error: Cashier creditCardIsExpiredErrorMessage].! !

!Cashier class methodsFor: 'instance creation' stamp: 'JD 11/2/2021 20:54:06'!
creditCardIsExpiredErrorMessage

	^ 'Credit card is expired'! !

!Cashier class methodsFor: 'instance creation' stamp: 'JD 11/2/2021 21:01:29'!
for: aCartToCheckout payingWith: aCreditCardToPayWith on: aCashierCreationDate recordingOn: aSalesRecord 
	
	self assertThatIsNotEmpty: aCartToCheckout.
	self assertThatIsNotExpired: aCreditCardToPayWith on: aCashierCreationDate.

	^ self new initializeFor: aCartToCheckout payingWith: aCreditCardToPayWith on: aCashierCreationDate recordingOn: aSalesRecord ! !


!Cashier class methodsFor: 'error messages' stamp: 'JD 11/2/2021 19:21:31'!
cartCannotBeEmptyErrorMessage
	
	^ 'Cart cannot be empty'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber expiringMonthOfYear number expirationMonthOfYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'JD 11/2/2021 20:53:39'!
expiration
	
	^ expirationMonthOfYear! !

!CreditCard methodsFor: 'initialization' stamp: 'JD 11/2/2021 19:10:09'!
initializeWith: aCreditCardNumber expiringOn: anExpirationMonthOfYear 

	number := aCreditCardNumber.
	expirationMonthOfYear := anExpirationMonthOfYear! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JD 11/2/2021 19:22:15'!
with: aCreditCardNumber expiringOn: anExpirationMonthOfYear 

	^self new initializeWith: aCreditCardNumber expiringOn: anExpirationMonthOfYear ! !


!classDefinition: #TusLibrosTestObjectsFactory category: 'TusLibros'!
Object subclass: #TusLibrosTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 18:26:13'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 20:12:30'!
defaultCatalog
	 
	| aCatalog |
	
	aCatalog := Dictionary new.
	aCatalog at: self itemSoldByTheStore put: 20*dollar.
	
	^ aCatalog! !

!TusLibrosTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 20:40:01'!
expiredCreditCard
	
	^ CreditCard with: 'aValidCCNumber' expiringOn: (GregorianMonthOfYear year: (self today year previous) month: (self today month))! !

!TusLibrosTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 19:51:25'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!TusLibrosTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 19:51:13'!
itemSoldByTheStore
	
	^ 'validBook'! !

!TusLibrosTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 19:12:39'!
today

	^ FixedGregorianDate today! !

!TusLibrosTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JD 11/2/2021 20:18:22'!
validCreditCard
	
	^ CreditCard with: 'aValidCCNumber' expiringOn: (GregorianMonthOfYear year: (self today year next) month: (self today month))! !
