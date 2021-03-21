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

    public static Map<String,sObject> createJetBookingWithAllData() {
        Set<sObject> objectsToInsert = new Set<sObject>();
        Map<String,sObject> insertedTestData = new Map<String,sObject>();
        Customer__c customer = new Customer__c(Name='TestCustomer',Total_Flied_Hours__c=200);
        insert customer;
        insertedTestData.put('TestCustomer',customer);
        // objectsToInsert.add(customer);
        Airport__c departureAirport = new Airport__c(Name='TestDepartureAirport');
        insert departureAirport;
        insertedTestData.put('TestDepartureAirport',departureAirport);
        // objectsToInsert.add(departureAirport);
        Airport__c arivalAirport = new Airport__c(Name='TestArivalAirport');
        insert arivalAirport;
        insertedTestData.put('TestArivalAirport',arivalAirport);
        // objectsToInsert.add(arivalAirport);
        Jet__c jet = new Jet__c(Name='TestJet', Min_Required_Pilot_Hours__c=100);
        insert jet;
        insertedTestData.put('TestJet',jet);
        // objectsToInsert.add(jet);
        Jet_Booking__c jetBooking = new Jet_Booking__c(Customer__c=customer.id, Jet__c=jet.id, Departure_Airport__c=departureAirport.id,
        Arival_Airport__c=arivalAirport.id, Status__c='Created');
        insert jetBooking;
        insertedTestData.put('TestJetBooking',jetBooking);
        // objectsToInsert.add(jetBooking);
        return insertedTestData;
    }
    
    public static Map<String,sObject> createJetBooking() {
        Set<sObject> objectsToInsert = new Set<sObject>();
        Map<String,sObject> insertedTestData = new Map<String,sObject>();
        Customer__c customer = [SELECT id FROM Customer__c WHERE name='TestCustomer' LIMIT 1];
        insertedTestData.put('TestCustomer',customer);
        // objectsToInsert.add(customer);
        Airport__c departureAirport = [SELECT id FROM Airport__c WHERE name='TestDepartureAirport' LIMIT 1];
        insertedTestData.put('TestDepartureAirport',departureAirport);
        // objectsToInsert.add(departureAirport);
        Airport__c arivalAirport = [SELECT id FROM Airport__c WHERE name='TestArivalAirport' LIMIT 1];
        insertedTestData.put('TestArivalAirport',arivalAirport);
        // objectsToInsert.add(arivalAirport);
        Jet__c jet = [SELECT id FROM Jet__c WHERE name='TestJet' LIMIT 1];
        insertedTestData.put('TestJet',jet);
        // objectsToInsert.add(jet);
        Jet_Booking__c jetBooking = new Jet_Booking__c(Customer__c=customer.id, Jet__c=jet.id, Departure_Airport__c=departureAirport.id,
        Arival_Airport__c=arivalAirport.id, Status__c='Created');
        insert jetBooking;
        insertedTestData.put('TestJetBooking',jetBooking);
        // objectsToInsert.add(jetBooking);
        return insertedTestData;
    }
}