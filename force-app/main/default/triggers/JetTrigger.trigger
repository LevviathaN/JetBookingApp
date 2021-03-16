trigger JetTrigger on Jet__c (before insert, before update, after undelete) {
    System.debug('Hello World!');
    for (Jet__c jet : Trigger.New) {
        if (jet.Total_Flied_Hours__c < 1000) {
            jet.Next_Inspection__c = Date.today().addDays(14);
            System.debug('Its time for inspection!');
        }

        if (jet.Status__c == 'On Hold') {
            Messaging.PushNotification msg = new Messaging.PushNotification();
        }
        
        if (Trigger.isUndelete){
            jet.Details__c = jet.Details__c + '\n Recovered at ' + Datetime.now();
        }
    }
}