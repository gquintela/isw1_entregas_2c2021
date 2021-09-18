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

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 21:17:48'!
test01CanNotFindASentenceInAnEmptyStack
	
	| anEmptyOOStack aSentenceFinderByPrefix foundSentences |
	
	anEmptyOOStack := OOStack new.
	aSentenceFinderByPrefix := SentenceFinderByPrefix new.
	
	foundSentences _ aSentenceFinderByPrefix find: 'something' in: anEmptyOOStack.
	self assert: foundSentences isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 21:52:09'!
test02APresentSentenceInTheStackIsFoundSearchingByAPrefixOfIt
	
	| anOOStack aSentenceFinderByPrefix foundSentences aSentence expectedSentence |
	
	anOOStack := OOStack new.
	aSentence := 'Something to find'.
	anOOStack push: aSentence.
	aSentenceFinderByPrefix := SentenceFinderByPrefix new.
	
	foundSentences := aSentenceFinderByPrefix find: 'Some' in: anOOStack.
	
	expectedSentence := OrderedCollection with: aSentence.
	self assert: (foundSentences isEqualTo: expectedSentence)! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'content state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 18:58:10'!
initialize

	content := OrderedCollection new.
	state := OOStackStateEmpty new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 18:47:32'!
isEmpty
	
	^ content isEmpty.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:05:55'!
pop

	^ state pop: self.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:23:57'!
popOnANotEmptyOOStack
	
	content size = 1 ifTrue: [ state := OOStackStateEmpty new].
	^ content removeFirst! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:14:13'!
popOnAnEmptyOOStack
	
	self error: self class stackEmptyErrorDescription! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:22:01'!
push: anElement

	state push: anElement on: self.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:20:13'!
pushOnANotEmptyOOStack: anElement
	
	content addFirst: anElement! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:24:04'!
pushOnAnEmptyOOStack: anElement
	
	state := OOStackStateNotEmpty new.
	content addFirst: anElement! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 18:53:44'!
size
	
	^ content size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 19:38:08'!
top
	
	^ state top: self! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:18:08'!
topOnANotEmptyOOStack
	
	^ content first! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:17:48'!
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


!classDefinition: #OOStackStateEmpty category: 'Stack-Exercise'!
OOStackState subclass: #OOStackStateEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 19:10:03'!
isEmptyState
	
	^ true! !

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:14:13'!
pop: aOOStack
	
	^ aOOStack popOnAnEmptyOOStack
		! !

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:16:18'!
push: anElement on: aOOStack 
	
	^ aOOStack pushOnAnEmptyOOStack: anElement
		! !

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:17:48'!
top: aOOStack
	
	^ aOOStack topOnAnEmptyOOStack
		! !


!classDefinition: #OOStackStateNotEmpty category: 'Stack-Exercise'!
OOStackState subclass: #OOStackStateNotEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateNotEmpty methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 19:10:13'!
isEmptyState
	
	^ false! !

!OOStackStateNotEmpty methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:15:44'!
pop: aOOStack

	^ aOOStack popOnANotEmptyOOStack! !

!OOStackStateNotEmpty methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:17:20'!
push: anElement on: aOOStack 
	
	^ aOOStack pushOnANotEmptyOOStack: anElement! !

!OOStackStateNotEmpty methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 20:18:08'!
top: aOOStack

	^ aOOStack topOnANotEmptyOOStack! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'JD 9/17/2021 21:13:35'!
find: aString in: anOOStack 
	
	| xOOStack foundSentences aSentence |
	
	xOOStack := OOStack new.
	foundSentences := OrderedCollection new.
	
	[anOOStack isEmpty not] whileTrue: 
		[
			 aSentence := anOOStack pop.
			(aSentence beginsWith: aString) ifTrue: [foundSentences addLast: aSentence].
			xOOStack push: aSentence.
		].
	
	[xOOStack isEmpty not] whileTrue: 
		[
			 aSentence := xOOStack pop.
			anOOStack push: aSentence.
		].
	
	^ foundSentences.
	
	 ! !
