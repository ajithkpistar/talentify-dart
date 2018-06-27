class AIBotAndroidAction {
  String message;
  int faqId;
  bool isPlainMessage;
  String buttonText;
  String actionItemType;
  String appAction;

  AIBotAndroidAction.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        faqId = json['faqId'],
        isPlainMessage = json['isPlainMessage'],
        buttonText = json['buttonText'],
        actionItemType = json['actionItemType'],
        appAction = json['appAction'];
}
