trigger JetTrigger on Jet__c (before insert, before update, after undelete) {
    Map<ID,Jet__c> ids = Trigger.newMap;

    if (Trigger.isBefore) {
        if (Trigger.isInsert) {

        } else if (Trigger.isUpdate) {

        }
    } else if (Trigger.isAfter) {
        if (Trigger.isUndelete) {
            
        }
    }
    
    if (Trigger.isUndelete){
        
    }
}