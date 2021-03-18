public with sharing class NotificationsHelper {

    public static void sendNotification(Id subjectId, String message) {
        ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), subjectId, ConnectApi.FeedElementType.FeedItem, message);
    }
}
