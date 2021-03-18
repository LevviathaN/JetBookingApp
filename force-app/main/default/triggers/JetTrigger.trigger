trigger JetTrigger on Jet__c (before insert, before update, after undelete) {
    Map<ID,Jet__c> newJetMap = Trigger.newMap;
    Map<ID,Jet__c> oldJetMap = Trigger.oldMap;

    if (Trigger.isBefore) {
        if (Trigger.isInsert) {

        } else if (Trigger.isUpdate) {
            JetTriggerHandler.onBeforeUpdate(newJetMap, oldJetMap);
        }
    } else if (Trigger.isAfter) {
        if (Trigger.isUndelete) {
            
        }
    }
    
    if (Trigger.isUndelete){
        JetTriggerHandler.onAfterUndelete(newJetMap);
    }
}