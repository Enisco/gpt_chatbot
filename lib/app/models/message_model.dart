import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) =>
    json.encode(data.toJson());

class MessageModel {
  final String message;
  final DateTime dateTime;
  final bool iSent;

  MessageModel({
    required this.message,
    required this.dateTime,
    required this.iSent,
  });

  MessageModel copyWith({
    String? message,
    DateTime? dateTime,
    bool? iSent,
  }) =>
      MessageModel(
        message: message ?? this.message,
        dateTime: dateTime ?? this.dateTime,
        iSent: iSent ?? this.iSent,
      );

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      MessageModel(
        message: json["message"],
        dateTime: DateTime.parse(json["dateTime"]),
        iSent: json["iSent"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "dateTime": dateTime.toIso8601String(),
        "iSent": iSent,
      };
}
