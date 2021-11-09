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


!classDefinition: #RestInterfaceTest category: 'TusLibros'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'storeTestObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:38:36'!
authenticationSystemPreparedForAuthenticationSuccess
	
	| anAuthenticationStub |

	anAuthenticationStub := AuthenticationStub new.
	anAuthenticationStub prepareForAuthenticationSuccess.
	
	^ anAuthenticationStub! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:22:15'!
authenticationSystemPreparedForInvalidUserOrPasswordFailure
	
	| anAuthenticationStub |

	anAuthenticationStub := AuthenticationStub new.
	anAuthenticationStub prepareForInvalidUserOrPasswordFailure.
	
	^ anAuthenticationStub! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:16:53'!
invalidUser

	^ 'InvalidUser'! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:07:43'!
setUp 

	storeTestObjectsFactory := StoreTestObjectsFactory new! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gq 11/9/2021 19:30:06'!
test01CannotCreateACartWithAnInvalidUser

	| aRestInterface |
	aRestInterface := RestInterface authenticatingWith: self authenticationSystemPreparedForInvalidUserOrPasswordFailure withCatalog: storeTestObjectsFactory defaultCatalog withClock: storeTestObjectsFactory clock debitingBy: self registeringSalesOn: OrderedCollection new.
	
	self
		should: [aRestInterface createCartFor: self invalidUser with: self validPassword]
		raise: AssertionFailure - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = RestInterface invalidUserOrPasswordErrorMessage]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gq 11/9/2021 19:30:06'!
test02CanCreateACart

	| aRestInterface aCartId cartContents |
	
	aRestInterface := RestInterface authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: storeTestObjectsFactory clock debitingBy: self registeringSalesOn: OrderedCollection new.
	aCartId := 	aRestInterface createCartFor: self validUser with: self validPassword.
	
	cartContents := aRestInterface listCart: aCartId.
	self assert: cartContents isEmpty ! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gq 11/9/2021 19:30:06'!
test03CanAddAnItemToCart

	| aRestInterface aCartId cartContents anExpectedCartList |
	
	aRestInterface := RestInterface authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: storeTestObjectsFactory clock debitingBy: self registeringSalesOn: OrderedCollection new.
	aCartId := 	aRestInterface createCartFor: self validUser with: self validPassword.
	aRestInterface addToCart: aCartId quantity: 1 of: storeTestObjectsFactory itemSellByTheStore.

	cartContents := aRestInterface listCart: aCartId.
	anExpectedCartList := Dictionary new.
	anExpectedCartList at: storeTestObjectsFactory itemSellByTheStore put: 1.
	self assert: anExpectedCartList equals: cartContents! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gq 11/9/2021 19:30:06'!
test04CanCreateManyCarts

	| aRestInterface aCartId cartContents anotherCartContents anotherCartId anExpectedCartList |
	
	aRestInterface := RestInterface authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: storeTestObjectsFactory clock debitingBy: self registeringSalesOn: OrderedCollection new.
	aCartId := 	aRestInterface createCartFor: self validUser with: self validPassword.
	aRestInterface addToCart: aCartId quantity: 1 of: storeTestObjectsFactory itemSellByTheStore.
	anotherCartId := 	aRestInterface createCartFor: self validUser with: self validPassword.

	cartContents := aRestInterface listCart: aCartId.
	anotherCartContents := aRestInterface listCart: anotherCartId.
	anExpectedCartList := Dictionary new.
	anExpectedCartList at: storeTestObjectsFactory itemSellByTheStore put: 1.
	self assert: anExpectedCartList equals: cartContents.
	self assert: anotherCartContents isEmpty! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gq 11/9/2021 19:30:06'!
test05CannotAddAnItemWithAnInvalidCartId

	| aRestInterface anInvalidCartId |
	
	aRestInterface := RestInterface authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: storeTestObjectsFactory clock debitingBy: self registeringSalesOn: OrderedCollection new.
	
	anInvalidCartId := 0.
	self
		should: [aRestInterface addToCart: anInvalidCartId quantity: 1 of: storeTestObjectsFactory itemSellByTheStore.]
		raise: AssertionFailure - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = RestInterface invalidCartIdErrorMessage]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gq 11/9/2021 19:30:06'!
test06CannotListAnItemWithAnInvalidCartId

	| aRestInterface anInvalidCartId |
	
	aRestInterface := RestInterface authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: storeTestObjectsFactory clock debitingBy: self registeringSalesOn: OrderedCollection new.
	
	anInvalidCartId := 0.
	self
		should: [aRestInterface listCart: anInvalidCartId]
		raise: AssertionFailure - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = RestInterface invalidCartIdErrorMessage]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gq 11/9/2021 19:30:06'!
