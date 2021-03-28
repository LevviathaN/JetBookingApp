public with sharing class JetBookingTriggerHandler {
    
    public static void onBeforeInsert(List<Jet_Booking__c> insertdList) {
        for (Jet_Booking__c booking : insertdList) {
            Decimal pilotHours = [select Total_Flied_Hours__c from Customer__c where id = :booking.Customer__c].get(0).Total_Flied_Hours__c;
            Decimal jetRequiredHours = [select Min_Required_Pilot_Hours__c from Jet__c where id = :booking.Jet__c].get(0).Min_Required_Pilot_Hours__c;
            System.debug('Pilot flied hours: ' + pilotHours);
            System.debug('Jet required flied hours: ' + jetRequiredHours);
            if (pilotHours >= jetRequiredHours) {
                System.debug('Pilot is good. Approve automatically');
                booking.Status__c = 'Automatically Approved';
            }
        }
    }
    
    public static void onAfterInsert(Map<Id,Jet_Booking__c> insertdList) {
        for (Id bookingId : insertdList.keySet()) {
            Jet_Booking__c booking = [select Id, Jet__c, Customer__c from Jet_Booking__c where Id = :bookingId];
            //Jet_Booking__c booking = insertdList.get(bookingId);
            Decimal pilotHours = [select Total_Flied_Hours__c from Customer__c where id = :booking.Customer__c].get(0).Total_Flied_Hours__c;
            Decimal jetRequiredHours = [select Min_Required_Pilot_Hours__c from Jet__c where id = :booking.Jet__c].get(0).Min_Required_Pilot_Hours__c;
            System.debug('Pilot flied hours: ' + pilotHours);
            System.debug('Jet required flied hours: ' + jetRequiredHours);

            if (pilotHours < jetRequiredHours) {
                ApprovalProcessHelper.submitAndProcessApprovalRequest(booking);
                System.debug('Pilot is not good. Submit aprooval request');
            }
        }
    }

    public static void onBeforeUpdate(List<Jet_Booking__c> updatedList) {
		for (Jet_Booking__c booking : updatedList) {
            //Jet_Booking__c booking = [select Id, Jet__c, Customer__c from Jet_Booking__c where Id = :bookingId];
            Decimal pilotHours = [select Total_Flied_Hours__c from Customer__c where id = :booking.Customer__c].get(0).Total_Flied_Hours__c;
            Decimal jetRequiredHours = [select Min_Required_Pilot_Hours__c from Jet__c where id = :booking.Jet__c].get(0).Min_Required_Pilot_Hours__c;
            System.debug('Pilot flied hours: ' + pilotHours);
            System.debug('Jet required flied hours: ' + jetRequiredHours);
            if (pilotHours >= jetRequiredHours && booking.Status__c != 'Completed') {
                booking.Status__c = 'Automatically Approved';
            }
        }        
    }
    
    public static void onAfterUpdate(Map<id, Jet_Booking__c> updatedNewMap, Map<id, Jet_Booking__c> updatedOldMap) {
        List<Jet_Booking__c> bookingsToUpdate = new List<Jet_Booking__c>();

        for (Id bookingId : updatedNewMap.keySet()) {
            Jet_Booking__c booking = [select Id, Jet__c, Customer__c from Jet_Booking__c where Id = :bookingId];
            Decimal pilotHours = [select Total_Flied_Hours__c from Customer__c where id = :booking.Customer__c].get(0).Total_Flied_Hours__c;
            Decimal jetRequiredHours = [select Min_Required_Pilot_Hours__c from Jet__c where id = :booking.Jet__c].get(0).Min_Required_Pilot_Hours__c;
            System.debug('Pilot flied hours: ' + pilotHours);
            System.debug('Jet required flied hours: ' + jetRequiredHours);
			if (pilotHours < jetRequiredHours) {
                ApprovalProcessHelper.submitAndProcessApprovalRequest(booking);
            }
        }
    }
}