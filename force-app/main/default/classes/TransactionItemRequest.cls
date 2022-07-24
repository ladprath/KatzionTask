/**
 * @description       : This is Request class for Transaction Item
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-24-2022
 * @last modified by  : Prathamesh Lad
**/
public with sharing class TransactionItemRequest {
    public Keys keys;
    public Values values;
    
    public class Keys {
        public String TransactionItemID;
    }
    
    public class Values {
        public Decimal ItemCost;
        public String ItemName;
    }
}