test07CannotListAnExpiredCart

	| aRestInterface aCartId aClock |
	
	aClock := storeTestObjectsFactory clock.
	aRestInterface := RestInterface authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: aClock debitingBy: self registeringSalesOn: OrderedCollection new.
	aCartId := 	aRestInterface createCartFor: self validUser with: self validPassword.
	
	aClock now: (storeTestObjectsFactory today + (Duration minutes: 31)).
	self
		should: [aRestInterface listCart: aCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = RestInterface expiredCartErrorMessage].
		
	self
		should: [aRestInterface listCart: aCartId]
		raise: AssertionFailure - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText = RestInterface invalidCartIdErrorMessage]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gq 11/9/2021 19:30:06'!
test08CannotAddAnItemToAnExpiredCart

	| aRestInterface aCartId aClock |
	
	aClock := storeTestObjectsFactory clock.
	aRestInterface := RestInterface authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: aClock debitingBy: self registeringSalesOn: OrderedCollection new.
	aCartId := 	aRestInterface createCartFor: self validUser with: self validPassword.
	
	aClock now: (storeTestObjectsFactory today + (Duration minutes: 31)).
	self
		should: [aRestInterface addToCart: aCartId quantity: 1 of: storeTestObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = RestInterface expiredCartErrorMessage].
		
	self
		should: [aRestInterface addToCart: aCartId quantity: 1 of: storeTestObjectsFactory itemSellByTheStore ]
		raise: AssertionFailure - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText = RestInterface invalidCartIdErrorMessage]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gq 11/9/2021 19:30:06'!
test09CannotCheckoutACartWithAnInvalidId

	| aRestInterface anInvalidCartId aClock |
	
	aClock := storeTestObjectsFactory clock.
	aRestInterface := RestInterface authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: aClock debitingBy: self registeringSalesOn: OrderedCollection new.
	anInvalidCartId := 	0.
	
	self
		should: [aRestInterface checkoutCart: anInvalidCartId withCreditCardNumber: '1234567890123456' expiringOn: storeTestObjectsFactory currentMonthOfYear ownedBy: 'Alan Kay']
		raise: AssertionFailure - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = RestInterface invalidCartIdErrorMessage ].
! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gq 11/9/2021 19:30:06'!
test10CannotCheckoutAnExpiredCart

	| aRestInterface aCartId aClock |
	
	aClock := storeTestObjectsFactory clock.
	aRestInterface := RestInterface authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: aClock debitingBy: self registeringSalesOn: OrderedCollection new.
	aCartId := 	aRestInterface createCartFor: self validUser with: self validPassword.
	
	aClock now: (storeTestObjectsFactory today + (Duration minutes: 31)).
	
	self
		should: [aRestInterface checkoutCart: aCartId withCreditCardNumber: '1234567890123456' expiringOn: storeTestObjectsFactory currentMonthOfYear ownedBy: 'Alan Kay']
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = RestInterface expiredCartErrorMessage ].
! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gq 11/9/2021 19:30:06'!
test11CannotCheckoutAnEmptyCart

	| aRestInterface anEmptyCartId aClock |
	
	aClock := storeTestObjectsFactory clock.
	aRestInterface := RestInterface authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: aClock debitingBy: self registeringSalesOn: OrderedCollection new.
	anEmptyCartId := 	aRestInterface createCartFor: self validUser with: self validPassword.
	
	self
		should: [aRestInterface checkoutCart: anEmptyCartId withCreditCardNumber: '1234567890123456' expiringOn: storeTestObjectsFactory currentMonthOfYear ownedBy: 'Alan Kay']
		raise: AssertionFailure - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = RestInterface emptyCartErrorMessage ].
! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gq 11/9/2021 19:30:06'!
test12CanCheckoutACart

	| aRestInterface aCartId aClock |
	
	aClock := storeTestObjectsFactory clock.
	aRestInterface := RestInterface authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: storeTestObjectsFactory defaultCatalog withClock: aClock debitingBy: self registeringSalesOn: OrderedCollection new.
	aCartId := 	aRestInterface createCartFor: self validUser with: self validPassword.
	aRestInterface addToCart: aCartId quantity: 1 of: storeTestObjectsFactory itemSellByTheStore.
	
	aRestInterface checkoutCart: aCartId withCreditCardNumber: '1234567890123456' expiringOn: storeTestObjectsFactory currentMonthOfYear ownedBy: 'Alan Kay'.
	
	self assert: (aRestInterface listCart: aCartId) isEmpty 
	
! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:17:54'!
validPassword
	
	^ 'ValidPassword'! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'JD 11/4/2021 20:25:15'!
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


!classDefinition: #RestInterface category: 'TusLibros'!
Object subclass: #RestInterface
	instanceVariableNames: 'authenticationSystem carts catalog clock cartsLastUsage merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'initialization' stamp: 'gq 11/9/2021 17:42:55'!
initializeAuthenticatingWith: anAuthenticationSystem withCatalog: aCatalog withClock: aClock   

	authenticationSystem := anAuthenticationSystem.
	catalog := aCatalog.
	carts :=  Dictionary new.
	clock := aClock.
	cartsLastUsage := Dictionary new! !


