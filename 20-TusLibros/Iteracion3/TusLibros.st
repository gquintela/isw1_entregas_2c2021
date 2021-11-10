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

!CashierTest methodsFor: 'tests' stamp: 'JD 11/10/2021 17:17:30'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook purchasedBy: testObjectsFactory validUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'JD 11/10/2021 17:17:30'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new purchasedBy: testObjectsFactory validUser.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'JD 11/10/2021 17:17:30'!
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
				registeringOn: salesBook purchasedBy: testObjectsFactory validUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'JD 11/10/2021 17:17:30'!
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
		registeringOn: salesBook purchasedBy: testObjectsFactory validUser.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'JD 11/10/2021 17:17:30'!
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
		registeringOn: salesBook purchasedBy: testObjectsFactory validUser.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'JD 11/10/2021 17:17:30'!
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
		registeringOn: salesBook purchasedBy: testObjectsFactory validUser.
		
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
	instanceVariableNames: 'testObjectsFactory clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 18:46:37'!
test01CannotCreateACartWithAnInvalidUser

	| aRestInterface |
	aRestInterface := self restInterfaceWhichFailWhenAuthenticating.
	
	self assertThatShouldRaiseInvalidUserOrPasswordErrorMessage: [aRestInterface createCartFor: testObjectsFactory invalidUser with: testObjectsFactory validPassword]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 19:21:00'!
test02CanCreateACart

	| aRestInterface aCartId cartContents |
	
	aRestInterface := self defaultRestInterface.
	aCartId := 	self createCartForAValidUserAndPasswordUsing: aRestInterface.
	
	cartContents := aRestInterface listCart: aCartId.

	self assert: cartContents isEmpty ! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 19:22:54'!
test03CanAddAnItemToCart

	| aRestInterface aCartId cartContents anExpectedCartList |
	
	aRestInterface := self defaultRestInterface.
	aCartId := 	self createCartForAValidUserAndPasswordUsing: aRestInterface.
	self addAnItemTo: aCartId using: aRestInterface.

	cartContents := aRestInterface listCart: aCartId.
	anExpectedCartList := Dictionary new.
	anExpectedCartList at: testObjectsFactory itemSellByTheStore put: 1.
	self assert: anExpectedCartList equals: cartContents! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 19:22:54'!
test04CanCreateManyCarts

	| aRestInterface aCartId cartContents anotherCartContents anotherCartId anExpectedCartList |
	
	aRestInterface := self defaultRestInterface.
	aCartId := 	self createCartForAValidUserAndPasswordUsing: aRestInterface.
	self addAnItemTo: aCartId using: aRestInterface.
	anotherCartId := 	self createCartForAValidUserAndPasswordUsing: aRestInterface.

	cartContents := aRestInterface listCart: aCartId.
	anotherCartContents := aRestInterface listCart: anotherCartId.
	anExpectedCartList := Dictionary new.
	anExpectedCartList at: testObjectsFactory itemSellByTheStore put: 1.
	self assert: anExpectedCartList equals: cartContents.
	self assert: anotherCartContents isEmpty! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 18:46:59'!
test05CannotAddAnItemWithAnInvalidCartId

	| aRestInterface anInvalidCartId |
	
	aRestInterface := self defaultRestInterface.
	anInvalidCartId := 0.

	self assertThatShouldRaiseCartIdErrorMessage: [aRestInterface addToCart: anInvalidCartId quantity: 1 of: testObjectsFactory itemSellByTheStore.]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 18:47:05'!
test06CannotListAnItemWithAnInvalidCartId

	| aRestInterface anInvalidCartId |
	
	aRestInterface := self defaultRestInterface.
	anInvalidCartId := 0.
	
	self assertThatShouldRaiseCartIdErrorMessage: [aRestInterface listCart: anInvalidCartId]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 18:48:53'!
