/**
 * @description       : This is Handler class for TransactionItemTrigger
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-21-2022
 * @last modified by  : Prathamesh Lad
**/
public with sharing class TransactionItemTriggerHandler {
    public void afterInsert
        (List<TransactionItem__c> listNewTransactionItemObj,
            Map<Id, TransactionItem__c> mapIdToTransactionItemObj) {
        List<Id> listTransactionId=new List<Id>();
        for(TransactionItem__c transactionItemObj :listNewTransactionItemObj){
            listTransactionId.add(transactionItemObj.Transaction__c);
        }

        List<PayloadWrapper> listWrapperObj=new List<PayloadWrapper>();
        List<Transaction__c> listTransactionObj
                =[Select Id, Transaction_Count__c, (Select Id, Name, Item_Cost__c from TransactionItem__r)
                 from Transaction__c where Id IN:listTransactionId];
        for(Transaction__c transactionObj :listTransactionObj){            
            if(transactionObj.Transaction_Count__c==transactionObj.TransactionItem__r.size()){
                listWrapperObj.add
                    (new PayloadWrapper(transactionObj,transactionObj.TransactionItem__r));
            }
        } 

        if (!listWrapperObj.isEmpty()) {
            //System.enqueueJob(new TransactionItemQueue(listTransactionItemData));
        }
    }
}
