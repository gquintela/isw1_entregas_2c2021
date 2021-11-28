!classDefinition: #TusLibrosWindow category: 'TusLibros-View'!
Panel subclass: #TusLibrosWindow
	instanceVariableNames: 'cartListMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-View'!

!TusLibrosWindow methodsFor: 'events actions' stamp: 'JD 11/28/2021 02:04:46'!
dismissSubmorphs

	self layoutMorph submorphs do: [:aSubmorph | aSubmorph dismissMorph]! !

!TusLibrosWindow methodsFor: 'events actions' stamp: 'JD 11/28/2021 02:03:28'!
redirectToLoginWindow
	
	self dismissSubmorphs.
	self initializeWithTitle: self class logInTitle.! !

!TusLibrosWindow methodsFor: 'events actions' stamp: 'JD 11/28/2021 02:06:42'!
redirectToShopWindowWith: aCartId

	self model: (TusLibrosShopWindowModel newFor: aCartId authenticating: self model usernameText with: self model passwordHash).
	self setLabel: 'Shop'.
	self dismissSubmorphs.
	self buildMorphicShopWindow.

	self model when: #cartModified send: #refreshCartList to: self.
	self model when: #cartCheckouted send: #redirectToTicketWindow to: self! !

!TusLibrosWindow methodsFor: 'events actions' stamp: 'JD 11/28/2021 02:17:30'!
redirectToTicketWindow
	
	self model: (TusLibrosTicketWindowModel newFor: self model listCart authenticating: self model usernameText with: self model passwordHash).
	self setLabel: 'Checkout Completed'.
	self dismissSubmorphs.
	self buildMorphicTicketWindow.

	self model when: #loggedOut send: #redirectToLoginWindow to: self.
	self model when: #newCartRequested send: #redirectToShopWindowWith: to: self! !

!TusLibrosWindow methodsFor: 'events actions' stamp: 'JD 11/26/2021 23:10:43'!
refreshCartList

	cartListMorph updateList.
	cartListMorph setSelectionIndex: 0.! !


!TusLibrosWindow methodsFor: 'initialization' stamp: 'JD 11/28/2021 02:07:07'!
initializeWithTitle: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosLogInWindowModel new).
	self morphExtent: 1035@485.
	self buildMorphicWindow.
	self openInWorld.
			
	self model when: #newCartCreated send: #redirectToShopWindowWith: to: self! !


!TusLibrosWindow methodsFor: 'log in - layouts' stamp: 'JD 11/28/2021 02:30:02'!
buildCreateCartButtonRow

	| createCartButtonRowLayoutMorph createCartButtonMorph |
	
	createCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #createCart label: 'Create Cart'.

	createCartButtonRowLayoutMorph := LayoutMorph newRow.
	self applyStyleTo: createCartButtonRowLayoutMorph.
	createCartButtonRowLayoutMorph addMorph: createCartButtonMorph.
	
	^ createCartButtonRowLayoutMorph.! !

!TusLibrosWindow methodsFor: 'log in - layouts' stamp: 'JD 11/28/2021 02:30:05'!
buildLoginColumn

	| loginColumnLayoutMorph |
		
	loginColumnLayoutMorph := LayoutMorph newColumn.
	self applyStyleTo: loginColumnLayoutMorph.
	loginColumnLayoutMorph 
		addMorph: self buildUsernameRow;
		addMorph: self buildPasswordRow;
		addMorph: self buildCreateCartButtonRow.
	
	^ loginColumnLayoutMorph.! !

