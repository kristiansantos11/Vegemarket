class MessageData{
  
  String text;
  String usernameSender;
  String usernameReceiver;
  DateTime timestamp;

  MessageData({
    this.text,
    this.usernameSender,
    this.usernameReceiver,
    this.timestamp
  });

  Map<String, dynamic> returnMessageData(){
    return {
      'text' : this.text,
      'usernameSender' : this.usernameSender,
      'usernameReceiver' : this.usernameReceiver,
      'timestamp' : this.timestamp,
    };
  }
}