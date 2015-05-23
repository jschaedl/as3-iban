package com.janschaedlich.utility.iban
{
	import mx.collections.ArrayCollection;

	public class Constants
	{
		public static var letterMapping:ArrayCollection = new ArrayCollection([
			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
			'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 
			'U', 'V', 'W', 'X', 'Y', 'Z'
		]);
		
		public static var ibanFormatMap:ArrayCollection = new ArrayCollection([
			{iso:'AL', format:'[0-9]{8}[0-9A-Z]{16}'},
			{iso:'AD', format:'[0-9]{8}[0-9A-Z]{12}'},
			{iso:'AT', format:'[0-9]{16}'},
			{iso:'BE', format:'[0-9]{12}'},
			{iso:'BA', format:'[0-9]{16}'},
			{iso:'BG', format:'[A-Z]{4}[0-9]{6}[0-9A-Z]{8}'},
			{iso:'HR', format:'[0-9]{17}'},
			{iso:'CY', format:'[0-9]{8}[0-9A-Z]{16}'},
			{iso:'CZ', format:'[0-9]{20}'},
			{iso:'DK', format:'[0-9]{14}'},
			{iso:'EE', format:'[0-9]{16}'},
			{iso:'FO', format:'[0-9]{14}'},
			{iso:'FI', format:'[0-9]{14}'},
			{iso:'FR', format:'[0-9]{10}[0-9A-Z]{11}[0-9]{2}'},
			{iso:'GE', format:'[0-9A-Z]{2}[0-9]{16}'},
			{iso:'DE', format:'[0-9]{18}'},
			{iso:'GI', format:'[A-Z]{4}[0-9A-Z]{15}'},
			{iso:'GR', format:'[0-9]{7}[0-9A-Z]{16}'},
			{iso:'GL', format:'[0-9]{14}'},
			{iso:'HU', format:'[0-9]{24}'},
			{iso:'IS', format:'[0-9]{22}'},
			{iso:'IE', format:'[0-9A-Z]{4}[0-9]{14}'},
			{iso:'IL', format:'[0-9]{19}'},
			{iso:'IT', format:'[A-Z][0-9]{10}[0-9A-Z]{12}'},
			{iso:'KZ', format:'[0-9]{3}[0-9A-Z]{3}[0-9]{10}'},
			{iso:'KW', format:'[A-Z]{4}[0-9]{22}'},
			{iso:'LV', format:'[A-Z]{4}[0-9A-Z]{13}'},
			{iso:'LB', format:'[0-9]{4}[0-9A-Z]{20}'},
			{iso:'LI', format:'[0-9]{5}[0-9A-Z]{12}'},
			{iso:'LT', format:'[0-9]{16}'},
			{iso:'LU', format:'[0-9]{3}[0-9A-Z]{13}'},
			{iso:'MK', format:'[0-9]{3}[0-9A-Z]{10}[0-9]{2}'},
			{iso:'MT', format:'[A-Z]{4}[0-9]{5}[0-9A-Z]{18}'},
			{iso:'MR', format:'[0-9]{23}'},
			{iso:'MU', format:'[A-Z]{4}[0-9]{19}[A-Z]{3}'},
			{iso:'MC', format:'[0-9]{10}[0-9A-Z]{11}[0-9]{2}'},
			{iso:'ME', format:'[0-9]{18}'},
			{iso:'NL', format:'[A-Z]{4}[0-9]{10}'},
			{iso:'NO', format:'[0-9]{11}'},
			{iso:'PL', format:'[0-9]{24}'},
			{iso:'PT', format:'[0-9]{21}'},
			{iso:'RO', format:'[A-Z]{4}[0-9A-Z]{16}'},
			{iso:'SM', format:'[A-Z][0-9]{10}[0-9A-Z]{12}'},
			{iso:'SA', format:'[0-9]{2}[0-9A-Z]{18}'},
			{iso:'RS', format:'[0-9]{18}'},
			{iso:'SK', format:'[0-9]{20}'},
			{iso:'SI', format:'[0-9]{15}'},
			{iso:'ES', format:'[0-9]{20}'},
			{iso:'SE', format:'[0-9]{20}'},
			{iso:'CH', format:'[0-9]{5}[0-9A-Z]{12}'},
			{iso:'TN', format:'[0-9]{20}'},
			{iso:'TR', format:'[0-9]{5}[0-9A-Z]{17}'},
			{iso:'AE', format:'[0-9]{19}'},
			{iso:'GB', format:'[A-Z]{4}[0-9]{14}'}
		]);
		
		public static function checkLocalCode(localeCode:String):Boolean
		{
			var item:Object = null;
			for each (item in ibanFormatMap) 
			{	
				if (localeCode == item.iso)
					return true;
			}
			return false;
		}
		
		public static function checkFormat(localeCode:String, accountIdentification:String):Boolean
		{
			var item:Object = null;
			var pattern:String = null;

			for each (item in ibanFormatMap)
			{
				if (localeCode == item.iso) 
				{
					pattern = item.format;
					break;
				}	
			}
			
			var regEx:RegExp = new RegExp(pattern, '');
			var results:Array = accountIdentification.match(regEx);

			return results is Array && 
				results.length == 1 && 
				results[0] == accountIdentification;
		}
	}
}