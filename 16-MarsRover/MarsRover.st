!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/4/2021 20:45:52'!
test01

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 17:20:32'!
test02

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 17:26:33'!
test03

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 17:27:38'!
test04

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #West).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 17:29:37'!
test05

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #East).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 17:31:51'!
test06

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 17:37:52'!
test07

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #East).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 17:44:38'!
test08

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #South).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 17:52:37'!
test09

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #South).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 17:55:34'!
test10

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #West).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 17:58:54'!
test11

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 18:02:09'!
test12

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 0@2 heading: #West).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 18:06:34'!
test13

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: #East).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 18:08:48'!
test14

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@1 heading: #South).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 18:12:44'!
test15

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@2 heading: #East).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentCoordinate currentDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'gq 10/4/2021 22:03:55'!
isAt: aCoordinate heading: aDirection 
	^currentCoordinate = aCoordinate and: [currentDirection = aDirection ]! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 18:15:44'!
process: aSequenceOfCommands
	
	
	
	aSequenceOfCommands = 'f' ifTrue: [
		currentDirection = #North ifTrue: [currentCoordinate := currentCoordinate + (0@1)].
		currentDirection = #East ifTrue: [currentCoordinate := currentCoordinate + (1@0)].
		currentDirection = #South ifTrue: [currentCoordinate := currentCoordinate + (0@-1)].
		currentDirection = #West ifTrue: [currentCoordinate := currentCoordinate + (-1@0)] 
		].
	aSequenceOfCommands = 'b' ifTrue: [
		currentDirection = #East ifTrue: [currentCoordinate := currentCoordinate + (-1@0)].
		currentDirection = #North ifTrue: [currentCoordinate := currentCoordinate + (0@-1)]
		].
	aSequenceOfCommands = 'l' ifTrue: [self rotateLeft].
	aSequenceOfCommands = 'r' ifTrue: [self rotateRight].
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 17:49:17'!
rotateLeft

	|aNewDirection|
		currentDirection = #East
			ifTrue: [aNewDirection := #North].
		currentDirection = #South
			ifTrue: [aNewDirection := #East].		
		currentDirection = #North
			ifTrue: [aNewDirection := #West].
		currentDirection = #West
			ifTrue: [aNewDirection := #South].
		currentDirection := aNewDirection! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'gq 10/5/2021 17:59:31'!
rotateRight

	|aNewDirection|
		currentDirection = #East ifTrue: [aNewDirection := #South].
		currentDirection = #South ifTrue: [aNewDirection := #West].
		currentDirection = #North ifTrue: [aNewDirection := #East].
		currentDirection = #West ifTrue: [aNewDirection := #North].
		
		currentDirection := aNewDirection! !


!MarsRover methodsFor: 'initialization' stamp: 'gq 10/4/2021 22:02:46'!
initializeAt: anInitialCoordinate heading: anInitialDirection 
	
	currentCoordinate := anInitialCoordinate.
	currentDirection := anInitialDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'gq 10/4/2021 21:59:34'!
at: anInitialCoordinate heading: anInitialDirection 

	|aMarsRover|

	aMarsRover := self new.

	aMarsRover initializeAt: anInitialCoordinate heading: anInitialDirection.
	
	^aMarsRover 	! !