!TusLibrosWindow methodsFor: 'log in - layouts' stamp: 'JD 11/28/2021 02:30:08'!
buildPasswordRow

	| passwordRowLayoutMorph passwordTextBoxMorph |
	
	passwordTextBoxMorph := TextModelMorph textProvider: self model textGetter: #passwordText textSetter: #passwordText:. 
	self setPropertyKeyStrokeToInnerTextMorphOf: passwordTextBoxMorph.
	passwordTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300; morphHeight: 30.
		
	passwordRowLayoutMorph := LayoutMorph newRow.
	self applyStyleTo: passwordRowLayoutMorph.
	passwordRowLayoutMorph
		addMorph: (LabelMorph contents: 'Password');
		addMorph: passwordTextBoxMorph.
	
	^ passwordRowLayoutMorph.! !

!TusLibrosWindow methodsFor: 'log in - layouts' stamp: 'JD 11/28/2021 02:21:42'!
buildUsernameRow

	| usernameRowLayoutMorph usernameTextBoxMorph |
	
	usernameTextBoxMorph := TextModelMorph textProvider: self model textGetter: #usernameText textSetter: #usernameText:. 
	self setPropertyKeyStrokeToInnerTextMorphOf: usernameTextBoxMorph .
	usernameTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300; morphHeight: 30. 
		
	usernameRowLayoutMorph := LayoutMorph newRow.
	self applyStyleTo: usernameRowLayoutMorph.
	usernameRowLayoutMorph
		addMorph: (LabelMorph contents: 'Username');
		addMorph: usernameTextBoxMorph.
	
	^ usernameRowLayoutMorph.! !


!TusLibrosWindow methodsFor: 'morphs properties - private' stamp: 'JD 11/28/2021 02:15:31'!
applyStyleTo: aLayoutMorph

	aLayoutMorph separation: 5.
	aLayoutMorph axisEdgeWeight: 0.5.! !

!TusLibrosWindow methodsFor: 'morphs properties - private' stamp: 'JD 11/28/2021 03:36:45'!
setPropertyKeyStrokeToInnerTextMorphOf: usernameTextBoxMorph

	usernameTextBoxMorph innerTextMorph setProperty: #keyStroke: toValue: [ :key | usernameTextBoxMorph innerTextMorph acceptContents ]! !


!TusLibrosWindow methodsFor: 'shop - layouts' stamp: 'JD 11/28/2021 02:22:48'!
buildCart

	| cartColumnLayoutMorph |

	cartListMorph := PluggableListMorph model: self model listGetter: #listCart indexGetter: #cartListIndex indexSetter: #cartListIndex:.
	cartListMorph borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
	
	cartColumnLayoutMorph := LayoutMorph newColumn.
	self applyStyleTo: cartColumnLayoutMorph.
	cartColumnLayoutMorph
		addMorph: (LabelMorph contents: 'Cart');
		addMorph: cartListMorph.

	^ cartColumnLayoutMorph! !

!TusLibrosWindow methodsFor: 'shop - layouts' stamp: 'JD 11/28/2021 02:30:50'!
buildCartRow
	
	| cartRowLayoutMorph |

	cartRowLayoutMorph := LayoutMorph newRow.
	cartRowLayoutMorph separation: 20;
	axisEdgeWeight: 0.5;
	addMorph: self buildCart;
	addMorph: self buildRemoveFromCartButtonColumn.
	
	^ cartRowLayoutMorph
	! !

!TusLibrosWindow methodsFor: 'shop - layouts' stamp: 'JD 11/28/2021 02:31:21'!
buildCatalogAndAddToCartRow
	
	| catalogAndAddToCartRowLayoutMorph |

	catalogAndAddToCartRowLayoutMorph := LayoutMorph newRow.
	catalogAndAddToCartRowLayoutMorph separation: 20;
	axisEdgeWeight: 0.5;
	addMorph: self buildCatalogColumn;
	addMorph: self buildItemQuantityAndAddToCartButtonColumn.
	
	^ catalogAndAddToCartRowLayoutMorph
	! !

