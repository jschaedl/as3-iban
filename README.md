as3-iban
--------
### Release notes

#### 2015-05-25
* replaced BigInt.s with BigInteger from as3-crypto library
* added more tests
* changed validation methods visibility to public 
	* public function isLengthValid():Boolean;
	* public function isLocalCodeValid():Boolean;
	* public function isFormatValid():Boolean:
* fixed bug in Constant.checkLocalCode(localeCode:String)