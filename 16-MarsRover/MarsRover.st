!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'movements' stamp: 'FR 10/5/2021 21:25:36'!
test02CanMoveOneUnitForwardAMarsRoverHeadingNorth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover moveBy: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: North).! !

!MarsRoverTest methodsFor: 'movements' stamp: 'FR 10/5/2021 21:25:30'!
test03CanMoveOneUnitBackwardAMarsRoverHeadingNorth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover moveBy: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: North).! !

!MarsRoverTest methodsFor: 'movements' stamp: 'FR 10/5/2021 21:33:29'!
test12CanMoveOneUnitForwardAMarsRoverHeadingWest

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: West new.
	
	marsRover moveBy: 'f'.
	
	self assert: (marsRover isAt: 0@2 heading: West).! !

!MarsRoverTest methodsFor: 'movements' stamp: 'FR 10/5/2021 21:33:22'!
test13CanMoveOneUnitForwardAMarsRoverHeadingEast

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: East new.
	
	marsRover moveBy: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: East).! !

!MarsRoverTest methodsFor: 'movements' stamp: 'FR 10/5/2021 21:33:11'!
test14CanMoveOneUnitForwardAMarsRoverHeadingSouth

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: South new.
	
	marsRover moveBy: 'f'.
	
	self assert: (marsRover isAt: 1@1 heading: South).! !

!MarsRoverTest methodsFor: 'movements' stamp: 'FR 10/5/2021 21:34:22'!
test15CanMoveOneUnitBackwardAMarsRoverHeadingEast

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: East new.
	
	marsRover moveBy: 'b'.
	
	self assert: (marsRover isAt: 0@2 heading: East).! !

!MarsRoverTest methodsFor: 'movements' stamp: 'FR 10/5/2021 21:34:39'!
test16CanMoveOneUnitBackwardAMarsRoverHeadingSouth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: South new.
	
	marsRover moveBy: 'b'.
	
	self assert: (marsRover isAt: 1@3 heading: South).! !

!MarsRoverTest methodsFor: 'movements' stamp: 'FR 10/5/2021 21:35:20'!
test17CanMoveOneUnitBackwardAMarsRoverHeadingWest

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: West new.
	
	marsRover moveBy: 'b'.
	
	self assert: (marsRover isAt: 2@2 heading: West).! !

!MarsRoverTest methodsFor: 'movements' stamp: 'FR 10/5/2021 21:36:18'!
test18CanMoveTwoUnitsForwardAMarsRoverHeadingNorth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover moveBy: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: North).! !

!MarsRoverTest methodsFor: 'movements' stamp: 'FR 10/5/2021 21:37:16'!
test19CanMoveTwoUnitsBackwardAMarsRoverHeadingNorth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover moveBy: 'bb'.
	
	self assert: (marsRover isAt: 1@0 heading: North).! !


!MarsRoverTest methodsFor: 'rotations' stamp: 'FR 10/5/2021 21:25:25'!
test04CanRotateLeftAMarsRoverHeadingNorth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover moveBy: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: West).! !

!MarsRoverTest methodsFor: 'rotations' stamp: 'FR 10/5/2021 21:25:20'!
test05CanRotateRightAMarsRoverHeadingNorth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover moveBy: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: East).! !

!MarsRoverTest methodsFor: 'rotations' stamp: 'FR 10/5/2021 21:25:14'!
test06CanRotateLeftAMarsRoverHeadingEast

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: East new.
	
	marsRover moveBy: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: North).! !

!MarsRoverTest methodsFor: 'rotations' stamp: 'FR 10/5/2021 21:25:10'!
test07CanRotateLeftAMarsRoverHeadingSouth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: South new.
	
	marsRover moveBy: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: East).! !

!MarsRoverTest methodsFor: 'rotations' stamp: 'FR 10/5/2021 21:26:28'!
test08CanRotateLeftAMarsRoverHeadingWest

	| marsRover|
	
	marsRover := MarsRover at: 1@2 heading: West new.
	
	marsRover moveBy: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: South).! !

!MarsRoverTest methodsFor: 'rotations' stamp: 'FR 10/5/2021 21:27:02'!
test09CanRotateRightAMarsRoverHeadingEast

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: East new.
	
	marsRover moveBy: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: South).! !

