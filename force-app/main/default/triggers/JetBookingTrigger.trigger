trigger JetBookingTrigger on Jet_Booking__c (before insert, before update) {
    Map<ID,Jet_Booking__c> ids = Trigger.newMap;

    if (Trigger.isBefore) {
        if (Trigger.isUpdate || Trigger.isInsert) {
            JetBookingTriggerHandler.onBeforeInsertUpdate(Trigger.newMap, Trigger.oldMap);
        }
    }
}