!TusLibrosWindow methodsFor: 'shop - layouts' stamp: 'JD 11/28/2021 02:23:43'!
buildCatalogColumn

	| catalogListMorph catalogColumnLayoutMorph |

	catalogListMorph := PluggableListMorph model: self model listGetter: #listCatalog indexGetter: #catalogListIndex indexSetter: #catalogListIndex:.
	catalogListMorph borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
	
	catalogColumnLayoutMorph := LayoutMorph newColumn.
	self applyStyleTo: catalogColumnLayoutMorph.
	catalogColumnLayoutMorph
		addMorph: (LabelMorph contents: 'Catalog');
		addMorph: catalogListMorph.
	
	^ catalogColumnLayoutMorph! !

!TusLibrosWindow methodsFor: 'shop - layouts' stamp: 'JD 11/28/2021 03:34:43'!
buildCheckoutAndPurchasesButtonsRow

	| buttonsLayoutMorph checkoutCartButtonMorph showPurchasesButtonMorph |

	checkoutCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #checkoutCart label: 'Checkout Cart'.
	
	showPurchasesButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #showPurchases label: 'Show Purchases'.
	
	buttonsLayoutMorph := LayoutMorph newRow.
	self applyStyleTo: buttonsLayoutMorph.
	buttonsLayoutMorph
		addMorph: checkoutCartButtonMorph;
		addMorph: showPurchasesButtonMorph.
	
	^ buttonsLayoutMorph! !

!TusLibrosWindow methodsFor: 'shop - layouts' stamp: 'JD 11/28/2021 02:25:36'!
buildItemQuantityAndAddToCartButtonColumn
	
	| addToCartButtonMorph itemQuantityTextBoxMorph itemQuantityAndAddToCartColumnLayoutMorph |
	
	itemQuantityTextBoxMorph := TextModelMorph textProvider: self model textGetter: #itemQuantityText textSetter: #itemQuantityText:. 
	self setPropertyKeyStrokeToInnerTextMorphOf: itemQuantityTextBoxMorph.
	itemQuantityTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 25; morphHeight: 25.
	
	addToCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #addToCart  label: 'Add To Cart'.
	
	itemQuantityAndAddToCartColumnLayoutMorph := LayoutMorph newColumn.
	self applyStyleTo: itemQuantityAndAddToCartColumnLayoutMorph.
	itemQuantityAndAddToCartColumnLayoutMorph
		addMorph: (LabelMorph contents:'Quantity');
		addMorph: itemQuantityTextBoxMorph;
		addMorph: addToCartButtonMorph.
	
	^ itemQuantityAndAddToCartColumnLayoutMorph
! !

!TusLibrosWindow methodsFor: 'shop - layouts' stamp: 'JD 11/28/2021 02:26:08'!
buildRemoveFromCartButtonColumn

	| removeFromCartButtonMorph removeFromCartColumnLayoutMorph |

	removeFromCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #removeFromCart  label: 'Remove From Cart'.
	
	removeFromCartColumnLayoutMorph := LayoutMorph newColumn.
	self applyStyleTo: removeFromCartColumnLayoutMorph.
	removeFromCartColumnLayoutMorph addMorph: removeFromCartButtonMorph.
	
	^ removeFromCartColumnLayoutMorph
! !


!TusLibrosWindow methodsFor: 'ticket - layouts' stamp: 'JD 11/28/2021 03:34:12'!
buildLogOutAndContinueBuyingButtonsRow

	| buttonsLayoutMorph logOutButtonMorph continueBuyingButtonMorph |

	logOutButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #logOut label: 'Log Out'.
	
	continueBuyingButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #continueBuying label: 'Continue Buying'.
	
	buttonsLayoutMorph := LayoutMorph newRow.
	self applyStyleTo: buttonsLayoutMorph.
	buttonsLayoutMorph
		addMorph: logOutButtonMorph;
		addMorph: continueBuyingButtonMorph.
	
	^ buttonsLayoutMorph! !

