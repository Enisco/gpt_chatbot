// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gpt_chatbot/app/constants/constants.dart';
import 'package:gpt_chatbot/app/models/message_model.dart';
import 'package:gpt_chatbot/ui/chat_page.dart/widgets/message_widget.dart';
import 'package:gpt_chatbot/util/screen_size.dart';
import 'package:gpt_chatbot/util/spacer.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final typingNotifier = ValueNotifier<bool>(false);
  List<MessageModel> chatMesages = [];

  final openAI = OpenAI.instance.build(token: chatGptApiKey);

  /// Sends user message to ChatGPT
  Future<String> sendAIMessage(String message) async {
    final request = CompleteText(
      prompt: message,
      model: Model.textDavinci3,
      maxTokens: 200,
    );

    final response = await openAI.onCompletion(
      request: request,
    );
    return response!.choices.first.text;
  }

  /// Adds new user message to chat mesages list,
  /// then sends the message to ChatGPT.
  sendMessage(String message) async {
    if (message.trim().isNotEmpty) {
      final newMessageData = MessageModel(
        message: message.trim(),
        dateTime: DateTime.now(),
        iSent: true,
      );
      chatMesages.add(newMessageData);
      setState(() {});

      String response = await sendAIMessage(
        "Give me a sweet, lovely response to the message: $message",
      );

      final newRespMessageData = MessageModel(
        message: response.trim(),
        dateTime: DateTime.now(),
        iSent: false,
      );
      if (mounted) {
        setState(() {
          chatMesages.add(newRespMessageData);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My AI"),
        ),
        body: SizedBox(
          child: Builder(
            builder: (context) {
              if (_scrollController.hasClients) {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent + 65);
              }
              return Column(
                children: [
                  customVerticalSpacer(2),
                  Expanded(
                    child: Container(
                      child: chatMesages.isNotEmpty
                          ? ListView.builder(
                              padding: const EdgeInsets.fromLTRB(5, 20, 0, 10),
                              itemCount: chatMesages.length,
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                return MessageWidget(
                                  messageData: chatMesages[index],
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: typingNotifier,
                    builder: (context, value, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 10,
                            ),
                            width: screenWidth(context) - 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.teal),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: TextField(
                                      controller: messageController,
                                      maxLines: 3,
                                      minLines: 1,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        hintText: "Write something . . .",
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        if (messageController.text
                                            .trim()
                                            .isNotEmpty) {
                                          typingNotifier.value = true;
                                        } else {
                                          typingNotifier.value = false;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (typingNotifier.value) {
                                      String msg =
                                          messageController.text.trim();

                                      /// Send message
                                      sendMessage(msg);
                                      messageController.clear();
                                      typingNotifier.value = false;
                                    } else {
                                      print("Nothing to send");
                                    }
                                  },
                                  child: typingNotifier.value
                                      ? Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Icon(
                                            Icons.send_outlined,
                                            color: Colors.teal[700],
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
