public with sharing class JetBookingTriggerHandler {
    public JetBookingTriggerHandler() {

    }
    
    public static void onBeforeInsert(List<Jet_Booking__c> insertdList) {
        for (Jet_Booking__c booking : insertdList) {
            System.debug('Pilot flied hours: ' + booking.Customer__r.Total_Flied_Hours__c);
            System.debug('Jet required flied hours: ' + booking.Jet__r.Min_Required_Pilot_Hours__c);
            if (booking.Customer__r.Total_Flied_Hours__c >= booking.Jet__r.Min_Required_Pilot_Hours__c) {
                System.debug('Pilot is good. Approve automatically');
                booking.Status__c = 'Automatically Approved';
            }
            
            else if (booking.Customer__r.Total_Flied_Hours__c < booking.Jet__r.Min_Required_Pilot_Hours__c) {
                ApprovalProcessHelper.submitAndProcessApprovalRequest(booking);
                System.debug('Pilot is not good. Submit aprooval request');
                booking.Status__c = 'Approved';
            }
        }
    }

    public static void onBeforeUpdate(Map<id, Jet_Booking__c> insertdNewMap, Map<id, Jet_Booking__c> insertdOldMap) {
        List<Jet_Booking__c> bookingsToUpdate = new List<Jet_Booking__c>();

        for (Jet_Booking__c booking : insertdNewMap.values()) {
            System.debug('Pilot flied hours: ' + booking.Customer__r.Total_Flied_Hours__c);
            System.debug('Jet required flied hours: ' + booking.Jet__r.Min_Required_Pilot_Hours__c);
            if (booking.Customer__r.Total_Flied_Hours__c >= booking.Jet__r.Min_Required_Pilot_Hours__c) {
                booking.Status__c = 'Automatically Approved';
                bookingsToUpdate.add(booking);
            }
            
            else if (booking.Customer__r.Total_Flied_Hours__c < booking.Jet__r.Min_Required_Pilot_Hours__c) {
                ApprovalProcessHelper.submitAndProcessApprovalRequest(booking);
                booking.Status__c = 'Approved';
                bookingsToUpdate.add(booking);
            }
        }
        
        update bookingsToUpdate;
    }
}