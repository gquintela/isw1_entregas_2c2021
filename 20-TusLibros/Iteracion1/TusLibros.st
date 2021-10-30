!classDefinition: #TusLibrosTest category: 'TusLibros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 20:56:59'!
aBook

	^'ISBN_1'! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 20:57:03'!
anotherBook

	^'ISBN_2'! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 20:44:38'!
assertThatAdd: aBookToAdd withAQuantityOf: aBookToAddQuantity to: aCart shouldRaiseErrorWithDescription: anErrorDescription

	self 
		should: [aCart addToCart: aBookToAdd quantity: aBookToAddQuantity]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anException | anException = anErrorDescription ].! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 21:06:04'!
assertThatAddABookWithAQuantityOf: aBookToAddQuantity to: aCart shouldRaiseErrorWithDescription: anErrorDescription

	self 
		should: [aCart addToCart: self aBook quantity: aBookToAddQuantity]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anException | anException = anErrorDescription ].! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 21:15:53'!
createACartOfTusLibrosWithACatalogWithABook

	^ self createACartOfTusLibrosWithCatalog: self createACatalogWithABook
	
	! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 20:29:41'!
createACartOfTusLibrosWithCatalog: aCatalog

	| tusLibros |
	
	tusLibros := TusLibros with: aCatalog.
	
	^tusLibros createCart.! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 20:38:23'!
createACatalogWith: aBookInTheCatalogToAdd

	^ OrderedCollection with: aBookInTheCatalogToAdd! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 20:54:18'!
createACatalogWith: aBookToAdd with: anotherBookToAdd

	^ OrderedCollection with: aBookToAdd with: anotherBookToAdd! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 21:08:33'!
createACatalogWithABook

	^ OrderedCollection with: self aBook ! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 21:11:25'!
createACatalogWithTwoDifferentBooks

	^ OrderedCollection with: self aBook with: self anotherBook ! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 20:37:11'!
createAnEmptyCatalog

	^ OrderedCollection new! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 20:37:11'!
test01ANewCartIsEmpty

	| anEmptyCart |
	
	anEmptyCart := self createACartOfTusLibrosWithCatalog: self createAnEmptyCatalog.
	
	self assert: anEmptyCart isEmpty! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 21:16:53'!
test02CanAddABookFromTheCatalogToTheCart

	| aCart |

	aCart := self createACartOfTusLibrosWithACatalogWithABook.

	aCart addToCart: self aBook quantity: 1.
	
	self assert: (aCart includes: self aBook).
	self deny: aCart isEmpty! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 21:06:22'!
test03CannotAddABookNotPresentInTheCatalogToTheCart

	| anEmptyCart |
	
	anEmptyCart := self createACartOfTusLibrosWithCatalog: self createAnEmptyCatalog.
		
	self assertThatAddABookWithAQuantityOf: 1 to: anEmptyCart shouldRaiseErrorWithDescription: Cart errorMessageCannotAddABookNotPresentInTheCatalog.
	self deny: (anEmptyCart includes: self aBook)! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 21:16:14'!
test04CanAddManyBooksCopiesFromTheCatalogToTheCart

	| aCart  |

	aCart := self createACartOfTusLibrosWithACatalogWithABook.
	
	aCart addToCart: self aBook quantity: 5.
	
	self assert: 5 equals: (aCart occurrencesOf: self aBook).! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 21:20:09'!
test05CannotAddANonPositiveBookQuantity

	| anEmptyCart |
	
	anEmptyCart := self createACartOfTusLibrosWithACatalogWithABook.

	self assertThatAddABookWithAQuantityOf: -6 to: anEmptyCart shouldRaiseErrorWithDescription: Cart errorMessageCannotAddANonPositiveBookQuantity.
	self deny: (anEmptyCart includes: self aBook)! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 21:19:50'!
test06CanListAnEmptyCart

	| anEmptyCart |
	
	anEmptyCart := self createACartOfTusLibrosWithCatalog: self createAnEmptyCatalog.
	
	self assert: '' equals: anEmptyCart listCart
	
	! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'gq 10/29/2021 21:19:58'!
test07CanListBooksFromACart

	| aCart aCatalog |
	
	aCatalog := self createACatalogWithTwoDifferentBooks.
	aCart := self createACartOfTusLibrosWithCatalog: aCatalog.
	aCart addToCart: self aBook quantity: 1.
	aCart addToCart: self anotherBook quantity: 2.
	
	self assert: '|',self aBook,'|1|',self anotherBook,'|2' equals: aCart listCart
	
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'gq 10/29/2021 20:27:02'!
initializeFor: aCatalog 
	
	catalog := aCatalog.
	contents := Dictionary new.! !


!Cart methodsFor: 'exceptions' stamp: 'gq 10/29/2021 20:22:47'!
raiseErrorCannotAddABookNotPresentInTheCatalog

	^ self error: Cart errorMessageCannotAddABookNotPresentInTheCatalog! !

!Cart methodsFor: 'exceptions' stamp: 'gq 10/29/2021 20:19:08'!
raiseErrorCannotAddANonPositiveBookQuantity

	^ self error: Cart errorMessageCannotAddANonPositiveBookQuantity! !


!Cart methodsFor: 'accessing' stamp: 'gq 10/29/2021 20:14:18'!
listCart
	
	|aBookList|
	
	aBookList := ''.
	contents keysDo: [:aBook |
		aBookList := aBookList,'|',aBook,'|',(contents at: aBook) asString
	].

	^aBookList! !

!Cart methodsFor: 'accessing' stamp: 'gq 10/29/2021 19:50:43'!
occurrencesOf: aBook

	^contents at: aBook ! !


!Cart methodsFor: 'testing' stamp: 'gq 10/29/2021 19:50:43'!
includes: aBook 

	^ contents includesKey: aBook! !

!Cart methodsFor: 'testing' stamp: 'gq 10/29/2021 19:50:43'!
isEmpty
	
	^ contents isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'gq 10/29/2021 20:22:47'!
addToCart: aBookToAdd quantity: aBookToAddQuantity

	self assert: (catalog includes: aBookToAdd) description: [self raiseErrorCannotAddABookNotPresentInTheCatalog].
	self assert: (aBookToAddQuantity > 0) description: [self raiseErrorCannotAddANonPositiveBookQuantity].
	contents at: aBookToAdd put: aBookToAddQuantity 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'gq 10/29/2021 18:48:47'!
with: aCatalog

	^self new initializeFor: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'gq 10/29/2021 18:59:59'!
errorMessageCannotAddABookNotPresentInTheCatalog
	
	^'Cannot add a book not present in the catalog.'! !

!Cart class methodsFor: 'error messages' stamp: 'gq 10/29/2021 20:18:52'!
errorMessageCannotAddANonPositiveBookQuantity
	
	^'Cannot add a non positive book quantity.'! !


!classDefinition: #TusLibros category: 'TusLibros'!
Object subclass: #TusLibros
	instanceVariableNames: 'catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibros methodsFor: 'initialization' stamp: 'FR 10/28/2021 21:19:49'!
initializeWith: aCatalog 
	
	catalog := aCatalog.! !


!TusLibros methodsFor: 'cart creation' stamp: 'gq 10/29/2021 19:15:49'!
createCart

	^Cart with: catalog! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibros class' category: 'TusLibros'!
TusLibros class
	instanceVariableNames: ''!

!TusLibros class methodsFor: 'instance creation' stamp: 'FR 10/28/2021 21:19:03'!
with: aCatalog 

	^ self new initializeWith: aCatalog ! !
