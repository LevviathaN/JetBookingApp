public with sharing class NotificationsHelper {

    public static void sendNotification(Id subjectId, String message) {
        ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput();
        ConnectApi.MentionSegmentInput mentionSegmentInput = new ConnectApi.MentionSegmentInput();
		ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
		ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();

		messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();

		mentionSegmentInput.id = subjectId; // Set @mention
		messageBodyInput.messageSegments.add(mentionSegmentInput);

		textSegmentInput.text = 'Blah blah blah blha';
		messageBodyInput.messageSegments.add(textSegmentInput);

		feedItemInput.body = messageBodyInput;
		feedItemInput.feedElementType = ConnectApi.FeedElementType.FeedItem;
		feedItemInput.subjectId = subjectId; 

		ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), feedItemInput);

        
        
        //ConnectApi.FeedElement feedElement1 = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), subjectId, ConnectApi.FeedElementType.FeedItem, message);
    }
}