/**
 * @description       : This is Test Data Class for creating test data Transaction
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-24-2022
 * @last modified by  : Prathamesh Lad
**/
@IsTest
public class TransactionTestData {

    /**
    * @description This method is used to create Transaction
    * @author Prathamesh Lad | 07-24-2022 
    * @param count 
    * @return List<Transaction__c> 
    **/
    public static List<Transaction__c> getTransactionRecords(Integer count) {
        List<Transaction__c> listTransactionObj =new List<Transaction__c>();
        for (Integer i = 1; i < =count; i++) {
            Transaction__c transactionObj = new Transaction__c();    
            transactionObj.Transaction_Count__c=i;
            transactionObj.Total_Cost__c=100;
            transactionObj.Total_Discount__c=10;
            transactionObj.Transaction_Date__c=System.today();
            listTransactionObj.add(transactionObj);            
        }
        return  listTransactionObj;   
    }
}
