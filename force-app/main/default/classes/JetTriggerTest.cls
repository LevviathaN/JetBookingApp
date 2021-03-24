@isTest
public with sharing class JetTriggerTest {

    @IsTest public static void testJetFliedHoursOnUpdate(){
        // List<Jet__c> createdJets = TestDataFactory.createJets(3);
        User u = [select name, Id  FROM user WHERE Alias = 'UUser'];
        //Map<String,sObject> generatedData = TestDataFactory.createJetBooking();
        
        Customer__c customer = new Customer__c(Name='TestCustomer',Total_Flied_Hours__c=200);
        insert customer;
        Airport__c departureAirport = new Airport__c(Name='TestDepartureAirport');
        insert departureAirport;
        Airport__c arivalAirport = new Airport__c(Name='TestArivalAirport');
        insert arivalAirport;
        Jet__c jet = new Jet__c(Name='TestJet', Min_Required_Pilot_Hours__c=100);
        insert jet;
        Jet_Booking__c jetBooking = new Jet_Booking__c(Customer__c=customer.id, Jet__c=jet.id, Departure_Airport__c=departureAirport.id,
        	Arival_Airport__c=arivalAirport.id, Status__c='Created');
        insert jetBooking;
        Jet__c jetUpdated = [select Id, Name, Next_Inspection__c from Jet__c where Id = :jetBooking.Jet__c].get(0);
        
        
        //Jet_Booking__c jetBooking = (Jet_Booking__c)generatedData.get('TestJetBooking');
        //Jet__c jet = (Jet__c)generatedData.get('TestJet');
    
        Test.startTest();
        System.runAs(u){
            jetBooking.Hours_spent__c=1005;
            jetBooking.Status__c='Completed';
            jet.Min_Required_Pilot_Hours__c=90;
            update jetBooking;
            update jet;
        }
        Test.stopTest();

        
        Date d = Date.today().addDays(14);
        Datetime dt = (DateTime)d;
        String dayOfWeek = dt.format('EEEE');
        if (dayOfWeek.equals('Saturday')) {
            d.addDays(2);
        } else if (dayOfWeek.equals('Sunday')) {
            d.addDays(1);
        }
        System.assertEquals(jetUpdated.Next_Inspection__c, d);
    }
    
    @IsTest public static void testUpdateDescriptionAfterUndelete() {
        User u = [select name, Id  FROM user WHERE Alias = 'UUser'];
        Jet__c jet = new Jet__c(Name='TestJet', Min_Required_Pilot_Hours__c=100);
        insert jet;
        Datetime dt1;
        Datetime dt2;
        
        Test.startTest();
        System.runAs(u){
            delete jet;
            undelete jet;
            dt1 = Datetime.now();
            delete jet;
            undelete jet;
            dt2 = Datetime.now();
        }
        Datetime dt = Datetime.now();
        Test.stopTest();
        Jet__c jetUpdated = [select Details__c from Jet__c where id = :jet.id];
        System.assertEquals(jetUpdated.Details__c, 'Recovered at ' + dt1 + '\n Recovered at ' + dt2);
    }
    
    @IsTest public static void testOnHoldBeforeInsert() {
        User u = [select name, Id  FROM user WHERE Alias = 'UUser'];
        Jet__c jet = new Jet__c(Name='TestJet', Min_Required_Pilot_Hours__c=100, Status__c='On Hold');
        
        Test.startTest();
        System.runAs(u){
            insert jet;
        }
    }
    
    @IsTest public static void testOnHoldBeforeUpdate() {
        User u = [select name, Id  FROM user WHERE Alias = 'UUser'];
        Jet__c jet = new Jet__c(Name='TestJet', Min_Required_Pilot_Hours__c=100);
        insert jet;
        jet.Status__c='On Hold';
        
        Test.startTest();
        System.runAs(u){
            update jet;
        }
    }
}