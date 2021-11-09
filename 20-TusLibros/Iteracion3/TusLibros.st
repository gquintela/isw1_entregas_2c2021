!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InterfaceTest category: 'TusLibros'!
TestCase subclass: #InterfaceTest
	instanceVariableNames: 'storeTestObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:38:36'!
authenticationSystemPreparedForAuthenticationSuccess
	
	| anAuthenticationStub |

	anAuthenticationStub := AuthenticationStub new.
	anAuthenticationStub prepareForAuthenticationSuccess.
	
	^ anAuthenticationStub! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:22:15'!
authenticationSystemPreparedForInvalidUserOrPasswordFailure
	
	| anAuthenticationStub |

	anAuthenticationStub := AuthenticationStub new.
	anAuthenticationStub prepareForInvalidUserOrPasswordFailure.
	
	^ anAuthenticationStub! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:16:53'!
invalidUser

	^ 'InvalidUser'! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:07:43'!
setUp 

	storeTestObjectsFactory := StoreTestObjectsFactory new! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 21:10:30'!
test01CannotCreateACartWithAnInvalidUser

	| xx |
	xx := XX authenticatingWith: self authenticationSystemPreparedForInvalidUserOrPasswordFailure withCatalog: storeTestObjectsFactory defaultCatalog withClock: storeTestObjectsFactory clock.
	
	self
		should: [xx createCartFor: self invalidUser with: self validPassword]
		raise: AssertionFailure - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = XX invalidUserOrPasswordErrorMessage]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 21:10:30'!
test02CanCreateACart

	| xx aCartId cartContents |
	
	xx := XX authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: storeTestObjectsFactory clock.
	aCartId := 	xx createCartFor: self validUser with: self validPassword.
	
	cartContents := xx listCart: aCartId.
	self assert: (OrderedCollection new) equals: cartContents! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 21:10:30'!
test03CanAddAnItemToCart

	| xx aCartId cartContents |
	
	xx := XX authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: storeTestObjectsFactory clock.
	aCartId := 	xx createCartFor: self validUser with: self validPassword.
	xx addToCart: aCartId quantity: 1 of: storeTestObjectsFactory itemSellByTheStore.

	cartContents := xx listCart: aCartId.
	self assert: (OrderedCollection with: storeTestObjectsFactory itemSellByTheStore with: 1) equals: cartContents! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 21:10:30'!
test04CanCreateManyCarts

	| xx aCartId cartContents anotherCartContents anotherCartId |
	
	xx := XX authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: storeTestObjectsFactory clock.
	aCartId := 	xx createCartFor: self validUser with: self validPassword.
	xx addToCart: aCartId quantity: 1 of: storeTestObjectsFactory itemSellByTheStore.
	anotherCartId := 	xx createCartFor: self validUser with: self validPassword.

	cartContents := xx listCart: aCartId.
	anotherCartContents := xx listCart: anotherCartId.
	self assert: (OrderedCollection with: storeTestObjectsFactory itemSellByTheStore with: 1) equals: cartContents.
	self assert: (OrderedCollection new) equals: anotherCartContents! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 21:10:30'!
test05CannotAddAnItemWithAnInvalidCartId

	| xx anInvalidCartId |
	
	xx := XX authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: storeTestObjectsFactory clock.
	
	anInvalidCartId := 0.
	self
		should: [xx addToCart: anInvalidCartId quantity: 1 of: storeTestObjectsFactory itemSellByTheStore.]
		raise: AssertionFailure - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = XX invalidCartIdErrorMessage]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 21:10:30'!
test06CannotListAnItemWithAnInvalidCartId

	| xx anInvalidCartId |
	
	xx := XX authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: storeTestObjectsFactory clock.
	
	anInvalidCartId := 0.
	self
		should: [xx listCart: anInvalidCartId]
		raise: AssertionFailure - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = XX invalidCartIdErrorMessage]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 22:09:31'!
test07CannotListAnExpiredCart

	| xx aCartId aClock |
	
	aClock := storeTestObjectsFactory clock.
	xx := XX authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: aClock.
	aCartId := 	xx createCartFor: self validUser with: self validPassword.
	
	aClock now: (storeTestObjectsFactory today + (Duration minutes: 31)).
	self
		should: [xx listCart: aCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = XX expiredCartErrorMessage]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 22:15:44'!
test08AnExpiredCartIsErasedWhenUsed

	| xx aCartId aClock |
	
	aClock := storeTestObjectsFactory clock.
	xx := XX authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: aClock.
	aCartId := 	xx createCartFor: self validUser with: self validPassword.
	
	aClock now: (storeTestObjectsFactory today + (Duration minutes: 31)).
	self
		should: [xx listCart: aCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText = XX expiredCartErrorMessage].

	self
		should: [xx listCart: aCartId]
		raise: AssertionFailure - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText = XX invalidCartIdErrorMessage]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:17:54'!
validPassword
	
	^ 'ValidPassword'! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:25:15'!
validUser
	
	^ 'ValidUser'! !


