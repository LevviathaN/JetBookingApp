public with sharing class JetExp {
    @AuraEnabled(cacheable=true)
    public static List<Jet__c> getJetList() {
       List<Jet__c> jetList= [SELECT Name, Status__c, Current_Milage__c, Details__c FROM Jet__c];
        return jetList;
    }

    @AuraEnabled(cacheable=true)
    public static List<Jet_Booking__c> getJetBookingList() {
       List<Jet_Booking__c> jetBookingList= [SELECT Name, Status__c FROM Jet_Booking__c];
        return jetBookingList;
    }
}