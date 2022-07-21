/**
 * @description       : 
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-21-2022
 * @last modified by  : Prathamesh Lad
**/
public with sharing class TransactionItemQueueHelper {

    public Static String createTransactionItemRequest(List<PayloadWrapper> listWrapperObj){
        
        List<TransactionItemRequest> listRequestObj=new List<TransactionItemRequest>();
        for(PayloadWrapper wrapperObj :listWrapperObj){
            for(TransactionItem__c transactionItemObj :wrapperObj.listTransactionItemObj){
                
                TransactionItemRequest.Keys keyObj
                    =new TransactionItemRequest.Keys();
                keyObj.TransactionItemID=transactionItemObj.Id;

                TransactionItemRequest.Values valueObj
                    =new TransactionItemRequest.Values();
                valueObj.ItemCost=transactionItemObj.Item_Cost__c;
                valueObj.ItemName=transactionItemObj.Name;

                TransactionItemRequest requestObj=new TransactionItemRequest();
                requestObj.keys=keyObj;
                requestObj.values=valueObj; 
                listRequestObj.add(requestObj);               
            }            
        }
        return JSON.serialize(listRequestObj);
    } 
    
    public Static Boolean callTransactionItemAPI(String requestBody){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"mighty moose"}');
        //request.setBody(requestBody);
        
        HttpResponse response = http.send(request);
        if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' 
                + response.getStatusCode() + ' ' + response.getStatus());
            return false;    
        } else {
            System.debug(response.getBody());
            return true;
        }
    }
}
