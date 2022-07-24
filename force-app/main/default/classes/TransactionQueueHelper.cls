/**
 * @description       : This is helper class for TransactionQueue
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-24-2022
 * @last modified by  : Prathamesh Lad
**/
public with sharing class TransactionQueueHelper {

    /**
    * @description This method is used to create API request using Transaction
    * @author Prathamesh Lad | 07-24-2022 
    * @param listWrapperObj 
    * @return String 
    **/
    public Static String createTransactionRequest(List<PayloadWrapper> listWrapperObj){
        
        List<TransactionRequest> listRequestObj=new List<TransactionRequest>();
        for(PayloadWrapper wrapperObj :listWrapperObj){
            TransactionRequest.Keys keyObj
                =new TransactionRequest.Keys();
            keyObj.TransactionID=wrapperObj.transactionObj.Id;

            TransactionRequest.Values valueObj
                =new TransactionRequest.Values();
            valueObj.TotalCost=wrapperObj.transactionObj.Total_Cost__c;
            valueObj.TotalDiscount=wrapperObj.transactionObj.Total_Discount__c;
            valueObj.TransactionDate=wrapperObj.transactionObj.Transaction_Date__c;
            valueObj.TotalCount=wrapperObj.transactionObj.Transaction_Count__c;

            TransactionRequest requestObj=new TransactionRequest();
            requestObj.keys=keyObj;
            requestObj.values=valueObj; 
            listRequestObj.add(requestObj);    
        }
        return JSON.serialize(listRequestObj);
    } 
    
    /**
    * @description This method is used to call Second API
    * @author Prathamesh Lad | 07-24-2022 
    * @param requestBody 
    * @return Boolean 
    **/
    public Static Boolean callTransactionAPI(String requestBody){
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
