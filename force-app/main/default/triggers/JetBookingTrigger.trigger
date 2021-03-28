trigger JetBookingTrigger on Jet_Booking__c (before insert, before update, after insert, after update) {
    Map<ID,Jet_Booking__c> ids = Trigger.newMap;

    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            JetBookingTriggerHandler.onBeforeInsert(Trigger.new);
        } else if (Trigger.isUpdate) {
            JetBookingTriggerHandler.onBeforeUpdate(Trigger.new);
        }
    } else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            JetBookingTriggerHandler.onAfterInsert(Trigger.newMap);
        } else if (Trigger.isUpdate) {
            JetBookingTriggerHandler.onAfterUpdate(Trigger.newMap, Trigger.oldMap);
        }
    }
}