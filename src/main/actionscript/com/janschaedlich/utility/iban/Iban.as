package com.janschaedlich.utility.iban
{
	import com.hurlant.math.BigInteger;
	import com.janschaedlich.utility.iban.error.IbanValueEmptyError;

	public class Iban
	{
		private var iban:String;

		public function Iban(iban:String)
		{
			if (iban == null || iban == '')
			{
				throw new IbanValueEmptyError();
			}

			this.iban = normalizeIban(iban);
		}

		public function equals(iban:Iban):Boolean
		{
			return (this.iban == iban.iban);
		}

		public function getLocaleCode():String
		{
			return this.iban.substr(0, 2);
		}

		public function getChecksum():String
		{
			return this.iban.substr(2, 2);
		}

		public function getAccountIdentification():String
		{
			return this.iban.substr(4);
		}

		public function getInstituteIdentification():String
		{
			return this.iban.substr(4, 8);
		}

		public function getBankAccountNumber():String
		{
			return this.iban.substr(12, 10);
		}

		public function format():String
		{
			return getLocaleCode() + getChecksum() + ' ' 
				+ getInstituteIdentification().substr(0, 4) + ' ' 
				+ getInstituteIdentification().substr(4, 4) + ' ' 
				+ getBankAccountNumber().substr(0, 4) + ' ' 
				+ getBankAccountNumber().substr(4, 4) + ' ' 
				+ getBankAccountNumber().substr(8, 2);
		}

		public function validate():Boolean
		{
			if (!isLengthValid() || 
				!isLocalCodeValid() || 
				!isFormatValid() || 
				!isChecksumValid())
			{
				return false;
			}
			
			return true;
		}

		public function isLengthValid():Boolean
		{
			return (this.iban.length < 15) ? false : true;
		}

		public function isLocalCodeValid():Boolean
		{
			return Constants.checkLocalCode(getLocaleCode());
		}

		public function isFormatValid():Boolean
		{
			return Constants.checkFormat(getLocaleCode(), getAccountIdentification());
		}

		public function isChecksumValid():Boolean
		{
			var localeCode:String = getLocaleCode();
			var checksum:String = getChecksum();
			var accountIdentification:String = getAccountIdentification();
			var numericLocalCode:String = getNumericLocaleCode(localeCode);
			var numericAccountIdentification:String = getNumericAccountIdentification(accountIdentification);
			var invertedIban:String = numericAccountIdentification + numericLocalCode + checksum;

			var iban:BigInteger = new BigInteger(invertedIban, 10);
			var modulus:BigInteger = new BigInteger('97', 10);
			var mod:BigInteger = iban.mod(modulus);
			
			return mod.toString(10) == '1';
/*
			var iban:BigInt = new BigInt(invertedIban);
			var modulus:BigInt = new BigInt('97');
			var mod:BigInt = BigInt.mod(iban, modulus);
			
			return mod.toString() == '1';
*/
		}

		public function getNumericLocaleCode(localeCode:String):String
		{
			return getNumericRepresentation(localeCode);
		}

		public function getNumericAccountIdentification(accountIdentification:String):String
		{
			return getNumericRepresentation(accountIdentification);
		}

		public function getNumericRepresentation(letterRepresentation:String):String
		{
			var numericRepresentation:String = '';
			var splitted:Array = letterRepresentation.split("");
			for (var i:int=0; i < splitted.length; i++)
			{
				var index:int = Constants.letterMapping.getItemIndex(splitted[i]);
				if (index != -1)
				{
					numericRepresentation += (index + 1 + 9).toString();
				}
				else
				{
					numericRepresentation += splitted[i];
				}
			}
			return numericRepresentation;
		}

		private function normalizeIban(iban:String):String
		{
			return iban.split(" ").join("");
		}
	}
}
