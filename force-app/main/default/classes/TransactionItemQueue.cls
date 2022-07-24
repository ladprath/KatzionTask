/**
 * @description       : This is Queueable class in which Transaction Items are sending to API.
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-24-2022
 * @last modified by  : Prathamesh Lad
**/
public with sharing class TransactionItemQueue implements Queueable, Database.AllowsCallouts {
    @testVisible private static Boolean doChainJob = true; //Avoid Max stack depth error
     
    private List<PayloadWrapper> listWrapperObj; //List of Payload contains Transaction and Related Transaction Items

    
    /**
    * @description This is Constructor
    * @author Prathamesh Lad | 07-24-2022 
    * @param listWrapperObj 
    **/
    public TransactionItemQueue(List<PayloadWrapper> listWrapperObj) {
        this.listWrapperObj = listWrapperObj;
    }

    /**
    * @description This is Execute method to create JSON Request and call API
    * @author Prathamesh Lad | 07-24-2022 
    * @param context 
    **/
    public void execute(QueueableContext context) {

        //Create JSON Request using Transaction Items
        String requestBody
            =TransactionItemQueueHelper.createTransactionItemRequest(this.listWrapperObj); 

        //Call API and check status. If API returns success then Call second API.    
        Boolean status
            =TransactionItemQueueHelper.callTransactionItemAPI(requestBody);
        if(status && doChainJob){
            System.enqueueJob(new TransactionQueue(listWrapperObj));
        }              
    }
}
