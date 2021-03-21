public with sharing class JetTriggerHandler {

    public static void onBeforeInsert(List<Jet__c> insertdList) {
        
        for (Jet__c jet : insertdList) {
            if (jet.Status__c == 'On Hold') {
                String message = jet.name + ' marked on hold by ' + UserInfo.getUserId() + '. Please review this jet.';
                System.debug(message);
                Id subjectId = [SELECT Id FROM Group WHERE name='Jet Operators'].get(0).Id;
                NotificationsHelper.sendNotification(subjectId,message);
            }
        }
    }
    
    public static void onBeforeUpdate(Map<id, Jet__c> insertdNewMap, Map<id, Jet__c> insertdOldMap) {
        List<Jet__c> jetsToUpdate = new List<Jet__c>();

        for (Id jetId : insertdNewMap.keySet()) {
            Jet__c jet = insertdNewMap.get(jetId);
            if (jet.Total_Flied_Hours__c > 1000) {
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
                System.debug(message);
                Id subjectId = [SELECT Id FROM User WHERE alias='UUser'].get(0).Id;
                //Id subjectId = [SELECT Id FROM Group WHERE name='Jet Operators'].get(0).Id;
                //Id subjectId = UserInfo.getUserId();
                System.debug('Subject ID: ' + subjectId);
                NotificationsHelper.sendNotification(subjectId,message);
            }
        }

        update jetsToUpdate;
    }
    
    public static void onAfterUndelete(Map<id, Jet__c> undeletedMap) {
        List<Jet__c> jetsToInsert = new List<Jet__c>();
        List<Jet__c> jetsFromDB = [SELECT Details__c FROM Jet__c WHERE Id IN :undeletedMap.keySet()];
        Map<id, Jet__c> jetsFromDBMap = new Map<Id,Jet__c>([SELECT Details__c FROM Jet__c WHERE Id IN :undeletedMap.keySet()]);
        for (Jet__c jet : jetsFromDB) {
            if (jet.Details__c == null) {
                jet.Details__c = 'Recovered at ' + Datetime.now();
            } else {
                jet.Details__c = jet.Details__c + '\n Recovered at ' + Datetime.now();
            }
            jetsToInsert.add(jet);
        }
        update jetsToInsert;
    }
}