/**
 * @description       : This is Payload Wrapper class. This wrapper class stores Transaction and
 *                      Related Transaction Items. 
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-24-2022
 * @last modified by  : Prathamesh Lad
**/
public with sharing class PayloadWrapper {
    public Transaction__c transactionObj;
    public List<TransactionItem__c> listTransactionItemObj; 
        
    public PayloadWrapper
        (Transaction__c transactionObj,List<TransactionItem__c> listTransactionItemObj) {
            this.transactionObj=transactionObj;
            this.listTransactionItemObj=listTransactionItemObj;
    }  
}