!TusLibrosWindow methodsFor: 'ticket - layouts' stamp: 'JD 11/28/2021 03:34:12'!
buildTicketColumn
	
	| ticketColumnLayoutMorph ticketListMorph |
	
	ticketListMorph := PluggableListMorph model: self model listGetter: #listTicket indexGetter: nil indexSetter: nil.
	ticketListMorph borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.

	ticketColumnLayoutMorph := LayoutMorph newColumn.
	self applyStyleTo: ticketColumnLayoutMorph.
	ticketColumnLayoutMorph
		addMorph: (LabelMorph contents: 'Ticket');
		addMorph: ticketListMorph;
		addMorph: self buildLogOutAndContinueBuyingButtonsRow.
	
	^ ticketColumnLayoutMorph
	! !


!TusLibrosWindow methodsFor: 'windows morphs build' stamp: 'JD 11/28/2021 03:34:43'!
buildMorphicShopWindow
		
	self layoutMorph beColumn;
	separation: 10;
	axisEdgeWeight: 0;
	addMorph: self buildCatalogAndAddToCartRow;
	addMorph: self buildCartRow;
	addMorph: self buildCheckoutAndPurchasesButtonsRow! !

!TusLibrosWindow methodsFor: 'windows morphs build' stamp: 'JD 11/27/2021 13:46:25'!
buildMorphicTicketWindow
		
	self layoutMorph beColumn;
	separation: 10;
	axisEdgeWeight: 0;
	addMorph: self buildTicketColumn.! !

!TusLibrosWindow methodsFor: 'windows morphs build' stamp: 'JD 11/28/2021 02:20:07'!
buildMorphicWindow
		
	self layoutMorph beRow;
	separation: 150;
	axisEdgeWeight: 0;
	addMorph: self buildLoginColumn.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosWindow class' category: 'TusLibros-View'!
TusLibrosWindow class
	instanceVariableNames: ''!

!TusLibrosWindow class methodsFor: 'as yet unclassified' stamp: 'JD 11/27/2021 14:13:03'!
logInTitle
	
	^ 'Tus Libros Login'! !

!TusLibrosWindow class methodsFor: 'as yet unclassified' stamp: 'JD 11/27/2021 14:12:56'!
open
	
	^ self new initializeWithTitle: self logInTitle! !


!classDefinition: #TusLibrosRestInterface category: 'TusLibros-View'!
Object subclass: #TusLibrosRestInterface
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-View'!

!TusLibrosRestInterface methodsFor: 'port' stamp: 'JD 11/22/2021 13:35:59'!
port
	
	^ port ifNil: [port:=8080].! !


!TusLibrosRestInterface methodsFor: 'requests parameters names' stamp: 'JD 11/28/2021 00:39:56'!
bookAmountRequestParameterName

	^ 'bookAmount'! !

!TusLibrosRestInterface methodsFor: 'requests parameters names' stamp: 'JD 11/28/2021 00:40:22'!
bookRequestParameterName

	^ 'book'! !

!TusLibrosRestInterface methodsFor: 'requests parameters names' stamp: 'JD 11/28/2021 00:40:47'!
cartIdRequestParameterName

	^ 'cartId'! !

!TusLibrosRestInterface methodsFor: 'requests parameters names' stamp: 'JD 11/28/2021 00:41:30'!
creditCardExpirationRequestParameterName

	^ 'cced'! !

!TusLibrosRestInterface methodsFor: 'requests parameters names' stamp: 'JD 11/28/2021 00:41:15'!
creditCardNumberRequestParameterName

	^ 'ccn'! !

!TusLibrosRestInterface methodsFor: 'requests parameters names' stamp: 'JD 11/28/2021 00:41:46'!
creditCardOwnerRequestParameterName

	^ 'cco'! !

!TusLibrosRestInterface methodsFor: 'requests parameters names' stamp: 'JD 11/28/2021 00:43:24'!
passwordRequestParameterName

	^ 'password'! !

