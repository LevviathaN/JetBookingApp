@isTest
public with sharing class JetTriggerTest {

    @IsTest public static void testJetFliedHours(){
        // List<Jet__c> createdJets = TestDataFactory.createJets(3);
        User u = [select name, Id  FROM user WHERE Alias = 'UUser'];
        Jet_Booking__c jetBooking = TestDataFactory.createJetBooking();
    
        Test.startTest();
        System.runAs(u){
            jetBooking.Hours_spent__c=1005;
            update jetBooking;
        }
        Test.stopTest();

        Jet__c jet = Database.query('SELECT Id FROM Jet__c WHERE Id=' + jetBooking.Jet__c);
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
