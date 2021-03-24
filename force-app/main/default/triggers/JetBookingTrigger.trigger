trigger JetBookingTrigger on Jet_Booking__c (after insert, after update) {
    Map<ID,Jet_Booking__c> ids = Trigger.newMap;

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            JetBookingTriggerHandler.onAfterInsert(Trigger.New);
        } else if (Trigger.isUpdate) {
            JetBookingTriggerHandler.onAfterUpdate(Trigger.newMap, Trigger.oldMap);
        }
    }
}