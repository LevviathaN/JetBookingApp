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
                Date d = Date.today().addDays(14);
                Datetime dt = (DateTime)d;
                String dayOfWeek = dt.format('EEEE');
                if (dayOfWeek.equals('Saturday')) {
                    d.addDays(2);
                } else if (dayOfWeek.equals('Sunday')) {
                    d.addDays(1);
                }
                jet.Next_Inspection__c = d;
                System.debug('Its time for inspection!');
            }
        
            if (jet.Status__c == 'On Hold' && insertdOldMap.get(jetId).Status__c != 'On Hold') {
                String message = jet.name + ' marked on hold by ' + UserInfo.getUserId() + '. Please review this jet.';
                Id subjectId = [SELECT Id FROM Group WHERE name='Jet Operators'].get(0).Id;
                NotificationsHelper.sendNotification(subjectId,message);
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