test07CannotListAnExpiredCart

	| aRestInterface anExpiredCartId |

	aRestInterface := self defaultRestInterface.
	anExpiredCartId := self expiredCartIdOf: aRestInterface.

	self assertThatShouldRaiseExpiredCartErrorMessage: [aRestInterface listCart: anExpiredCartId].
	self assertThatShouldRaiseCartIdErrorMessage: [aRestInterface listCart: anExpiredCartId]
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 18:49:29'!
test08CannotAddAnItemToAnExpiredCart

	| aRestInterface anExpiredCartId |
	
	aRestInterface := self defaultRestInterface.
	anExpiredCartId := self expiredCartIdOf: aRestInterface.

	self assertThatShouldRaiseExpiredCartErrorMessage: [aRestInterface addToCart: anExpiredCartId quantity: 1 of: testObjectsFactory itemSellByTheStore ].
	self assertThatShouldRaiseCartIdErrorMessage: [aRestInterface addToCart: anExpiredCartId quantity: 1 of: testObjectsFactory itemSellByTheStore ]
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 19:18:11'!
test09CannotCheckoutACartWithAnInvalidId

	| aRestInterface anInvalidCartId |

	aRestInterface := self defaultRestInterface.
	anInvalidCartId := 	0.
	
	self assertThatShouldRaiseCartIdErrorMessage: [aRestInterface checkoutCart: anInvalidCartId withCreditCardNumber: self creditCardNumber expiringOn: testObjectsFactory currentMonthOfYear ownedBy: self creditCardOwner]
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 19:18:11'!
test10CannotCheckoutAnExpiredCart

	| aRestInterface anExpiredCartId |
	
	aRestInterface := self defaultRestInterface.
	anExpiredCartId := self expiredCartIdOf: aRestInterface.

	self assertThatShouldRaiseExpiredCartErrorMessage: [aRestInterface checkoutCart: anExpiredCartId withCreditCardNumber: self creditCardNumber expiringOn: testObjectsFactory currentMonthOfYear ownedBy: self creditCardOwner]
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 19:21:00'!
test11CannotCheckoutAnEmptyCart

	| aRestInterface anEmptyCartId |
	
	aRestInterface := self defaultRestInterface.
	anEmptyCartId := 	self createCartForAValidUserAndPasswordUsing: aRestInterface.

	self assertThat: [aRestInterface checkoutCart: anEmptyCartId withCreditCardNumber: self creditCardNumber expiringOn: testObjectsFactory currentMonthOfYear ownedBy: self creditCardOwner] shouldRaise: AssertionFailure - MessageNotUnderstood with: RestInterface emptyCartErrorMessage
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 19:25:46'!
test12CanCheckoutACart

	| aRestInterface aCartId |

	aRestInterface := self defaultRestInterface.
	aCartId := 	self createCartForAValidUserAndPasswordUsing: aRestInterface.
	self addAnItemTo: aCartId using: aRestInterface.
	
	self checkoutCart: aCartId withAValidCreditCardUsing: aRestInterface.
	
	self assertThatShouldRaiseCartIdErrorMessage: [aRestInterface listCart: aCartId]

	
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 18:47:26'!
test13CannotListPurchasesOfAnInvalidUserId

	| aRestInterface |

	aRestInterface := self restInterfaceWhichFailWhenAuthenticating.

	self assertThatShouldRaiseInvalidUserOrPasswordErrorMessage: [aRestInterface listPurchases: testObjectsFactory invalidUser with: testObjectsFactory validPassword]
	
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 18:37:58'!
test14CanListPurchasesOfAUserWithoutPurchases

	| aRestInterface aPurchasesList |

	aRestInterface := self defaultRestInterface.

	aPurchasesList := aRestInterface listPurchases: testObjectsFactory validUser with: testObjectsFactory validPassword.

	self assert: aPurchasesList isEmpty

! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JD 11/10/2021 18:37:27'!
test15CanListPurchasesOfAUserWithPurchases

	| aRestInterface aPurchasesList aCartId |

	aRestInterface := self defaultRestInterface.
	aCartId := 	self checkedOutCartIdOf: aRestInterface.

	aPurchasesList := aRestInterface listPurchases: testObjectsFactory validUser with: testObjectsFactory validPassword.

	self assert: aPurchasesList size = 1.
	self assert: (OrderedCollection with: testObjectsFactory itemSellByTheStore) equals: aPurchasesList first items.
	self assert: testObjectsFactory itemSellByTheStorePrice equals: aPurchasesList first total.
	self assert: testObjectsFactory validUser equals: aPurchasesList first buyer.

