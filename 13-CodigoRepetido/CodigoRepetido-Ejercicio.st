!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 9/7/2021 18:50:17'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertThatTheExecutionTimeOf: [customerBook addCustomerNamed: 'John Lennon'] tooksLessThan: 50 * millisecond. 
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 9/7/2021 18:50:07'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.

	self assertThatTheExecutionTimeOf: [customerBook removeCustomerNamed: paulMcCartney] tooksLessThan: 100 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 9/7/2021 19:56:29'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self When: [customerBook addCustomerNamed: ''] 
	failedWith: Error 
	verifyTheTruthOf: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 9/7/2021 21:30:42'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self When: [customerBook removeCustomerNamed: 'Paul McCartney'] 
	failedWith: NotFound 
	verifyTheTruthOf: (self anAssertsClosureThatVerifyIfIn: customerBook theUniqueCustomerIs: johnLennon)
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 9/7/2021 20:43:56'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addAndSuspend: paulMcCartney AsCustomerIn: customerBook.

	self assertThatIn: customerBook theNumberOfActiveCustomersIs: 0 theNumberOfSuspendedCustomersIs: 1 andTheNumberOfCustomersIs: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 9/7/2021 20:44:25'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addAndSuspend: paulMcCartney AsCustomerIn: customerBook.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThatIn: customerBook theNumberOfActiveCustomersIs: 0 theNumberOfSuspendedCustomersIs: 0 andTheNumberOfCustomersIs: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 9/7/2021 21:21:00'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self canNotSuspend: 'George Harrison' in: customerBook.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JD 9/7/2021 21:20:45'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	self addAndSuspend: johnLennon AsCustomerIn: customerBook.
	
	self canNotSuspend: johnLennon in: customerBook.

! !


!CustomerBookTest methodsFor: 'asserts' stamp: 'JD 9/7/2021 19:45:55'!
When: aClosure failedWith: anExpectedError verifyTheTruthOf: anAssertsClosure 

	[ aClosure value.
	self fail ]
		on: anExpectedError
		do: [:aRaisedError | anAssertsClosure value: aRaisedError].! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'JD 9/7/2021 21:11:28'!
anAssertsClosureThatVerifyIfIn: aCustomerBook theUniqueCustomerIs: aCustomerName
	^[:anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: aCustomerName) ]! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'JD 9/7/2021 20:43:19'!
assertThatIn: aCustomerBook theNumberOfActiveCustomersIs: aNumberOfActiveCustomers theNumberOfSuspendedCustomersIs: aNumberOfSuspendedCustomers andTheNumberOfCustomersIs: aNumberOfCustomers.

	
	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfCustomers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'JD 9/7/2021 18:47:47'!
assertThatTheExecutionTimeOf: aClosure tooksLessThan: aMilisecondsTimeLimit

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aMilisecondsTimeLimit! !


!CustomerBookTest methodsFor: 'private' stamp: 'JD 9/7/2021 20:20:40'!
addAndSuspend: aCustomerName AsCustomerIn: aCustomerBook 
	aCustomerBook addCustomerNamed: aCustomerName.
	aCustomerBook suspendCustomerNamed: aCustomerName.! !

!CustomerBookTest methodsFor: 'private' stamp: 'JD 9/7/2021 21:23:10'!
canNotSuspend: aCustomerName in: aCustomerBook

	self When: [aCustomerBook suspendCustomerNamed: aCustomerName ] 
		failedWith: CantSuspend
		verifyTheTruthOf: (self anAssertsClosureThatVerifyIfIn: aCustomerBook theUniqueCustomerIs: 'John Lennon')! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'JD 9/7/2021 21:33:48'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'JD 9/7/2021 22:06:51'!
removeCustomerNamed: aName 

	(active includes: aName) ifTrue: [^active remove: aName].
	(suspended includes: aName) ifTrue: [^suspended remove: aName].

	^ NotFound signal
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !
