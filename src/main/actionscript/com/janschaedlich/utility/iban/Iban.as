package com.janschaedlich.utility.iban
{
    import com.janschaedlich.utility.iban.error.InvalidArgumentError;
    
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
    }
}