! !


!RestInterfaceTest methodsFor: 'merchant processor' stamp: 'JD 11/10/2021 16:29:37'!
debit: anAmount from: aCreditCard 
! !


!RestInterfaceTest methodsFor: 'authentication service' stamp: 'JD 11/10/2021 18:12:09'!
authenticationSystemPreparedForAuthenticationSuccess
	
	| anAuthenticationStub |

	anAuthenticationStub := AuthenticationServiceStub new.
	anAuthenticationStub prepareForAuthenticationSuccess.
	
	^ anAuthenticationStub! !

!RestInterfaceTest methodsFor: 'authentication service' stamp: 'JD 11/10/2021 18:12:09'!
authenticationSystemPreparedForInvalidUserOrPasswordFailure
	
	| anAuthenticationStub |

	anAuthenticationStub := AuthenticationServiceStub new.
	anAuthenticationStub prepareForInvalidUserOrPasswordFailure.
	
	^ anAuthenticationStub! !


!RestInterfaceTest methodsFor: 'assertions' stamp: 'JD 11/10/2021 18:51:19'!
assertThat: aBlock shouldRaise: anExpectedError with: anExpectedErrorMessage
	
	self
		should: aBlock
		raise: anExpectedError
		withExceptionDo: [:anError | self assert: anError messageText = anExpectedErrorMessage ]! !

!RestInterfaceTest methodsFor: 'assertions' stamp: 'JD 11/10/2021 18:51:48'!
assertThatShouldRaiseCartIdErrorMessage: aBlock

	self assertThat: aBlock shouldRaise: AssertionFailure - MessageNotUnderstood with: RestInterface invalidCartIdErrorMessage
! !

!RestInterfaceTest methodsFor: 'assertions' stamp: 'JD 11/10/2021 18:52:09'!
assertThatShouldRaiseExpiredCartErrorMessage: aBlock
	
	self assertThat: aBlock shouldRaise: Error - MessageNotUnderstood with: RestInterface expiredCartErrorMessage! !

!RestInterfaceTest methodsFor: 'assertions' stamp: 'JD 11/10/2021 18:52:44'!
assertThatShouldRaiseInvalidUserOrPasswordErrorMessage: aBlock

	self assertThat: aBlock shouldRaise: AssertionFailure - MessageNotUnderstood with: RestInterface invalidUserOrPasswordErrorMessage! !


!RestInterfaceTest methodsFor: 'carts id' stamp: 'JD 11/10/2021 19:25:46'!
checkedOutCartIdOf: aRestInterface

	| aCartId |

	aCartId := self createCartForAValidUserAndPasswordUsing: aRestInterface.
	self addAnItemTo: aCartId using: aRestInterface.
	self checkoutCart: aCartId withAValidCreditCardUsing: aRestInterface.
	
	^ aCartId 
! !

!RestInterfaceTest methodsFor: 'carts id' stamp: 'JD 11/10/2021 19:21:00'!
expiredCartIdOf: aRestInterface

	| aCartId |

	aCartId := 	self createCartForAValidUserAndPasswordUsing: aRestInterface.
	
	clock now: (testObjectsFactory today + (Duration minutes: 31)).
	
	^ aCartId! !


!RestInterfaceTest methodsFor: 'rest interfaces' stamp: 'JD 11/10/2021 18:29:58'!
defaultRestInterface

	^ RestInterface authenticatingWith: self authenticationSystemPreparedForAuthenticationSuccess withCatalog: testObjectsFactory defaultCatalog withClock: clock debitingBy: self registeringSalesOn: OrderedCollection new! !

