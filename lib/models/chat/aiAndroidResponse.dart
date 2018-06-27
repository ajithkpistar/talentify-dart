import 'package:android_istar_app/models/chat/aiBotAndroidAction.dart';

class AIAndroidResponse {
  String id;
  String query;
  String date;
  String speech;
  String title;
  String description;
  String imageUrl;
  String type;
  String source;
  List<AIBotAndroidAction> actionItems;

  AIAndroidResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        query = json['query'],
        date = json['date'],
        speech = json['speech'],
        title = json['title'],
        description = json['description'],
        imageUrl = json['image_url'],
        type = json['type'],
        source = json['source'];
}
