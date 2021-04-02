public with sharing class JetExp {
    @AuraEnabled(cacheable=true)
    public static List<Jet__c> getJetList() {
       List<Jet__c> jetList= [SELECT Name, Status__c, Current_Milage__c, Details__c FROM Jet__c];
        return jetList;
    }

    @AuraEnabled(cacheable=true)
    public static List<Jet_Booking__c> getJetBookingList(Id jetId) {
        List<Jet_Booking__c> jetBookingList;
        try {
            jetBookingList = [SELECT Name, Status__c FROM Jet_Booking__c WHERE Id = :jetId WITH SECURITY_ENFORCED];
        } catch(System.QueryException qe) {
            System.debug(qe.getMessage());
        }
        return jetBookingList;
    }
}