!RestInterfaceTest methodsFor: 'rest interfaces' stamp: 'JD 11/10/2021 18:30:25'!
restInterfaceWhichFailWhenAuthenticating

	^ RestInterface authenticatingWith: self authenticationSystemPreparedForInvalidUserOrPasswordFailure withCatalog: testObjectsFactory defaultCatalog withClock: clock debitingBy: self registeringSalesOn: OrderedCollection new! !


!RestInterfaceTest methodsFor: 'set up' stamp: 'JD 11/10/2021 18:29:45'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	clock := SimulatedClock for: testObjectsFactory today! !


!RestInterfaceTest methodsFor: 'credit card data' stamp: 'JD 11/10/2021 19:17:44'!
creditCardNumber

	^ '1234567890123456'! !

!RestInterfaceTest methodsFor: 'credit card data' stamp: 'JD 11/10/2021 19:18:11'!
creditCardOwner

	^ 'Alan Kay'! !


!RestInterfaceTest methodsFor: 'interface operations' stamp: 'JD 11/10/2021 19:22:54'!
addAnItemTo: aCartId using: aRestInterface

	^ aRestInterface addToCart: aCartId quantity: 1 of: testObjectsFactory itemSellByTheStore! !

!RestInterfaceTest methodsFor: 'interface operations' stamp: 'JD 11/10/2021 19:25:46'!
checkoutCart: aCartId withAValidCreditCardUsing: aRestInterface

	^ aRestInterface checkoutCart: aCartId withCreditCardNumber: self creditCardNumber expiringOn: testObjectsFactory currentMonthOfYear ownedBy: self creditCardOwner! !

!RestInterfaceTest methodsFor: 'interface operations' stamp: 'JD 11/10/2021 19:21:00'!
createCartForAValidUserAndPasswordUsing: aRestInterface

	^ aRestInterface createCartFor: testObjectsFactory validUser with: testObjectsFactory validPassword! !


!classDefinition: #AuthenticationService category: 'TusLibros'!
Object subclass: #AuthenticationService
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticationService methodsFor: 'authentication' stamp: 'JD 11/10/2021 18:12:42'!
authenticate: aUser with: aUserPassword 
	
	self subclassResponsibility ! !


!classDefinition: #AuthenticationServiceStub category: 'TusLibros'!
AuthenticationService subclass: #AuthenticationServiceStub
	instanceVariableNames: 'authenticationResult'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticationServiceStub methodsFor: 'authentication' stamp: 'JD 11/4/2021 20:34:30'!
authenticate: aUser with: aUserPassword 
	
	^ authenticationResult ! !


!AuthenticationServiceStub methodsFor: 'test preparation' stamp: 'JD 11/4/2021 20:37:32'!
prepareForAuthenticationSuccess
	
	authenticationResult := true! !

!AuthenticationServiceStub methodsFor: 'test preparation' stamp: 'JD 11/4/2021 20:35:44'!
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


!Cart methodsFor: 'items' stamp: 'JD 11/7/2021 15:18:55'!
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
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total buyer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'JD 11/10/2021 17:34:01'!
createSale

	^ Sale of: cart items withTotal: total madeBy: buyer

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


!Cashier methodsFor: 'initialization' stamp: 'JD 11/10/2021 17:18:51'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook purchasedBy: aBuyer
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	buyer := aBuyer! !

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


!Cashier class methodsFor: 'instance creation' stamp: 'JD 11/10/2021 17:17:41'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook purchasedBy: aBuyer 
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook purchasedBy: aBuyer! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'time' stamp: 'JD 11/10/2021 18:15:41'!
now
	
	self subclassResponsibility ! !


!classDefinition: #SimulatedClock category: 'TusLibros'!
Clock subclass: #SimulatedClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SimulatedClock methodsFor: 'time' stamp: 'JD 11/8/2021 21:33:28'!
now
	
	^ now! !

!SimulatedClock methodsFor: 'time' stamp: 'JD 11/8/2021 21:26:27'!
now: aTodayDate
	
	now := aTodayDate! !


!SimulatedClock methodsFor: 'initialization' stamp: 'JD 11/8/2021 21:19:00'!
initializeFor: aTodayDate
	
	now := aTodayDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimulatedClock class' category: 'TusLibros'!
