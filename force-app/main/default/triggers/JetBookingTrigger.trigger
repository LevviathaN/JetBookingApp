trigger JetBookingTrigger on Jet_Booking__c (before insert, before update) {
    for (Jet_Booking__c booking : Trigger.New) {
        if (booking.Customer__r.Total_Flied_Hours__c >= booking.Jet__r.Min_Required_Pilot_Hours__c) {
            booking.Status__c = 'Automatically Approved';
        }
        
        if (booking.Customer__r.Total_Flied_Hours__c < booking.Jet__r.Min_Required_Pilot_Hours__c) {
            ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), 'Jet_Operators', ConnectApi.FeedElementType.FeedItem, 'On vacation this week.');
        }
    }
}