!TusLibrosRestInterface methodsFor: 'requests parameters names' stamp: 'JD 11/28/2021 00:42:58'!
userRequestParameterName

	^ 'user'! !


!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'JD 11/28/2021 00:53:20'!
sendAddToCartRequest: aQuantity of: aBook to: aCartId

	^ self 
		sendRequestWithParameters: {
			self bookAmountRequestParameterName. aQuantity. 
			self bookRequestParameterName. aBook. 
			self cartIdRequestParameterName. aCartId
		}
		to: self addToCartUrl! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'JD 11/28/2021 00:53:10'!
sendCheckoutOutCartRequestFor: aCartId withCreditCardNumber: aCreditCardNumber expiringOn: anExpirationMonthOfYear ownedBy: aCreditCardOwner
	
	^ self 
		sendRequestWithParameters: {
			self cartIdRequestParameterName. aCartId. 
			self creditCardNumberRequestParameterName. aCreditCardNumber. 
			self creditCardExpirationRequestParameterName. anExpirationMonthOfYear. 
			self creditCardOwnerRequestParameterName. aCreditCardOwner.
		}
		to: self checkoutCartUrl! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'JD 11/28/2021 00:50:27'!
sendCreateCartRequestWith: aUsername and: aPassword
	
	^ self 
		sendRequestWithParameters: {
			self userRequestParameterName. aUsername. 
			self passwordRequestParameterName. aPassword
		} 
		to: self createCartUrl! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'JD 11/28/2021 00:53:53'!
sendListCartRequest: aCartId

	^ self 
		sendRequestWithParameters: {
			self cartIdRequestParameterName. aCartId.
		} 
		to: self listCartUrl! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'JD 11/28/2021 00:54:24'!
sendListCatalogRequest
	
	^ self 
		sendRequestWithParameters: {} 
		to: self listCatalogUrl! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'JD 11/28/2021 00:55:27'!
sendListPurchasesRequestFor: aUsername authenticatingWith: aPassword

	^ self 
		sendRequestWithParameters: {
			self userRequestParameterName. aUsername. 
			self passwordRequestParameterName. aPassword.
		} 
		to: self listPurchasesUrl! !

!TusLibrosRestInterface methodsFor: 'sending requests' stamp: 'JD 11/28/2021 00:56:42'!
sendRemoveFromCartRequest: aBookToRemove from: aCartId	

	^ self 
		sendRequestWithParameters: {
			self bookRequestParameterName. aBookToRemove. 
			self cartIdRequestParameterName. aCartId.
		} 
		to: self removeFromCartUrl! !


!TusLibrosRestInterface methodsFor: 'sending requests - private' stamp: 'JD 11/28/2021 00:35:52'!
responseContentOrError: aResponse

	aResponse isSuccess 
		ifTrue:[^ WebUtils jsonDecode: ((aResponse content) readStream)]
		ifFalse:[^ self error: aResponse content].! !

!TusLibrosRestInterface methodsFor: 'sending requests - private' stamp: 'JD 11/28/2021 00:48:57'!
sendRequestWithParameters: parameters to: url

	| response urlFields |
	
	urlFields := Dictionary newFromPairs: parameters.
	response := WebClient htmlSubmit: url fields: urlFields.
	
	^ self responseContentOrError: response! !


!TusLibrosRestInterface methodsFor: 'urls' stamp: 'JD 11/26/2021 17:35:35'!
addToCartUrl

	^ self rootUrl, '/add-to-cart'! !

!TusLibrosRestInterface methodsFor: 'urls' stamp: 'JD 11/26/2021 21:50:54'!
checkoutCartUrl

	^ self rootUrl, '/checkout-cart'! !

!TusLibrosRestInterface methodsFor: 'urls' stamp: 'JD 11/22/2021 13:35:17'!
createCartUrl

	^ self rootUrl, '/create-cart'! !

