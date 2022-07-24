/**
 * @description       : This is Queueable class in which Transaction are sending to API.
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-24-2022
 * @last modified by  : Prathamesh Lad
**/
public with sharing class TransactionQueue implements Queueable, Database.AllowsCallouts {
    
    private List<PayloadWrapper> listWrapperObj;//List of Payload contains Transaction and Related Transaction Items

     /**
    * @description This is Constructor
    * @author Prathamesh Lad | 07-24-2022 
    * @param listWrapperObj 
    **/
    public TransactionQueue(List<PayloadWrapper> listWrapperObj) {
        this.listWrapperObj = listWrapperObj;
    }

     /**
    * @description This is Execute method to create JSON Request and call API
    * @author Prathamesh Lad | 07-24-2022 
    * @param context 
    **/
    public void execute(QueueableContext context) {
        //Create JSON Request using Transactions
        String requestBody
            =TransactionQueueHelper.createTransactionRequest(this.listWrapperObj); 

        //Call API     
        TransactionQueueHelper.callTransactionAPI(requestBody);                    
    }
}
