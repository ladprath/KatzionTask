/**
 * @description       : This is Domain class for Transaction
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-24-2022
 * @last modified by  : Prathamesh Lad
**/
public with sharing class TransactionDomain {
    
    /**
    * @description This method is used to return list of Transaction
    * @author Prathamesh Lad | 07-24-2022 
    * @param listTransactionId 
    * @return List<Transaction__c> 
    **/
    public static List<Transaction__c> getTransactions(List<Id> listTransactionId){
        return [Select Id, Transaction_Count__c,Total_Cost__c,Total_Discount__c,Transaction_Date__c,
                (Select Id, Name, Item_Cost__c from TransactionItem__r)
                from Transaction__c where Id IN:listTransactionId];
    }
}
