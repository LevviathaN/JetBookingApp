public with sharing class JetBookingTriggerHandler {
    
    public static void onAfterInsert(List<Jet_Booking__c> insertdList) {
        List<Jet_Booking__c> bookingsToUpdate = new List<Jet_Booking__c>();
        for (Jet_Booking__c booking : insertdList) {
            Decimal pilotHours = [select Total_Flied_Hours__c from Customer__c where id = :booking.Customer__c].get(0).Total_Flied_Hours__c;
            Decimal jetRequiredHours = [select Min_Required_Pilot_Hours__c from Jet__c where id = :booking.Jet__c].get(0).Min_Required_Pilot_Hours__c;
            System.debug('Pilot flied hours: ' + pilotHours);
            System.debug('Jet required flied hours: ' + jetRequiredHours);
            if (pilotHours >= jetRequiredHours) {
                System.debug('Pilot is good. Approve automatically');
                booking.Status__c = 'Automatically Approved';
                bookingsToUpdate.add(booking);
            }
            
            else if (pilotHours < jetRequiredHours) {
                ApprovalProcessHelper.submitAndProcessApprovalRequest(booking);
                System.debug('Pilot is not good. Submit aprooval request');
                booking.Status__c = 'Approved';
                bookingsToUpdate.add(booking);
            }
        }
        
        update bookingsToUpdate;
    }

    public static void onAfterUpdate(Map<id, Jet_Booking__c> insertdNewMap, Map<id, Jet_Booking__c> insertdOldMap) {
        List<Jet_Booking__c> bookingsToUpdate = new List<Jet_Booking__c>();

        for (Jet_Booking__c booking : insertdNewMap.values()) {
            Decimal pilotHours = [select Total_Flied_Hours__c from Customer__c where id = :booking.Customer__c].get(0).Total_Flied_Hours__c;
            Decimal jetRequiredHours = [select Min_Required_Pilot_Hours__c from Jet__c where id = :booking.Jet__c].get(0).Min_Required_Pilot_Hours__c;
            System.debug('Pilot flied hours: ' + pilotHours);
            System.debug('Jet required flied hours: ' + jetRequiredHours);
            if (pilotHours >= jetRequiredHours) {
                booking.Status__c = 'Automatically Approved';
                bookingsToUpdate.add(booking);
            }
            
            else if (pilotHours < jetRequiredHours) {
                ApprovalProcessHelper.submitAndProcessApprovalRequest(booking);
                booking.Status__c = 'Approved';
                bookingsToUpdate.add(booking);
            }
        }
        
        update bookingsToUpdate;
    }
}