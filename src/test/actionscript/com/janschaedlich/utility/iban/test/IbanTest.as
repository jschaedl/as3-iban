package com.janschaedlich.utility.iban.test
{   
    import com.janschaedlich.utility.iban.Iban;
    
    import mx.collections.ArrayCollection;
    
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertFalse;
    import org.flexunit.asserts.assertTrue;
    
    public class IbanTest
    {
		[Test]
		public function testConstruction():void
		{
			var iban:Iban = new Iban('DE35838783879387873678'); 
			assertTrue(iban.equals(new Iban('DE35838783879387873678')));
		}
		
		[Test(expects="Error")]
		public function testConstructionWithoutIbanStringShouldRaiseError():void
        {
			var iban:Iban = new Iban(''); 
        }
		
		[Test]
		public function testEquals():void
		{
			var iban:Iban = new Iban('DE35 83878387 93878736 78'); 
			assertTrue(iban.equals(new Iban('DE35 8387 8387 9387 8736 78')));
		}
		
		[Test]
		public function testGetLocaleCode():void
		{
			var iban:Iban = new Iban('DE35 83878387 93878736 78'); 
			assertTrue('DE'.localeCompare(iban.getLocaleCode()) == 0);
			assertFalse('NL'.localeCompare(iban.getLocaleCode()) == 0);
		}
		
		[Test]
		public function testGetChecksum():void
		{
			var iban:Iban = new Iban('DE35 83878387 93878736 78'); 
			assertTrue('35'.localeCompare(iban.getChecksum()) == 0);
			assertFalse('00'.localeCompare(iban.getChecksum()) == 0);
		}
		
		[Test]
		public function testGetAccountIdentification():void
		{
			var iban:Iban = new Iban('DE35 83878387 93878736 78'); 
			assertTrue('838783879387873678'.localeCompare(iban.getAccountIdentification()) == 0);
			assertFalse('000000000000000000'.localeCompare(iban.getAccountIdentification()) == 0);
		}
		
		[Test]
		public function testGetInstituteIdentification():void
		{
			var iban:Iban = new Iban('DE35 83878387 93878736 78'); 
			assertTrue('83878387'.localeCompare(iban.getInstituteIdentification()) == 0);
			assertFalse('00000000'.localeCompare(iban.getInstituteIdentification()) == 0);
		}
		
		[Test]
		public function testGetBankAccountNumber():void
		{
			var iban:Iban = new Iban('DE35 83878387 93878736 78'); 
			assertTrue('9387873678'.localeCompare(iban.getBankAccountNumber()) == 0);
			assertFalse('0000000000'.localeCompare(iban.getBankAccountNumber()) == 0);
		}
		
		[Test]
		public function testFormat():void
		{
			var iban:Iban = new Iban('DE35 83878387 93878736 78'); 
			assertEquals('DE35 8387 8387 9387 8736 78', iban.format());
		}
		
		/*[Test]
		public function test():void
		{
			
		}*/
    }
}