!MarsRoverTest methodsFor: 'rotations' stamp: 'FR 10/5/2021 21:27:33'!
test10CanRotateRightAMarsRoverHeadingSouth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: South new.
	
	marsRover moveBy: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: West).! !

!MarsRoverTest methodsFor: 'rotations' stamp: 'FR 10/5/2021 21:27:55'!
test11CanRotateRightAMarsRoverHeadingWest

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: West new.
	
	marsRover moveBy: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: North).! !

!MarsRoverTest methodsFor: 'rotations' stamp: 'FR 10/5/2021 21:37:57'!
test20CanRotateTwiceToLeftAMarsRoverHeadingNorth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover moveBy: 'll'.
	
	self assert: (marsRover isAt: 1@2 heading: South).! !

!MarsRoverTest methodsFor: 'rotations' stamp: 'FR 10/5/2021 21:38:20'!
test21CanRotateTwiceToRightAMarsRoverHeadingNorth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover moveBy: 'rr'.
	
	self assert: (marsRover isAt: 1@2 heading: South).! !


!MarsRoverTest methodsFor: 'movements and rotations' stamp: 'FR 10/5/2021 21:12:48'!
test01AnEmptySequenceOfCommandsDoesNotMoveTheMarsRover

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover moveBy: ''.
	
	self assert: (marsRover isAt: 1@2 heading: North).! !

!MarsRoverTest methodsFor: 'movements and rotations' stamp: 'FR 10/5/2021 21:39:30'!
test22CanMoveAndRotateAMarsRoverHeadingNorth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover moveBy: 'fl'.
	
	self assert: (marsRover isAt: 1@3 heading: West).! !

!MarsRoverTest methodsFor: 'movements and rotations' stamp: 'FR 10/5/2021 23:03:46'!
test23CanMoveAndRotateWhileThereAreNotInvalidCommands

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover moveBy: 'ffrprr'.
	
	self assert: (marsRover isAt: 1@4 heading: East).! !


!classDefinition: #CardinalPoint category: 'MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'rotation' stamp: 'FR 10/5/2021 20:51:34'!
rotateLeft: aMarsRover

	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'rotation' stamp: 'FR 10/5/2021 20:51:28'!
rotateRight: aMarsRover

	self subclassResponsibility ! !


!CardinalPoint methodsFor: 'movement' stamp: 'FR 10/5/2021 20:11:26'!
moveBackward: aMarsRover

	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'movement' stamp: 'FR 10/5/2021 20:39:32'!
moveForward: aMarsRover

	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'rotation' stamp: 'FR 10/5/2021 20:48:15'!
rotateLeft: aMarsRover

	aMarsRover rotateToNorth ! !

!East methodsFor: 'rotation' stamp: 'FR 10/5/2021 20:51:15'!
rotateRight: aMarsRover

	aMarsRover rotateToSouth ! !


!East methodsFor: 'movement' stamp: 'FR 10/5/2021 20:11:58'!
moveBackward: aMarsRover

	aMarsRover moveWest! !

!East methodsFor: 'movement' stamp: 'FR 10/5/2021 20:40:07'!
moveForward: aMarsRover

	aMarsRover moveEast! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'rotation' stamp: 'FR 10/5/2021 20:48:39'!
rotateLeft: aMarsRover

	aMarsRover rotateToWest! !

!North methodsFor: 'rotation' stamp: 'FR 10/5/2021 20:51:05'!
rotateRight: aMarsRover

	aMarsRover rotateToEast ! !


!North methodsFor: 'movement' stamp: 'FR 10/5/2021 20:12:43'!
moveBackward: aMarsRover

	aMarsRover moveSouth! !

!North methodsFor: 'movement' stamp: 'FR 10/5/2021 20:40:55'!
moveForward: aMarsRover

	aMarsRover moveNorth! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'rotation' stamp: 'FR 10/5/2021 20:48:51'!
rotateLeft: aMarsRover

	aMarsRover rotateToEast ! !

!South methodsFor: 'rotation' stamp: 'FR 10/5/2021 20:50:54'!
rotateRight: aMarsRover

	aMarsRover rotateToWest ! !


!South methodsFor: 'movement' stamp: 'FR 10/5/2021 20:13:05'!
moveBackward: aMarsRover

	aMarsRover moveNorth! !

!South methodsFor: 'movement' stamp: 'FR 10/5/2021 20:41:07'!
moveForward: aMarsRover

	aMarsRover moveSouth! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'rotation' stamp: 'FR 10/5/2021 20:49:06'!
