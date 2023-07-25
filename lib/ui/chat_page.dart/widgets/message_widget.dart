import 'package:flutter/material.dart';
import 'package:gpt_chatbot/app/models/message_model.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel messageData;
  const MessageWidget({super.key, required this.messageData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: messageData.iSent == true
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: EdgeInsets.only(
            left: messageData.iSent == true ? 40 : 0,
            right: messageData.iSent == true ? 0 : 40,
            top: 8,
            bottom: 4,
          ),
          decoration: BoxDecoration(
            color: messageData.iSent
                ? Colors.teal[800]
                : const Color.fromARGB(255, 8, 34, 32),
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(16),
              bottomRight: const Radius.circular(16),
              topLeft: Radius.circular(messageData.iSent == true ? 16 : 0),
              topRight: Radius.circular(messageData.iSent == true ? 0 : 16),
            ),
          ),
          child: SizedBox(
            child: Text(
              messageData.message,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 1, 10, 6),
          child: Text(
            DateFormat('hh:mm a').format(messageData.dateTime),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.teal,
            ),
          ),
        ),
      ],
    );
  }
}