SimulatedClock class
	instanceVariableNames: ''!

!SimulatedClock class methodsFor: 'instance creation' stamp: 'JD 11/8/2021 21:19:35'!
for: aTodayDate
	
	^ self new initializeFor: aTodayDate! !


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
	instanceVariableNames: 'authenticationSystem carts catalog clock cartsLastUsage merchantProcessor salesBook cartUsers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'assertions' stamp: 'gq 11/9/2021 17:03:37'!
assertThatCartIdIsValid: aCartId

	^ self assert: (self isCartIdValid: aCartId) description: [RestInterface invalidCartIdErrorMessage]! !

!RestInterface methodsFor: 'assertions' stamp: 'JD 11/10/2021 17:57:47'!
assertThatCartIsNotEmpty: aCartIdToCheckout

	^ self assert: (carts at: aCartIdToCheckout) isEmpty not description: RestInterface emptyCartErrorMessage! !

!RestInterface methodsFor: 'assertions' stamp: 'JD 11/10/2021 18:02:41'!
validateThatIsNotExpired: aCartId
	
	(clock now - (cartsLastUsage at: aCartId)) minutes <= 30 ifFalse: [
		self deleteCart: aCartId.
		self error: RestInterface expiredCartErrorMessage
	].
! !


!RestInterface methodsFor: 'initialization' stamp: 'JD 11/10/2021 17:46:06'!
initializeAuthenticatingWith: anAuthenticationSystem withCatalog: aCatalog withClock: aClock debitingBy: aMerchantProcessor registeringSalesOn: aSalesBook 

	authenticationSystem := anAuthenticationSystem.
	catalog := aCatalog.
	carts :=  Dictionary new.
	clock := aClock.
	cartsLastUsage := Dictionary new.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	cartUsers := Dictionary new! !


!RestInterface methodsFor: 'interface operations' stamp: 'gq 11/9/2021 17:13:49'!
addToCart: aCartId quantity: aBookQuantity of: aBookISBN 
	
	self assertThatCartIdIsValid: aCartId.
	self validateThatIsNotExpired: aCartId.
	
	(carts at: aCartId) add: aBookQuantity of: aBookISBN.
	! !

!RestInterface methodsFor: 'interface operations' stamp: 'JD 11/10/2021 18:05:14'!
assertThatCanAuthenticate: aUserPassword with: aUser

	^ self assert: (authenticationSystem authenticate: aUser with: aUserPassword) description: [RestInterface invalidUserOrPasswordErrorMessage]! !

!RestInterface methodsFor: 'interface operations' stamp: 'JD 11/10/2021 18:03:50'!
checkoutCart: aCartIdToCheckout withCreditCardNumber: aCreditCardNumber expiringOn: aCreditCardExpirationDate ownedBy: aCreditCardOwner    
	
	| aCreditCard |
	
	self assertThatCartIdIsValid: aCartIdToCheckout.
	self validateThatIsNotExpired: aCartIdToCheckout.
	self assertThatCartIsNotEmpty: aCartIdToCheckout.
	
	aCreditCard := CreditCard expiringOn: aCreditCardExpirationDate.
	self checkoutCart: aCartIdToCheckout payingWith: aCreditCard! !

!RestInterface methodsFor: 'interface operations' stamp: 'JD 11/10/2021 18:07:50'!
createCartFor: aUser with: aUserPassword 
	
	| aNewCart aNewCartId |
	self assertThatCanAuthenticate: aUser with: aUserPassword.
	
	aNewCart := Cart acceptingItemsOf: catalog.
	aNewCartId := self idFor: aNewCart.
	self saveCart: aNewCart for: aUser with: aNewCartId.

	^ aNewCartId! !

!RestInterface methodsFor: 'interface operations' stamp: 'gq 11/9/2021 17:12:52'!
listCart: aCartId
	
	self assertThatCartIdIsValid: aCartId.
	self validateThatIsNotExpired: aCartId.
	
	^ self listItemsWithOccurrencesOf: (carts at: aCartId)