!TusLibrosRestInterface methodsFor: 'urls' stamp: 'JD 11/22/2021 21:25:08'!
listCartUrl

	^ self rootUrl, '/list-cart'! !

!TusLibrosRestInterface methodsFor: 'urls' stamp: 'JD 11/22/2021 21:26:40'!
listCatalogUrl

	^ self rootUrl, '/list-catalog'! !

!TusLibrosRestInterface methodsFor: 'urls' stamp: 'JD 11/26/2021 21:33:20'!
listPurchasesUrl

	^ self rootUrl, '/list-purchases'! !

!TusLibrosRestInterface methodsFor: 'urls' stamp: 'JD 11/26/2021 22:52:21'!
removeFromCartUrl

	^ self rootUrl, '/remove-from-cart'! !

!TusLibrosRestInterface methodsFor: 'urls' stamp: 'JD 11/22/2021 13:35:50'!
rootUrl

	^ 'http://localhost:', self port asString! !


!classDefinition: #TusLibrosWindowModel category: 'TusLibros-View'!
Object subclass: #TusLibrosWindowModel
	instanceVariableNames: 'username passwordHash restInterface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-View'!

!TusLibrosWindowModel methodsFor: 'credentials' stamp: 'JD 11/28/2021 02:00:34'!
initialize
	
	restInterface := TusLibrosRestInterface new! !

!TusLibrosWindowModel methodsFor: 'credentials' stamp: 'JD 11/28/2021 01:31:37'!
passwordHash
	
	^ passwordHash! !

!TusLibrosWindowModel methodsFor: 'credentials' stamp: 'JD 11/28/2021 01:31:29'!
usernameText
	
	^ username! !


!TusLibrosWindowModel methodsFor: 'error handling' stamp: 'JD 11/28/2021 04:33:24'!
parseErrorDescription: anErrorDescription
	
	"Esto es muy feo, pero no encontramos una manera de obtener la descripción del error
	que envía el servidor sin el html"
	
	(anErrorDescription includesSubString: '400 Bad Request') 
		ifTrue: [^ anErrorDescription asUnHtml withoutPrefix: '400 Bad Request400 Bad Request']
		ifFalse: [^ anErrorDescription]
	! !

!TusLibrosWindowModel methodsFor: 'error handling' stamp: 'JD 11/28/2021 04:15:49'!
try: aBlock
	
	aBlock
		on: Error
		do: [:anError |
			Transcript clear.
			Transcript show: (self parseErrorDescription: anError messageText).
			TranscriptWindow openTranscript.
		]! !


!classDefinition: #TusLibrosLogInWindowModel category: 'TusLibros-View'!
TusLibrosWindowModel subclass: #TusLibrosLogInWindowModel
	instanceVariableNames: 'password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-View'!

!TusLibrosLogInWindowModel methodsFor: 'create cart' stamp: 'JD 11/28/2021 04:14:43'!
createCart
	
	| aHash256Algorithm cartId |
	
	aHash256Algorithm := SecureHashAlgorithm256 new.
	passwordHash := aHash256Algorithm hashMessage: password asString.
	
	self 
		try: [
			cartId := restInterface sendCreateCartRequestWith: username and: passwordHash.
			self triggerEvent: #newCartCreated with: cartId.
		]
	! !


!TusLibrosLogInWindowModel methodsFor: 'credentials' stamp: 'JD 11/21/2021 22:04:28'!
passwordText
	
	^ password ! !

!TusLibrosLogInWindowModel methodsFor: 'credentials' stamp: 'JD 11/27/2021 23:26:06'!
passwordText: aUserPassword

	password := aUserPassword.
	^ true! !

!TusLibrosLogInWindowModel methodsFor: 'credentials' stamp: 'JD 11/21/2021 22:03:48'!
usernameText: aUsername
	
	username := aUsername.
	^ true! !


!TusLibrosLogInWindowModel methodsFor: 'initialization' stamp: 'JD 11/28/2021 02:00:48'!
initialize
	
	super initialize.	
	username := ''.
	password := ''.! !


