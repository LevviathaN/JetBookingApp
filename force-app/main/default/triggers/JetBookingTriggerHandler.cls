public with sharing class JetBookingTriggerHandler {
    public JetBookingTriggerHandler() {

    }

    public static void onBeforeInsert(List<Jet_Booking__c> insertdList) {
        
    }

    public static void onBeforeUpdate(Map<id, Jet_Booking__c> insertdNewMap, Map<id, Jet_Booking__c> insertdOldMap) {
        // List<Account> accountsWithContacts = [select id, name, (select id, salutation, description, firstname, lastname, email from Contacts) from Account where Id IN :Trigger.newMap.keySet()];
        List<Jet_Booking__c> bookingsToUpdate = new List<Jet_Booking__c>();

        for (Jet_Booking__c booking : insertdNewMap.values()) {
            if (booking.Customer__r.Total_Flied_Hours__c >= booking.Jet__r.Min_Required_Pilot_Hours__c) {
                booking.Status__c = 'Automatically Approved';
                bookingsToUpdate.add(booking);
            }
            
            else if (booking.Customer__r.Total_Flied_Hours__c < booking.Jet__r.Min_Required_Pilot_Hours__c) {
                ApprovalProcessHelper.submitAndProcessApprovalRequest(booking);
                booking.Status__c = 'Automatically Approved';
                bookingsToUpdate.add(booking);
            }
        }
        
        update bookingsToUpdate;
    }
}
