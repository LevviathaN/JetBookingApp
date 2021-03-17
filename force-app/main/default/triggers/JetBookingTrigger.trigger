trigger JetBookingTrigger on Jet_Booking__c (before insert, before update) {
    Map<ID,Jet_Booking__c> ids = Trigger.newMap;

    if (Trigger.isBefore) {
        if (Trigger.isInsert) {

        }
        else if (Trigger.isUpdate) {
            JetBookingTriggerHandler.onBeforeUpdate(Trigger.newMap, Trigger.oldMap);
        }
    }

    else if (Trigger.isAfter) {
        if (Trigger.isInsert) {

        }
        else if (Trigger.isUpdate) {

        }
    }


}