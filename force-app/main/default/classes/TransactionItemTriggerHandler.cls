/**
 * @description       : This is Handler class for TransactionItemTrigger
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-24-2022
 * @last modified by  : Prathamesh Lad
**/
public with sharing class TransactionItemTriggerHandler {
    /**
    * @description This is After Insert method
    * @author Prathamesh Lad | 07-24-2022 
    * @param listNewTransactionItemObj 
    **/
    public static void afterInsert
        (List<TransactionItem__c> listNewTransactionItemObj) {
        //Stores All Transaction Ids related to inserted Transaction Items    
        List<Id> listTransactionId=new List<Id>();
        for(TransactionItem__c transactionItemObj :listNewTransactionItemObj){
            listTransactionId.add(transactionItemObj.Transaction__c);
        }

        //Create Payload wrapper in which Transaction and Related Transaction Items are stored 
        //if Transaction count is matched
        List<PayloadWrapper> listWrapperObj=new List<PayloadWrapper>();
        List<Transaction__c> listTransactionObj
                =TransactionDomain.getTransactions(listTransactionId);
        for(Transaction__c transactionObj :listTransactionObj){            
            if(transactionObj.Transaction_Count__c==transactionObj.TransactionItem__r.size()){
                listWrapperObj.add
                    (new PayloadWrapper(transactionObj,transactionObj.TransactionItem__r));
            }
        } 
        
        //Call Transaction Item Queueable class
        if (!listWrapperObj.isEmpty()) {
            System.enqueueJob(new TransactionItemQueue(listWrapperObj));
        }
    }
}
