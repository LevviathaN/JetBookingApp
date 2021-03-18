@isTest
public class TestDataFactory {
    public static List<Jet__c> createJets(Integer numJets) {
        List<Jet__c> jets = new List<Jet__c>();
        
        for(Integer i=0;i<numJets;i++) {
            Jet__c a = new Jet__c(Name='TestJet' + i, Min_Required_Pilot_Hours__c=100);
            jets.add(a);
        }
        insert jets;
        
        return jets;
    }

    public static Jet_Booking__c createJetBooking() {
        Set<sObject> objectsToInsert = new Set<sObject>();
        Customer__c customer = new Customer__c(Name='TestCustomer',Total_Flied_Hours__c=200);
        insert customer;
        // objectsToInsert.add(customer);
        Airport__c departureAirport = new Airport__c(Name='TestDepartureAirport');
        insert departureAirport;
        // objectsToInsert.add(departureAirport);
        Airport__c arivalAirport = new Airport__c(Name='TestArivalAirport');
        insert arivalAirport;
        // objectsToInsert.add(arivalAirport);
        Jet__c jet = new Jet__c(Name='TestJet', Min_Required_Pilot_Hours__c=100);
        insert jet;
        // objectsToInsert.add(jet);
        Jet_Booking__c jetBooking = new Jet_Booking__c(Customer__c=customer.id, Jet__c=jet.id, Departure_Airport__c=departureAirport.id,
        Arival_Airport__c=arivalAirport.id, Status__c='Created');
        insert jetBooking;
        // objectsToInsert.add(jetBooking);
        return jetBooking;
    }
}