!RestInterface methodsFor: 'assertions' stamp: 'gq 11/9/2021 17:03:37'!
assertThatCartIdIsValid: aCartId

	^ self assert: (self isCartIdValid: aCartId) description: [RestInterface invalidCartIdErrorMessage]! !

!RestInterface methodsFor: 'assertions' stamp: 'gq 11/9/2021 17:56:25'!
validateThatIsNotExpired: aCartId
	
	(clock now - (cartsLastUsage at: aCartId)) minutes <= 30 ifFalse: [
		cartsLastUsage removeKey: aCartId.
		carts removeKey: aCartId.
		self error: RestInterface expiredCartErrorMessage
	].
! !


!RestInterface methodsFor: 'interface operations' stamp: 'gq 11/9/2021 17:13:49'!
addToCart: aCartId quantity: aBookQuantity of: aBookISBN 
	
	self assertThatCartIdIsValid: aCartId.
	self validateThatIsNotExpired: aCartId.
	
	(carts at: aCartId) add: aBookQuantity of: aBookISBN.
	! !

!RestInterface methodsFor: 'interface operations' stamp: 'gq 11/9/2021 19:21:42'!
checkoutCart: aCartIdToCheckout withCreditCardNumber: aCreditCardNumber expiringOn: aCreditCardExpirationDate ownedBy: aCreditCardOwner    
	
	| aCashier aCreditCard |
	
	self assertThatCartIdIsValid: aCartIdToCheckout.
	self validateThatIsNotExpired: aCartIdToCheckout.
	self assert: (carts at: aCartIdToCheckout) isEmpty not description: RestInterface emptyCartErrorMessage.
	
	aCreditCard := CreditCard expiringOn: aCreditCardExpirationDate.
	
	aCashier := Cashier toCheckout: (carts at: aCartIdToCheckout)  charging: aCreditCard throught: merchantProcessor on: clock now registeringOn: salesBook.
	
	aCashier checkOut.
	
	cartsLastUsage removeKey: aCartIdToCheckout.
	carts removeKey: aCartIdToCheckout.! !

!RestInterface methodsFor: 'interface operations' stamp: 'gq 11/9/2021 17:48:26'!
createCartFor: aUser with: aUserPassword 
	
	| aNewCart aNewCartId |
	self assert: (authenticationSystem authenticate: aUser with: aUserPassword) description: [RestInterface invalidUserOrPasswordErrorMessage].
	
	aNewCart := Cart acceptingItemsOf: catalog.
	aNewCartId := self idFor: aNewCart.
	carts at: aNewCartId put: aNewCart.
	cartsLastUsage at: aNewCartId put: clock now.

	^ aNewCartId! !

!RestInterface methodsFor: 'interface operations' stamp: 'gq 11/9/2021 17:12:52'!
listCart: aCartId
	
	self assertThatCartIdIsValid: aCartId.
	self validateThatIsNotExpired: aCartId.
	
	^ self listItemsWithOccurrencesOf: (carts at: aCartId)
! !


!RestInterface methodsFor: 'testing' stamp: 'gq 11/9/2021 17:49:56'!
isCartIdValid: aCartId

	^ carts includesKey: aCartId ! !


!RestInterface methodsFor: 'accessing - private' stamp: 'gq 11/9/2021 17:47:18'!
idFor: aNewCart

	^ aNewCart identityHash ! !

!RestInterface methodsFor: 'accessing - private' stamp: 'gq 11/9/2021 18:09:31'!
listItemsWithOccurrencesOf: aCartToList

	| aCartList |

	aCartList := Dictionary new.
	aCartToList items do: [:anItem | 
		aCartList at: anItem put: (aCartToList occurrencesOf: anItem)
	].
	
	^ aCartList! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: 'TusLibros'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'gq 11/9/2021 19:30:06'!
authenticatingWith: anAuthenticationSystem withCatalog: aCatalog withClock: aClock debitingBy: aMerchantProcessor registeringSalesOn: aSalesBook    

	^ self new initializeAuthenticatingWith: anAuthenticationSystem withCatalog: aCatalog withClock: aClock! !


!RestInterface class methodsFor: 'error messages' stamp: 'gq 11/9/2021 18:33:23'!
emptyCartErrorMessage
	
	^ 'Cart cannot be empty'! !

!RestInterface class methodsFor: 'error messages' stamp: 'JD 11/8/2021 20:03:04'!
expiredCartErrorMessage
	
	^ 'Cart has reached the expiration time'! !

!RestInterface class methodsFor: 'error messages' stamp: 'JD 11/7/2021 15:40:07'!
invalidCartIdErrorMessage
	
	^ 'Invalid cart ID'! !

!RestInterface class methodsFor: 'error messages' stamp: 'JD 11/4/2021 20:19:49'!
invalidUserOrPasswordErrorMessage
	
	^ 'Invalid User or Password'! !


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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'gq 11/9/2021 19:04:25'!
currentMonthOfYear
	
	^Month month: today monthIndex year: today yearNumber! !

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
