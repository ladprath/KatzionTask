/**
 * @description       : This is Test Data Class for creating test data Transaction Item
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-24-2022
 * @last modified by  : Prathamesh Lad
**/
@IsTest
public class TransactionItemTestData {
    /**
    * @description This method is used to create Transaction Items
    * @author Prathamesh Lad | 07-24-2022 
    * @param count 
    * @param mapCounterToTransactionId 
    * @return List<TransactionItem__c> 
    **/
    public static List<TransactionItem__c> getTransactionItemRecords
        (Integer count, Map<Integer,Id> mapCounterToTransactionId) {
        List<TransactionItem__c> listTransactionItemObj =new List<TransactionItem__c>();
        for (Integer i = 1; i < =count; i++) {
            for(Integer j=1; J<=i ;J++){
                TransactionItem__c transactionItemObj = new TransactionItem__c();    
                transactionItemObj.Name='TI'+i+j;
                transactionItemObj.Item_Cost__c=100;
                transactionItemObj.Transaction__c=mapCounterToTransactionId.get(i);
                listTransactionItemObj.add(transactionItemObj);            
            }
        }
        return  listTransactionItemObj;   
    }
}
