/**
 * @description       : This is Request class for Transaction
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-24-2022
 * @last modified by  : Prathamesh Lad
**/
public with sharing class TransactionRequest {
    public Keys keys;
    public Values values;
    
    public class Keys {
        public String TransactionID;
    }
    
    public class Values {
        public Decimal TotalCost;
        public Decimal TotalDiscount;
        public Date TransactionDate;
        public Decimal TotalCount;
    }
}
