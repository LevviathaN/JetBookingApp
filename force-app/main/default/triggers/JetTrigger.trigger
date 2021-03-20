trigger JetTrigger on Jet__c (before insert, before update, after undelete) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            JetTriggerHandler.onBeforeInsert(Trigger.New);
        } else if (Trigger.isUpdate) {
            JetTriggerHandler.onBeforeUpdate(Trigger.newMap, Trigger.oldMap);
        } else if (Trigger.isUndelete) {
            JetTriggerHandler.onBeforeUndelete(Trigger.New);
        }
    } else if (Trigger.isAfter) {
        if (Trigger.isUndelete) {
            JetTriggerHandler.onAfterUndelete(Trigger.newMap);
        }
    }
}