!classDefinition: #AuthenticationStub category: 'TusLibros'!
Object subclass: #AuthenticationStub
	instanceVariableNames: 'authenticationResult'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticationStub methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:34:30'!
authenticate: aUser with: aUserPassword 
	
	^ authenticationResult ! !

!AuthenticationStub methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:37:32'!
prepareForAuthenticationSuccess
	
	authenticationResult := true! !

!AuthenticationStub methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:35:44'!
prepareForInvalidUserOrPasswordFailure
	
	authenticationResult := false! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'JD 11/7/2021 15:18:55'!
items
	
	^ items copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #SimulatedClock category: 'TusLibros'!
Object subclass: #SimulatedClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SimulatedClock methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 21:19:00'!
initializeFor: aTodayDate
	
	now := aTodayDate! !

!SimulatedClock methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 21:33:28'!
now
	
	^ now! !

!SimulatedClock methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 21:26:27'!
now: aTodayDate
	
	now := aTodayDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimulatedClock class' category: 'TusLibros'!
SimulatedClock class
	instanceVariableNames: ''!

!SimulatedClock class methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 21:19:35'!
for: aTodayDate
	
	^ self new initializeFor: aTodayDate! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'JD 11/8/2021 21:23:48'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'JD 11/8/2021 21:39:14'!
clock
	
	^ SimulatedClock for: self today! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #XX category: 'TusLibros'!
Object subclass: #XX
	instanceVariableNames: 'authenticationSystem carts catalog clock cartsLastUsage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!XX methodsFor: 'initialization' stamp: 'JD 11/8/2021 21:34:03'!
initializeAuthenticatingWith: anAuthenticationSystem withCatalog: aCatalog withClock: aClock   

	authenticationSystem := anAuthenticationSystem.
	catalog := aCatalog.
	carts := OrderedCollection new.
	clock := aClock.
	cartsLastUsage := Dictionary new! !


!XX methodsFor: 'as yet unclassified' stamp: 'JD 11/7/2021 16:01:44'!
addToCart: aCartId quantity: aBookQuantity of: aBookISBN 
	
	self assertThatCartIdIsValid: aCartId.
	(carts at: aCartId) add: aBookQuantity of: aBookISBN! !

!XX methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 20:11:53'!
assertThatCartIdIsValid: aCartId

	^ self assert: (self isCartIdValid: aCartId) description: [XX invalidCartIdErrorMessage]! !

!XX methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 21:32:46'!
createCartFor: aUser with: aUserPassword 
	
	| aNewCart newCartId |
	self assert: (authenticationSystem authenticate: aUser with: aUserPassword) description: [XX invalidUserOrPasswordErrorMessage].
	
	aNewCart := Cart acceptingItemsOf: catalog.
	carts add: aNewCart.
	
	newCartId := self idFor: aNewCart.
	cartsLastUsage at: newCartId put: clock now.

	^ newCartId! !

!XX methodsFor: 'as yet unclassified' stamp: 'JD 11/7/2021 16:15:16'!
idFor: aNewCart

	^ carts indexOf: aNewCart! !

!XX methodsFor: 'as yet unclassified' stamp: 'JD 11/7/2021 16:01:27'!
isCartIdValid: aCartId

	^ carts isInBounds: aCartId! !

!XX methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 22:09:28'!
listCart: aCartId
	
	| cartForId |
	
	self assertThatCartIdIsValid: aCartId.
	cartForId := carts at: aCartId.
	(clock now - (cartsLastUsage at: aCartId)) minutes <= 30 ifFalse: [
		cartsLastUsage removeKey: aCartId.
		carts remove: cartForId.
		self error: XX expiredCartErrorMessage
	].
	
	^ self listItemsWithOccurrencesOf: cartForId 
! !

!XX methodsFor: 'as yet unclassified' stamp: 'JD 11/7/2021 16:20:11'!
listItemsWithOccurrencesOf: aCartToList

	| aCartList |

	aCartList := OrderedCollection new.
	aCartToList items do: [:anItem | 
		aCartList add: anItem.
		aCartList add: (aCartList occurrencesOf: anItem)
	].
	
	^ aCartList! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XX class' category: 'TusLibros'!
XX class
	instanceVariableNames: ''!

!XX class methodsFor: 'instance creation' stamp: 'JD 11/8/2021 21:11:27'!
authenticatingWith: anAuthenticationSystem withCatalog: aCatalog withClock: aClock  

	^ self new initializeAuthenticatingWith: anAuthenticationSystem withCatalog: aCatalog withClock: aClock! !


!XX class methodsFor: 'as yet unclassified' stamp: 'JD 11/8/2021 20:03:04'!
expiredCartErrorMessage
	
	^ 'Cart has reached the expiration time'! !

!XX class methodsFor: 'as yet unclassified' stamp: 'JD 11/7/2021 15:40:07'!
invalidCartIdErrorMessage
	
	^ 'Invalid cart ID'! !

!XX class methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:19:49'!
invalidUserOrPasswordErrorMessage
	
	^ 'Invalid User or Password'! !
