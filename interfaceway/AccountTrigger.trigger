trigger AccountTrigger on Account (after insert, after update) {
    
    AccountTriggerHandler handler = new AccountTriggerHandler();
    
    if (Trigger.isAfter && Trigger.isInsert) handler.afterInsert();
    if (Trigger.isAfter && Trigger.isUpdate) handler.afterUpdate();
}