rotateLeft: aMarsRover

	aMarsRover rotateToSouth ! !

!West methodsFor: 'rotation' stamp: 'FR 10/5/2021 20:50:31'!
rotateRight: aMarsRover

	aMarsRover rotateToNorth ! !


!West methodsFor: 'movement' stamp: 'FR 10/5/2021 20:13:23'!
moveBackward: aMarsRover

	aMarsRover moveEast! !

!West methodsFor: 'movement' stamp: 'FR 10/5/2021 20:41:20'!
moveForward: aMarsRover

	aMarsRover moveWest! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentCoordinate currentDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'gq 10/4/2021 22:02:46'!
initializeAt: anInitialCoordinate heading: anInitialDirection 
	
	currentCoordinate := anInitialCoordinate.
	currentDirection := anInitialDirection.! !


!MarsRover methodsFor: 'movement - private' stamp: 'FR 10/5/2021 20:38:56'!
moveBackward
		
		currentDirection moveBackward: self
	! !

!MarsRover methodsFor: 'movement - private' stamp: 'FR 10/5/2021 19:23:27'!
moveEast

	currentCoordinate := currentCoordinate + (1@0)! !

!MarsRover methodsFor: 'movement - private' stamp: 'FR 10/5/2021 20:41:48'!
moveForward

		currentDirection moveForward: self! !

!MarsRover methodsFor: 'movement - private' stamp: 'FR 10/5/2021 19:23:31'!
moveNorth

	currentCoordinate := currentCoordinate + (0@1)! !

!MarsRover methodsFor: 'movement - private' stamp: 'FR 10/5/2021 19:23:35'!
moveSouth

	currentCoordinate := currentCoordinate + (0@-1)! !

!MarsRover methodsFor: 'movement - private' stamp: 'FR 10/5/2021 19:23:40'!
moveWest

	currentCoordinate := currentCoordinate + (-1@0)! !


!MarsRover methodsFor: 'process commands' stamp: 'FR 10/5/2021 23:10:22'!
moveBy: aSequenceOfCommands
	
		aSequenceOfCommands do: [ :aCommand | 
			(self isValid: aCommand) ifFalse: [^nil].
			self moveByAValidCommand: aCommand.
		]
! !


!MarsRover methodsFor: 'process commands - private' stamp: 'FR 10/5/2021 23:09:48'!
moveByAValidCommand: aValidCommand

	aValidCommand = $f ifTrue: [self moveForward].
	aValidCommand = $b ifTrue: [self moveBackward].
	aValidCommand = $l ifTrue: [self rotateLeft].
	aValidCommand = $r ifTrue: [self rotateRight].! !

!MarsRover methodsFor: 'process commands - private' stamp: 'FR 10/5/2021 22:17:01'!
validCommands

	^ OrderedCollection with: $f with: $b with: $l with: $r! !


!MarsRover methodsFor: 'rotation - private' stamp: 'FR 10/5/2021 20:49:47'!
rotateLeft

		currentDirection rotateLeft: self! !

!MarsRover methodsFor: 'rotation - private' stamp: 'FR 10/5/2021 20:51:56'!
rotateRight

	currentDirection rotateRight: self! !

!MarsRover methodsFor: 'rotation - private' stamp: 'FR 10/5/2021 20:46:00'!
rotateToEast

		currentDirection := East new! !

!MarsRover methodsFor: 'rotation - private' stamp: 'FR 10/5/2021 20:45:26'!
rotateToNorth

		currentDirection := North new! !

!MarsRover methodsFor: 'rotation - private' stamp: 'FR 10/5/2021 20:45:43'!
rotateToSouth

		currentDirection := South new! !

!MarsRover methodsFor: 'rotation - private' stamp: 'FR 10/5/2021 20:45:51'!
rotateToWest

		currentDirection := West new! !


!MarsRover methodsFor: 'testing' stamp: 'FR 10/5/2021 20:52:17'!
isAt: aCoordinate heading: aDirection 

	^currentCoordinate = aCoordinate and: [currentDirection class = aDirection ]! !

!MarsRover methodsFor: 'testing' stamp: 'FR 10/5/2021 22:07:49'!
isValid: aCommand

	^ self validCommands includes: aCommand ! !

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
