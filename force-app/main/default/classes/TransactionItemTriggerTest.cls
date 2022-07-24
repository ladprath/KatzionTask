/**
 * @description       : This is Test class for Transaction Item Trigger
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-24-2022
 * @last modified by  : Prathamesh Lad
**/
@isTest
public with sharing class TransactionItemTriggerTest {
    static final Integer counter = 3;

    /**
    * @description This method is used to create data
    * @author Prathamesh Lad | 07-24-2022 
    **/
    @testSetup
    static void makeData(){ 
        List<Transaction__c> listTransactionObj
            =TransactionTestData.getTransactionRecords(counter);   
        insert listTransactionObj;       
    }

    /**
    * @description This method is used to cover Transaction Item Queueable class
    * @author Prathamesh Lad | 07-24-2022 
    **/
    @isTest private static void testTransactionItemQueue(){
        test.startTest();
        List<Transaction__c> listTransactionObj=[Select id from Transaction__c];
        System.assertEquals(3, listTransactionObj.size());

        Integer i=1;
        Map<Integer,Id> mapCounterToTransactionId=new Map<Integer,Id>();
        for(Transaction__c transactionObj:listTransactionObj){
            mapCounterToTransactionId.put(i++,transactionObj.Id);
        }

        Test.setMock(HttpCalloutMock.class, new CalloutMock());
        TransactionItemQueue.doChainJob = false;

        List<TransactionItem__c> listTransactionItemObj
            =TransactionItemTestData.getTransactionItemRecords(counter,mapCounterToTransactionId);
        insert listTransactionItemObj;
        System.assertEquals(6, listTransactionItemObj.size());

        test.stopTest();
    }

    /**
    * @description This method is used to cover Transaction Queueable class
    * @author Prathamesh Lad | 07-24-2022 
    **/
    @isTest private static void testTransactionQueue(){
        test.startTest();
            Test.setMock(HttpCalloutMock.class, new CalloutMock());
            List<PayloadWrapper> listWrapperObj=TransactionItemTriggerTest.createPayloadWrapper();
            System.assertEquals(3, listWrapperObj.size());

            TransactionQueue transactionQueueObj=new TransactionQueue(listWrapperObj);
            transactionQueueObj.execute(null);
        test.stopTest();
    }

    /**
    * @description This method is used to create Payload Wrapper
    * @author Prathamesh Lad | 07-24-2022 
    * @return List<PayloadWrapper> 
    **/
    private static List<PayloadWrapper> createPayloadWrapper(){
        List<PayloadWrapper> listWrapperObj=new List<PayloadWrapper>();
        List<Transaction__c> listTransactionObj=[Select id,Total_Cost__c,Total_Discount__c,
                                                Transaction_Date__c,Transaction_Count__c
                                                from Transaction__c];
        for(Transaction__c transactionObj :listTransactionObj){
            PayloadWrapper wrapperObj=new PayloadWrapper(transactionObj,null);
            listWrapperObj.add(wrapperObj);
        }                                        
        return listWrapperObj;
    }

    /**
    * @description This class is used as CallOutMock class for ExperienceCRM.CSCNotifications
    * @author Prathamesh Lad | 07-24-2022
    **/
    public class CalloutMock implements HttpCalloutMock {
        /**
        * @description This method is used to create dummy response
        * @author Prathamesh Lad | 07-24-2022
        * @param request 
        * @return HttpResponse 
        **/
        public HttpResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            String responseBody = 'Dummy Response';
            response.setBody(responseBody);
            response.setStatusCode(200);
			return response;
        }
    }

}
