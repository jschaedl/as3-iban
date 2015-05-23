package com.janschaedlich.utility.iban.test
{
    import com.janschaedlich.utility.iban.Constants;
    import com.janschaedlich.utility.iban.Iban;
    
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
		
		[Test]
		public function testIsLengthValid():void
		{
			assertTrue(new Iban('DE3583878387938').isLengthValid());
			assertFalse(new Iban('DE').isLengthValid());
		}
		
		[Test]
		public function testIsLocalCodeValid():void
		{
			var iban:Iban = new Iban('DE35 8387 8387 9387 8736 78');
			assertTrue(iban.isLocalCodeValid());
		}
		
		[Test]
		public function testIsFormatValid():void
		{
			var iban:Iban = new Iban('DE35 8387 8387 9387 8736 78');
			assertTrue(iban.isFormatValid());
			
			iban = new Iban('DE35 8387 83 8736 78');
			assertFalse(iban.isFormatValid());
		}
		
		[Test]
		public function testIsChecksumValid():void
		{
			var iban:Iban = new Iban('DE35500105175403732019');
			assertTrue(iban.isChecksumValid());
		}
		
		[Test]
		public function testValidate():void
		{
			assertTrue(new Iban('DE35500105175403732019').validate());
			assertFalse(new Iban('DE').validate());
			assertFalse(new Iban('XB35500105175403732019').validate());
			assertFalse(new Iban('DE35 8387 83 8736 78').validate());
			assertFalse(new Iban('DE10500105175403732019').validate());
		}
		
		
		[Test]
		public function testGetNumericRepresentation():void
		{
			var iban:Iban = new Iban('DE35 8387 8387 9387 8736 78');
			var letterRepresentationDE:String = 'DE';
			var letterRepresentationNL:String = 'NL';
			assertEquals('1314', iban.getNumericRepresentation(letterRepresentationDE));
			assertEquals('2321', iban.getNumericRepresentation(letterRepresentationNL));
		}
		
		[Test]
		public function testGetNumericLocaleCode():void
		{
			var iban:Iban = new Iban('DE35 8387 8387 9387 8736 78');
			var letterRepresentationDE:String = 'DE';
			var letterRepresentationNL:String = 'NL';
			assertEquals('1314', iban.getNumericLocaleCode(letterRepresentationDE));
			assertEquals('2321', iban.getNumericLocaleCode(letterRepresentationNL));
		}
		
		[Test]
		public function testGetNumericAccountIdentification():void
		{
			var iban:Iban = new Iban('DE35 8387 8387 9387 8736 78');
			var accountIdentification:String = iban.getAccountIdentification();
			assertEquals('838783879387873678', iban.getNumericAccountIdentification(accountIdentification));
		}
    }
}
