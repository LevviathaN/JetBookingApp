@isTest
public with sharing class JetTriggerTest {

    @IsTest public static void testJetFliedHours(){
        // List<Jet__c> createdJets = TestDataFactory.createJets(3);
        User u = [select name, Id  FROM user WHERE Alias = 'UUser'];
        Map<String,sObject> generatedData = TestDataFactory.createJetBooking();
        Jet_Booking__c jetBooking = (Jet_Booking__c)generatedData.get('TestJetBooking');
        Jet__c jet = (Jet__c)generatedData.get('TestJet');
    
        Test.startTest();
        System.runAs(u){
            jetBooking.Hours_spent__c=1005;
            jet.Min_Required_Pilot_Hours__c=90;
            update jetBooking;
            update jet;
        }
        Test.stopTest();

        // Jet__c jet = Database.query('SELECT Id FROM Jet__c WHERE Id=' + jetBooking.Jet__c);
        Date d = Date.today().addDays(14);
        Datetime dt = (DateTime)d;
        String dayOfWeek = dt.format('EEEE');
        if (dayOfWeek.equals('Saturday')) {
            d.addDays(2);
        } else if (dayOfWeek.equals('Sunday')) {
            d.addDays(1);
        }
        System.assertEquals(jet.Next_Inspection__c, d);
    }
}
