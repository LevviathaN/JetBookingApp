@isTest
public with sharing class JetBookingTriggerTest {


    @IsTest public static void testSufficientPilotHoursOnInsert(){
        User u = [select name, Id  FROM user WHERE Alias = 'UUser'];

        Customer__c customer = new Customer__c(Name='TestCustomer',Total_Flied_Hours__c=200);
        insert customer;
        Airport__c departureAirport = new Airport__c(Name='TestDepartureAirport');
        insert departureAirport;
        Airport__c arivalAirport = new Airport__c(Name='TestArivalAirport');
        insert arivalAirport;
        Jet__c jet = new Jet__c(Name='TestJet', Min_Required_Pilot_Hours__c=100);
        insert jet;
       
        
        //Customer__c customer = (Customer__c)generatedData.get('TestCustomer');
        //Airport__c departureAirport = (Airport__c)generatedData.get('TestDepartureAirport');
        //Airport__c arivalAirport = (Airport__c)generatedData.get('TestArivalAirport');
        //Jet__c jet = (Jet__c)generatedData.get('TestJet');
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
    
    @IsTest public static void testSufficientPilotHoursOnUpdate(){
        User u = [select name, Id  FROM user WHERE Alias = 'UUser'];

        Customer__c customer = new Customer__c(Name='TestCustomer',Total_Flied_Hours__c=200);
        insert customer;
        Airport__c departureAirport = new Airport__c(Name='TestDepartureAirport');
        insert departureAirport;
        Airport__c arivalAirport = new Airport__c(Name='TestArivalAirport');
        insert arivalAirport;
        Jet__c jet = new Jet__c(Name='TestJet', Min_Required_Pilot_Hours__c=100);
        insert jet;
        
        Customer__c customerNew = new Customer__c(Name='TestCustomerNew',Total_Flied_Hours__c=200);
        insert customerNew;
        Airport__c departureAirportNew = new Airport__c(Name='TestDepartureAirportNew');
        insert departureAirportNew;
        Airport__c arivalAirportNew = new Airport__c(Name='TestArivalAirportNew');
        insert arivalAirportNew;
        Jet__c jetNew = new Jet__c(Name='TestJetNew', Min_Required_Pilot_Hours__c=100);
        insert jetNew;
       
        
        //Customer__c customer = (Customer__c)generatedData.get('TestCustomer');
        //Airport__c departureAirport = (Airport__c)generatedData.get('TestDepartureAirport');
        //Airport__c arivalAirport = (Airport__c)generatedData.get('TestArivalAirport');
        //Jet__c jet = (Jet__c)generatedData.get('TestJet');
        Jet_Booking__c jetBooking = new Jet_Booking__c(Customer__c=customer.id, Jet__c=jet.id, Departure_Airport__c=departureAirport.id,
        	Arival_Airport__c=arivalAirport.id, Status__c='Created');
        	insert jetBooking;
        
        Test.startTest();
        System.runAs(u){
            jetBooking = new Jet_Booking__c(Customer__c=customerNew.id, Jet__c=jetNew.id, Departure_Airport__c=departureAirportNew.id,
        	Arival_Airport__c=arivalAirportNew.id, Status__c='Created');
            update jetBooking;
        }
        Test.stopTest();

        System.assert(jetBooking.Status__c=='Automatically Approved');
    }
}