!classDefinition: #TusLibrosShopWindowModel category: 'TusLibros-View'!
TusLibrosWindowModel subclass: #TusLibrosShopWindowModel
	instanceVariableNames: 'cartId catalogListIndex itemQuantity cartListIndex catalog cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-View'!

!TusLibrosShopWindowModel methodsFor: 'cart' stamp: 'JD 11/28/2021 04:20:20'!
addToCart

	| books |

	books := catalog keys.
	self
		try: [
			restInterface sendAddToCartRequest: itemQuantity of: (books at: catalogListIndex) to: cartId.
			self triggerEvent: #cartModified
		]
	! !

!TusLibrosShopWindowModel methodsFor: 'cart' stamp: 'JD 11/26/2021 22:45:23'!
cartListIndex
	
	^ cartListIndex! !

!TusLibrosShopWindowModel methodsFor: 'cart' stamp: 'JD 11/26/2021 22:45:35'!
cartListIndex: anIndex
	
	cartListIndex := anIndex! !

!TusLibrosShopWindowModel methodsFor: 'cart' stamp: 'JD 11/28/2021 04:21:40'!
checkoutCart
	
	self try: [
		restInterface sendCheckoutOutCartRequestFor: cartId withCreditCardNumber: '11111111111111' expiringOn: '2/2050' ownedBy: 'Juan'.
		self triggerEvent: #cartCheckouted
	]! !

!TusLibrosShopWindowModel methodsFor: 'cart' stamp: 'JD 11/28/2021 01:57:38'!
listCart

	cart := restInterface sendListCartRequest: cartId.
	^ cart! !

!TusLibrosShopWindowModel methodsFor: 'cart' stamp: 'JD 11/28/2021 04:33:50'!
removeFromCart

	self
		try: [
			| aBookToRemove |
			cartListIndex = 0 ifTrue: [self error: 'Select an item to remove'].
			aBookToRemove := cart at: cartListIndex.
			restInterface sendRemoveFromCartRequest: aBookToRemove from: cartId.
			self triggerEvent: #cartModified
		]! !


!TusLibrosShopWindowModel methodsFor: 'catalog' stamp: 'JD 11/22/2021 21:30:36'!
catalogListIndex
	
	^ catalogListIndex! !

!TusLibrosShopWindowModel methodsFor: 'catalog' stamp: 'JD 11/22/2021 21:30:47'!
catalogListIndex: anIndex
	
	catalogListIndex := anIndex! !

!TusLibrosShopWindowModel methodsFor: 'catalog' stamp: 'JD 11/22/2021 22:39:53'!
itemQuantityText
	
	^ itemQuantity! !

!TusLibrosShopWindowModel methodsFor: 'catalog' stamp: 'JD 11/22/2021 22:41:21'!
itemQuantityText: aQuantity
	
	itemQuantity := aQuantity.
	^ true! !

!TusLibrosShopWindowModel methodsFor: 'catalog' stamp: 'JD 11/28/2021 01:39:52'!
listCatalog

	catalog := restInterface sendListCatalogRequest.
	^ self presentCatalog! !

!TusLibrosShopWindowModel methodsFor: 'catalog' stamp: 'JD 11/28/2021 01:40:05'!
presentCatalog
	
	| presentedCatalog |

	presentedCatalog := OrderedCollection new.
	catalog keysDo: [:aBook |
		| bookPrice |
		bookPrice := catalog at: aBook.
		presentedCatalog add: (aBook, '-', bookPrice asString, '$')
	].
	^ presentedCatalog! !


!TusLibrosShopWindowModel methodsFor: 'initialization' stamp: 'JD 11/28/2021 04:26:23'!
initializeFor: aCartId authenticating: aUsername with: aPasswordHash
	
	super initialize.		
	cartId := aCartId.
	username := aUsername.
	passwordHash := aPasswordHash.
	catalogListIndex := 1.
	cartListIndex := 0.
	itemQuantity := '1'.! !


