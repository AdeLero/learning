import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_learning/Medwiz/bloc/chat_bloc.dart';
import 'package:my_learning/Medwiz/models/chat_message_model.dart';
import 'package:my_learning/Medwiz/utils/call.dart';
import 'package:my_learning/Medwiz/widgets/image_picker.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/custom_Button.dart';
import 'package:my_learning/customizations/custom_widgets/custom_textbox.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatBloc chatBloc = ChatBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {},
        builder: (context, state) {
          List<ChatMessage> messages = state is ChatSuccessState
              ? state.messages
              : (state as ChatTypingState).messages ?? <ChatMessage>[];
          TextEditingController textController = TextEditingController(text: state is ChatTypingState ? state.text : "");
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'lib/assets/images/Medwiz_chat_background.png',
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 36, left: 12, right: 12, bottom: 8),
                  color: TheColors.white,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      XMargin(8),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: TheColors.paleBlue,
                      ),
                      XMargin(8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Medwiz Bot',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            "This is what you're chatting about",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final lastPart = message.parts.lastOrNull;
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: message.role == "user"
                                ? TheColors.wine
                                : TheColors.mustard,
                          ),
                          child: lastPart is TextChatPart
                              ? Text(lastPart.text)
                              : lastPart is FileData
                              ? lastPart.fileData != null
                              ? Image.file(File(lastPart.fileData!.fileLocation!))
                              : Text("Unsupported file type")
                              : Text("Unknown part"),
                        );
                      }),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  color: TheColors.paleBlue,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            if (state is ChatTypingState)
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(state.filePath!),
                                    ),
                                  ),
                                ),
                              ),
                            CustomTextbox(
                              borderRadius: 40,
                              controller: textController,
                              prefixIcon: Icons.attach_file_rounded,
                              prefixIconColor: TheColors.grey,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(context: context, builder: (context) {
                                    return ImageSelector(onImageSelected: (File image) {
                                      chatBloc.add(
                                        PickFile(
                                          filePath: image.path,
                                          text: textController.text,
                                        ),
                                      );
                                    });
                                  });
                                },
                                icon: const Icon(
                                  Icons.image_rounded,
                                ),
                              ),
                              suffixIconColor: TheColors.black,
                              hintText: 'Ask Medwiz Something...',
                              hintTextStyle: TextStyle(
                                  color: TheColors.grey,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      XMargin(8),
                      CustomButton(
                        onTap: () {
                          if (state is ChatTypingState) {
                            String filePath = state.filePath!;
                            String text = state.text!;
                            chatBloc.add(GenerateNewChatMessageEvent(inputMessage: text, filePath: filePath));
                          }
                          else if (textController.text.isNotEmpty) {
                            String text = textController.text;
                            textController.clear();
                            chatBloc.add(
                              GenerateNewChatMessageEvent(inputMessage: text,),
                            );
                          }
                        },
                        prefixIcon: Icons.send_rounded,
                        prefixIconColor: TheColors.white,
                        prefixIconSize: 24,
                        buttonColor: TheColors.deepGreen,
                      ),
                      XMargin(8),
                      CustomButton(
                        onTap: () {
                          makePhoneCall(phoneNumber);
                        },
                        prefixIcon: Icons.call,
                        prefixIconColor: TheColors.white,
                        prefixIconSize: 24,
                        buttonColor: TheColors.mustard,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
