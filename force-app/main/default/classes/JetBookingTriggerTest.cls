@isTest
public with sharing class JetBookingTriggerTest {


    @IsTest public static void testSufficientPilotHours(){
        User u = [select name, Id  FROM user WHERE Alias = 'UUser'];
        Jet_Booking__c jetBooking = TestDataFactory.createJetBooking();
        Test.startTest();
        System.runAs(u){

        }
        Test.stopTest();

        System.assert(jetBooking.Status__c=='Automatically Approved');
    }
}
