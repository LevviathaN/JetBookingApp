trigger JetTrigger on Jet__c (before insert, before update, after undelete) {
    Map<ID,Jet__c> newJetMap = Trigger.newMap;
    Map<ID,Jet__c> oldJetMap = Trigger.oldMap;

    if (Trigger.isBefore) {
        if (Trigger.isUpdate || Trigger.isInsert) {
            JetTriggerHandler.onBeforeInsertUpdate(newJetMap, oldJetMap);
        }
    } else if (Trigger.isAfter) {
        if (Trigger.isUndelete) {
            JetTriggerHandler.onAfterUndelete(newJetMap);
        }
    }
}