package com.janschaedlich.utility.iban
{
    import com.janschaedlich.utility.iban.error.InvalidArgumentError;
    import com.janschaedlich.utility.iban.util.BigInt;
    
    import mx.collections.ArrayCollection;
    import mx.utils.StringUtil;
    
    public class Iban
    {
        private var iban:String;
        
        public function Iban(iban:String)
        {
            if (iban == null || iban == '')
            {
                throw InvalidArgumentError("Iban value can't be empty!")
            }
            this.iban = normalizeIban(iban);
        }
        
        private function normalizeIban(iban:String):String
        {
            return iban.split(" ").join("");
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
			if (!isLengthValid()) {
				return false;
			} else if (!isLocalCodeValid()) {
				return false;
			} else if (!isFormatValid()) {
				return false;
			} else if (!isChecksumValid()) {
				return false;
			} else {
				return true;
			}
		}
		
		private function isLengthValid():Boolean
		{
			return this.iban.length < 15 ? false : true;
		}
		
		private function isLocalCodeValid():Boolean
		{
			return Constants.checkLocalCode(getLocaleCode());
		}
		
		private function isFormatValid():Boolean
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
			var invertedIban:String = numericAccountIdentification + numericLocalCode  + checksum;
			//return BigInt.bigInt2str(new BigInt(new Array(invertedIban)), 10);
			
			var iban:BigInt = new BigInt(invertedIban);
			var modulus:BigInt = new BigInt('97');
			var mod:BigInt = BigInt.mod(iban, modulus);
			
			return mod.toString() == '1';
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
			for (var i:int = 0; i < splitted.length; i++) 
			{
				var index:int = Constants.letterMapping.getItemIndex(splitted[i]);
				if (index != -1) {
					numericRepresentation += (index + 1 + 9).toString();
				} else {
					numericRepresentation += splitted[i];
				}
			}
			return numericRepresentation;
		}
    }
}
