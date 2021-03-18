@isTest
public with sharing class JetBookingTriggerTest {


    @IsTest public static void testSufficientPilotHours(){
        User u = [select name, Id  FROM user WHERE Alias = 'UUser'];
        Map<String,sObject> generatedData = TestDataFactory.createJetBooking();
        Customer__c customer = (Customer__c)generatedData.get('TestCustomer');
        Airport__c departureAirport = (Airport__c)generatedData.get('TestDepartureAirport');
        Airport__c arivalAirport = (Airport__c)generatedData.get('TestArivalAirport');
        Jet__c jet = (Jet__c)generatedData.get('TestJet');
        Jet_Booking__c jetBooking;
        Test.startTest();
        System.runAs(u){
            jetBooking = new Jet_Booking__c(Customer__c=customer.id, Jet__c=jet.id, Departure_Airport__c=departureAirport.id,
            Arival_Airport__c=arivalAirport.id, Status__c='Created');
            insert jetBooking;
        }
        Test.stopTest();

        System.assert(jetBooking.Status__c=='Automatically Approved');
    }
}
