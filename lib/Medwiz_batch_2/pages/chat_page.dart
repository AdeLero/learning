import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning/Medwiz_batch_2/bloc/mchat_bloc.dart';
import 'package:my_learning/Medwiz_batch_2/models/message_model.dart';
import 'package:my_learning/customizations/colors.dart';
import 'package:my_learning/customizations/custom_widgets/custom_Button.dart';
import 'package:my_learning/customizations/custom_widgets/custom_textbox.dart';
import 'package:my_learning/customizations/custom_widgets/margins.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageInput = TextEditingController();
  final MchatBloc chatBloc = MchatBloc();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    messageInput.dispose();
    _scrollController.dispose();
    chatBloc.close();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocConsumer<MchatBloc, MchatState>(
          bloc: chatBloc,
          listener: (context, state) {
            if (state is MchatSuccessState) {
              _scrollToBottom();
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case MchatSuccessState:
                List<MessageModel> messages =
                    (state as MchatSuccessState).messages;
                return Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
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
                        height: 100,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        color: TheColors.white,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: 48,
                              ),
                            ),
                            const XMargin(10),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: TheColors.paleBlue,
                            ),
                            const XMargin(10),
                            const Column(
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: messages.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              final isUser = message.role == "User";
                              return Align(
                                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5,
                                        offset: Offset(-1, 1),
                                        color: TheColors.grey.withOpacity(0.5),
                                      )
                                    ],
                                    color: message.role == "User"
                                        ? TheColors.wine
                                        : TheColors.mustard,
                                  ),
                                  child: Text(message.text),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        color: TheColors.paleBlue,
                        height: 60,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextbox(
                                controller: messageInput,
                                prefixIcon: Icons.attach_file_outlined,
                                prefixIconColor: TheColors.grey,
                                prefixIconSize: 16,
                                hintText: 'Ask Medwiz Something...',
                                hintTextStyle: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: TheColors.grey,
                                ),
                                suffixIcon: Icon(Icons.cancel_outlined),
                              ),
                            ),
                            XMargin(10),
                            CustomButton(
                              onTap: () {
                                if (messageInput.text.isNotEmpty) {
                                  final String input = messageInput.text;
                                  messageInput.clear();
                                  chatBloc
                                      .add(SendNewMessage(messageInput: input));
                                }
                              },
                              buttonColor: TheColors.firmGreen,
                              suffixIcon: Icons.send_outlined,
                              suffixIconColor: TheColors.white,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              default:
                return const SizedBox();
            }
          }),
    );
  }
}
