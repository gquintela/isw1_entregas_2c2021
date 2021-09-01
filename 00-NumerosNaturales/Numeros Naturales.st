!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 17:23:15'!
* aNaturalNumber

	^aNaturalNumber! !

!I class methodsFor: 'as yet unclassified' stamp: 'JD 8/29/2021 23:43:51'!
+ aNaturalNumber

	^aNaturalNumber next! !

!I class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 17:40:12'!
- aNaturalNumber

	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 17:39:49'!
/ aNaturalNumber

	aNaturalNumber = I ifTrue: [^I].
	self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 18:08:13'!
> aNaturalNumber

	^false.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 17:41:17'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JD 8/31/2021 22:37:16'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Números negativos no soportados'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JD 8/31/2021 20:00:06'!
hasPrevious
	
	^False.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JD 8/31/2021 20:25:12'!
minusSwap: aNaturalNumber
	
	^aNaturalNumber previous.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JD 8/29/2021 23:40:43'!
next
	
	^II.! !



!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 18:23:39'!
* aNaturalNumber
	
	^(self previous * aNaturalNumber) + aNaturalNumber.
! !

!II class methodsFor: 'as yet unclassified' stamp: 'JD 8/30/2021 00:25:42'!
+ aNaturalNumber
	
	^self previous + aNaturalNumber next! !

!II class methodsFor: 'as yet unclassified' stamp: 'JD 8/31/2021 20:28:44'!
- aNaturalNumber
	
	'(aNaturalNumber hasPrevious) ifTrue: [^self previous]'.
	'^self previous - aNaturalNumber previous'.
	^aNaturalNumber minusSwap: self.
! !

!II class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 18:09:41'!
/ aNaturalNumber
	(aNaturalNumber > self) ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	self = aNaturalNumber ifTrue: [^I].
	^((self - aNaturalNumber) / aNaturalNumber) + I.
! !

!II class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 18:07:55'!
> aNaturalNumber
	
	aNaturalNumber = I ifTrue: [^true].
	^self previous > aNaturalNumber previous.
! !

!II class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 18:10:10'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 18:08:33'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	self shouldBeImplemented.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JD 8/31/2021 20:00:22'!
hasPrevious

	^True.
! !

!II class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 18:34:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JD 8/31/2021 20:26:41'!
minusSwap: aNaturalNumber	
	
	^self previous minusSwap: aNaturalNumber previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JD 8/30/2021 00:28:25'!
next

	next ifNotNil: [^next].	
	next _ II createChildNamed: self name, 'I'.
	next previous: self.
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JD 8/30/2021 00:35:27'!
previous

	^previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JD 8/30/2021 00:35:31'!
previous: aNaturalNumber

	previous _ aNaturalNumber! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 18:34:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 18:34:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Numeros Naturales'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numeros Naturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 18:34:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Numeros Naturales'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Numeros Naturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'JD 9/1/2021 18:34:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!