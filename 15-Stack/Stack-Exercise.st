!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JD 9/18/2021 17:46:17'!
test01CanNotFindASentenceInAnEmptyStack
	
	| anEmptyOOStack aSentenceFinderByPrefix foundSentences |
	
	anEmptyOOStack := OOStack new.
	aSentenceFinderByPrefix := SentenceFinderByPrefix new.
	
	foundSentences _ aSentenceFinderByPrefix findAllSentencesWith: 'something' in: anEmptyOOStack.
	self assert: foundSentences isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JD 9/18/2021 17:46:17'!
test02AllPresentSentencesWithACommonPrefixInTheStackAreFoundSearchingByIt
	
	| anOOStack aSentenceFinderByPrefix foundSentences aSentenceWithCommonPrefix anotherSentenceWithCommonPrefix expectedSentence aSentenceWithDifferentPrefix |
	
	anOOStack := OOStack new.
	aSentenceWithCommonPrefix := 'Something to find'.
	anotherSentenceWithCommonPrefix := 'Somewhere in Argentina'.
	aSentenceWithDifferentPrefix := 'Sentence with different prefix'.
	anOOStack push: aSentenceWithCommonPrefix.
	anOOStack push: aSentenceWithDifferentPrefix.
	anOOStack push: anotherSentenceWithCommonPrefix.
	aSentenceFinderByPrefix := SentenceFinderByPrefix new.
	
	foundSentences := aSentenceFinderByPrefix findAllSentencesWith: 'Some' in: anOOStack.
	
	expectedSentence := OrderedCollection with: aSentenceWithCommonPrefix with: anotherSentenceWithCommonPrefix.
	self assert: (foundSentences isEqualTo: expectedSentence)! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JD 9/18/2021 17:46:17'!
test03NoneSentenceIsFoundSearchingByAWordNotPrefixOfAnySentenceInTheStack
	
	| anOOStack aSentenceFinderByPrefix foundSentences aSentence |
	
	anOOStack := OOStack new.
	aSentence := 'Something to find'.
	anOOStack push: aSentence.
	aSentenceFinderByPrefix := SentenceFinderByPrefix new.
	
	foundSentences := aSentenceFinderByPrefix findAllSentencesWith: 'aNotPrefix' in: anOOStack.
	
	self assert: foundSentences isEmpty! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'JD 9/18/2021 17:59:25'!
initialize

	content := OrderedCollection new! !


!OOStack methodsFor: 'operations' stamp: 'JD 9/18/2021 18:03:41'!
pop

	^ self state popForCurrentStateOf: self! !

!OOStack methodsFor: 'operations' stamp: 'JD 9/18/2021 16:07:18'!
push: anElement

	content addFirst: anElement! !

!OOStack methodsFor: 'operations' stamp: 'JD 9/17/2021 18:53:44'!
size
	
	^ content size! !

!OOStack methodsFor: 'operations' stamp: 'JD 9/18/2021 18:03:52'!
top

	^ self state topForCurrentStateOf: self! !


!OOStack methodsFor: 'testing' stamp: 'JD 9/17/2021 18:47:32'!
isEmpty
	
	^ content isEmpty.! !


!OOStack methodsFor: 'operations - private' stamp: 'JD 9/18/2021 16:21:07'!
popOnANotEmptyOOStack

	^ content removeFirst! !

!OOStack methodsFor: 'operations - private' stamp: 'JD 9/17/2021 20:14:13'!
popOnAnEmptyOOStack
	
	self error: self class stackEmptyErrorDescription! !

!OOStack methodsFor: 'operations - private' stamp: 'JD 9/18/2021 17:56:11'!
state

	| anOOStackCurrentState |
	
	anOOStackCurrentState := (OOStackState for: self) new.

	^ anOOStackCurrentState! !

!OOStack methodsFor: 'operations - private' stamp: 'JD 9/17/2021 20:18:08'!
topOnANotEmptyOOStack
	
	^ content first! !

!OOStack methodsFor: 'operations - private' stamp: 'JD 9/17/2021 20:17:48'!
topOnAnEmptyOOStack
	
	self error: self class stackEmptyErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackState category: 'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: 'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'as yet unclassified' stamp: 'JD 9/18/2021 17:56:41'!
for: anOOStack
	
	| targetSubclass |
	
	targetSubclass := self subclasses detect: [:anOOStackStateSubclass |  anOOStackStateSubclass isFor: anOOStack].
	
	^ targetSubclass! !


!classDefinition: #OOStackStateEmpty category: 'Stack-Exercise'!
OOStackState subclass: #OOStackStateEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateEmpty methodsFor: 'operation dispatchers' stamp: 'JD 9/18/2021 18:04:37'!
popForCurrentStateOf: anOOStack
	
	^ anOOStack popOnAnEmptyOOStack
		! !

!OOStackStateEmpty methodsFor: 'operation dispatchers' stamp: 'JD 9/18/2021 18:04:41'!
topForCurrentStateOf: anOOStack
	
	^ anOOStack topOnAnEmptyOOStack
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateEmpty class' category: 'Stack-Exercise'!
OOStackStateEmpty class
	instanceVariableNames: ''!

!OOStackStateEmpty class methodsFor: 'as yet unclassified' stamp: 'JD 9/18/2021 17:56:53'!
isFor: anOOStack
	
	^ anOOStack size = 0! !


!classDefinition: #OOStackStateNotEmpty category: 'Stack-Exercise'!
OOStackState subclass: #OOStackStateNotEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateNotEmpty methodsFor: 'operation dispatchers' stamp: 'JD 9/18/2021 18:04:48'!
popForCurrentStateOf: anOOStack

	^ anOOStack popOnANotEmptyOOStack! !

!OOStackStateNotEmpty methodsFor: 'operation dispatchers' stamp: 'JD 9/18/2021 18:04:53'!
topForCurrentStateOf: anOOStack

	^ anOOStack topOnANotEmptyOOStack! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateNotEmpty class' category: 'Stack-Exercise'!
OOStackStateNotEmpty class
	instanceVariableNames: ''!

!OOStackStateNotEmpty class methodsFor: 'as yet unclassified' stamp: 'JD 9/18/2021 17:57:06'!
isFor: anOOStack
	
	^ anOOStack size > 0! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'JD 9/18/2021 18:11:57'!
findSentencesWithPrefix: aString preserving: anOOStack in: anOOStackForPreservingElements
	
	| foundSentences aSentence |

	foundSentences := OrderedCollection new.
	
	[anOOStack isEmpty not] whileTrue: 
		[
			 aSentence := anOOStack pop.
			(aSentence beginsWith: aString) ifTrue: [foundSentences addFirst: aSentence].
			anOOStackForPreservingElements push: aSentence.
		].
	
	^ foundSentences.
	
	 ! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'JD 9/18/2021 17:29:28'!
restoreStack: anOOStack from: xOOStack
	
	| aSentence |

	[xOOStack isEmpty not] whileTrue: 
		[
			 aSentence := xOOStack pop.
			anOOStack push: aSentence.
		]
	
	 ! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'JD 9/18/2021 18:11:41'!
findAllSentencesWith: aPrefix in: anOOStackOfSentences 
	
	| anOOStackForPreservingElements foundSentences |
	
	anOOStackForPreservingElements := OOStack new.
	foundSentences := OrderedCollection new.
	
	foundSentences := self findSentencesWithPrefix: aPrefix preserving: anOOStackOfSentences in: anOOStackForPreservingElements.
	self restoreStack: anOOStackOfSentences from: anOOStackForPreservingElements.

	^ foundSentences
	
	 ! !
