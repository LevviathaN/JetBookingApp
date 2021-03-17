public with sharing class JetTriggerHandler {
    public JetTriggerHandler() {

    }

    public static void onBeforeInsert() {
        
    }

    public static void onBeforeUpdate(Map<id, Jet__c> insertdNewMap, Map<id, Jet__c> insertdOldMap) {
        List<Jet__c> jetsToUpdate = new List<Jet__c>();

        for (Id jetId : insertdNewMap.keySet()) {
            Jet__c jet = insertdNewMap.get(jetId);
            if (jet.Total_Flied_Hours__c < 1000) {
                jet.Next_Inspection__c = Date.today().addDays(14);
                System.debug('Its time for inspection!');
            }
        
            if (jet.Status__c == 'On Hold' && insertdOldMap.get(jetId).Status__c != 'On Hold') {
                NotificationsHelper.sendNotification('subjectId','message');
                Messaging.PushNotification msg = new Messaging.PushNotification();
            }
        }

        update jetsToUpdate;
    }

    public static void onAfterUndelete(Map<id, Jet__c> insertdNewMap) {
        List<Jet__c> jetsToUpdate = new List<Jet__c>();
        for (Jet__c jet : insertdNewMap.values()) {
            jet.Details__c = jet.Details__c + '\n Recovered at ' + Datetime.now();
        }
        update jetsToUpdate;
    }
}
