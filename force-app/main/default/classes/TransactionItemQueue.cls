/**
 * @description       : 
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-21-2022
 * @last modified by  : Prathamesh Lad
**/
public with sharing class TransactionItemQueue {
    private List<PayloadWrapper> listWrapperObj;

    public TransactionItemQueue(List<PayloadWrapper> listWrapperObj) {
        this.listWrapperObj = listWrapperObj;
    }

    public void execute(QueueableContext context) {
        String requestBody
            =TransactionItemQueueHelper.createTransactionItemRequest(this.listWrapperObj); 
        Boolean status
            =TransactionItemQueueHelper.callTransactionItemAPI(requestBody);
        if(status){
            
        }              
    }
}
