package com.janschaedlich.utility.iban.error
{
    public class IbanValueEmptyError extends Error
    {
        public function IbanValueEmptyError(message:String = 'Iban value cannot be empty!')
        {
            super(message);
        }
    }
}
