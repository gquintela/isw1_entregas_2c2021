Al cargar la imágen debería haber un workspace abierto con el siguiente contenido:

	"--------------------- Tus Libros ---------------------"

	| aHash256Algorithm credentials catalog clock |
	
	aHash256Algorithm := SecureHashAlgorithm256 new.
	
	credentials := Dictionary new.
	credentials at: 'Juan' put: (aHash256Algorithm hashMessage: '1234') asString.
	credentials at: 'Pedro' put: (aHash256Algorithm hashMessage: '12345') asString.
	credentials at: 'Ana' put: (aHash256Algorithm hashMessage: '123456') asString.
	
	catalog := Dictionary new.
	catalog at: 'Book1' put: 10.
	catalog at: 'Book2' put: 12.
	catalog at: 'Book3' put: 20.
	catalog at: 'Book4' put: 5.
	catalog at: 'Book5' put: 30.
	
	clock := ManualClock now: DateAndTime now.

	TusLibrosServer listeningOn: 8080 authenticatingWith: credentials acceptingItemsOf: catalog registeringOn: (OrderedCollection new) debitingThrought: (MerchantProcessorStub new) measuringTimeWith: clock. 
	
	TusLibrosWindow open.
	
	"Para probar la expiración de la sesión"
	ManualClock allInstances do: [:aManualClock | aManualClock advanceTime: 31 minutes].
	
	TusLibrosServer allInstances do: [:anInstance | anInstance destroy].

	
	"-------------Urls-------------
	http://localhost:8080/create-cart?user=Juan&password=1234
	http://localhost:8080/list-catalog
	http://localhost:8080/list-cart?cartId=1
	http://localhost:8080/add-to-cart?bookAmount=5&book=Book1&cartId=1
	http://localhost:8080/checkout-cart?cartId=1&ccn=11111111111111&cced=2%2f2050&cco='Juan'
	http://localhost:8080/list-purchases?user=Juan&password=1661548902539077689835780616605042428580731493960493799641588268547596371700
	http://localhost:8080/remove-from-cart?book=Book1&cartId=1
	--------------------------------
	"

Para corre el sistema hay que ejecutar desde el principio hasta 'TusLibrosWindow open' inclusive. 

En credentials agregamos algunos usuarios con sus correspondientes contraseñas para poder loguearse. El catálogo incluye 5 libros. También dejamos el clock con el código preparado para avanzar el tiempo y poder probar la expiración de la sesión. Por último, listamos algunas urls que funcionan para este mismo 
sistema con la contraseña ya hasheada.