!TusLibrosShopWindowModel methodsFor: 'purchases' stamp: 'JD 11/28/2021 02:37:40'!
showPurchases

	| purchases totalSpent|

	purchases := restInterface sendListPurchasesRequestFor: username authenticatingWith: passwordHash.
	
	Transcript clear.
	
	purchases isEmpty 
		ifTrue: [Transcript show: 'Your purchases list is empty.']
		ifFalse: 
		[
			totalSpent := 0.
			Transcript show: 'Book', '-', 'Quantity'.
			Transcript newLine.
			purchases keysDo: [:aBook | 
				| bookQuantity bookPrice |
				bookPrice := catalog at: aBook.
				bookQuantity := (purchases at: aBook) / bookPrice.
				totalSpent := totalSpent + bookPrice.
				Transcript show: aBook, '-', bookQuantity asString.
				Transcript newLine.
			].
			Transcript show: 'Total: ', totalSpent asString, '$'.
		 ].

	TranscriptWindow openTranscript.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosShopWindowModel class' category: 'TusLibros-View'!
TusLibrosShopWindowModel class
	instanceVariableNames: ''!

!TusLibrosShopWindowModel class methodsFor: 'as yet unclassified' stamp: 'JD 11/28/2021 01:10:41'!
newFor: aCartId authenticating: aUsername with: aPasswordHash
	^ self new initializeFor: aCartId authenticating: aUsername with: aPasswordHash! !


!classDefinition: #TusLibrosTicketWindowModel category: 'TusLibros-View'!
TusLibrosWindowModel subclass: #TusLibrosTicketWindowModel
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-View'!

!TusLibrosTicketWindowModel methodsFor: 'continue buying' stamp: 'JD 11/28/2021 01:16:51'!
continueBuying
	
	| cartId |

	cartId := restInterface sendCreateCartRequestWith: username and: passwordHash.
	self triggerEvent: #newCartRequested with: cartId! !



!TusLibrosTicketWindowModel methodsFor: 'initialization' stamp: 'JD 11/28/2021 02:01:20'!
initializeFor: aCheckoutedCart authenticating: 	aUsername with: aPasswordHash
	
	super initialize.	
	cart := aCheckoutedCart.
	username := aUsername.
	passwordHash := aPasswordHash.! !


!TusLibrosTicketWindowModel methodsFor: 'logout' stamp: 'JD 11/27/2021 14:01:25'!
logOut
	
	self triggerEvent: #loggedOut! !


!TusLibrosTicketWindowModel methodsFor: 'ticket' stamp: 'JD 11/27/2021 14:06:57'!
listTicket
	
	| cartAsSet cartPrice catalog presentedCart |

	presentedCart := OrderedCollection new.
	cartPrice := 0.
	catalog := restInterface sendListCatalogRequest.
	cartAsSet := cart asSet sorted.
	cartAsSet do: [:aBook | 
		| bookOccurrences |
		
		bookOccurrences := cart occurrencesOf: aBook.
		presentedCart add: (bookOccurrences asString, ' of ', aBook).
		cartPrice := cartPrice + ((catalog at: aBook) * bookOccurrences)
	].
	presentedCart add: ''.
	presentedCart add: 'Cart Total: ', cartPrice asString, '$'.

	^ presentedCart! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosTicketWindowModel class' category: 'TusLibros-View'!
TusLibrosTicketWindowModel class
	instanceVariableNames: ''!

!TusLibrosTicketWindowModel class methodsFor: 'as yet unclassified' stamp: 'JD 11/28/2021 01:10:25'!
newFor: aCheckoutedCart authenticating: 	aUsername with: aPasswordHash
	
	^ self new initializeFor: aCheckoutedCart authenticating: 	aUsername with: aPasswordHash! !