! !

!RestInterface methodsFor: 'interface operations' stamp: 'JD 11/10/2021 18:05:35'!
listPurchases: aUser with: aUserPassword 
	
	self assertThatCanAuthenticate: aUser with: aUserPassword.
	
	^ salesBook select: [:aSale | aSale buyer = aUser]! !


!RestInterface methodsFor: 'interface operations - private' stamp: 'JD 11/10/2021 19:09:41'!
checkoutCart: aCartIdToCheckout payingWith: aCreditCard
	
	| aCashier aTransactionId |

	aCashier := Cashier toCheckout: (carts at: aCartIdToCheckout) charging: aCreditCard throught: merchantProcessor on: clock now registeringOn: salesBook purchasedBy: (cartUsers at: aCartIdToCheckout).
	
	aCashier checkOut.
	self deleteCart: aCartIdToCheckout.
	
	aTransactionId := salesBook size.

	^ aTransactionId
	! !

!RestInterface methodsFor: 'interface operations - private' stamp: 'JD 11/10/2021 18:03:08'!
deleteCart: aCartId

	cartsLastUsage removeKey: aCartId.
	carts removeKey: aCartId! !

!RestInterface methodsFor: 'interface operations - private' stamp: 'gq 11/9/2021 17:47:18'!
idFor: aNewCart

	^ aNewCart identityHash ! !

!RestInterface methodsFor: 'interface operations - private' stamp: 'gq 11/9/2021 18:09:31'!
listItemsWithOccurrencesOf: aCartToList

	| aCartList |

	aCartList := Dictionary new.
	aCartToList items do: [:anItem | 
		aCartList at: anItem put: (aCartToList occurrencesOf: anItem)
	].
	
	^ aCartList! !

!RestInterface methodsFor: 'interface operations - private' stamp: 'JD 11/10/2021 18:08:19'!
saveCart: aNewCart for: aUser with: aNewCartId

	carts at: aNewCartId put: aNewCart.
	cartsLastUsage at: aNewCartId put: clock now.
	cartUsers at: aNewCartId put: aUser! !


!RestInterface methodsFor: 'testing' stamp: 'gq 11/9/2021 17:49:56'!
isCartIdValid: aCartId

	^ carts includesKey: aCartId ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: 'TusLibros'!
RestInterface class
	instanceVariableNames: 'cartUsers'!

!RestInterface class methodsFor: 'instance creation' stamp: 'JD 11/10/2021 16:25:55'!
authenticatingWith: anAuthenticationSystem withCatalog: aCatalog withClock: aClock debitingBy: aMerchantProcessor registeringSalesOn: aSalesBook    

	^ self new initializeAuthenticatingWith: anAuthenticationSystem withCatalog: aCatalog withClock: aClock debitingBy: aMerchantProcessor registeringSalesOn: aSalesBook ! !


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
	instanceVariableNames: 'total items buyer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'accessing' stamp: 'JD 11/10/2021 17:43:46'!
buyer
	
	^ buyer ! !

!Sale methodsFor: 'accessing' stamp: 'JD 11/10/2021 17:44:54'!
items
	
	^ items! !

!Sale methodsFor: 'accessing' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'JD 11/10/2021 17:32:16'!
initializeBoughtItems: boughtItems withTotal: aTotalPrice madeBy: aBuyer
	
	items := boughtItems.
	total := aTotalPrice.
	buyer := aBuyer! !

!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'JD 11/10/2021 17:31:31'!
of: boughtItems withTotal: aTotalPrice madeBy: aBuyer

	"should assert total is not negative or 0!!"
	^self new initializeBoughtItems: boughtItems withTotal: aTotalPrice madeBy: aBuyer! !


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


!StoreTestObjectsFactory methodsFor: 'users' stamp: 'JD 11/10/2021 17:20:03'!
invalidUser

	^ 'InvalidUser'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'JD 11/10/2021 17:19:58'!
validPassword
	
	^ 'ValidPassword'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'JD 11/10/2021 17:19:54'!
validUser
	
	^ 'ValidUser'! !
