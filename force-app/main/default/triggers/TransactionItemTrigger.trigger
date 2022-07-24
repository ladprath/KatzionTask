/**
 * @description       : This is TransactionItem__c Trigger
 * @author            : Prathamesh Lad
 * @group             : 
 * @last modified on  : 07-22-2022
 * @last modified by  : Prathamesh Lad
**/
trigger TransactionItemTrigger on TransactionItem__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if (Trigger.isInsert && Trigger.isAfter) {
        TransactionItemTriggerHandler.afterInsert((List<TransactionItem__c>)Trigger.new);       
    }
}