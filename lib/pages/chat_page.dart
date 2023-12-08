import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  static String routeName = 'chat page';

  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _enterMessage = "";

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kprimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              klogo,
              height: 50,
            ),
            const Text(' Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messageList = BlocProvider.of<ChatCubit>(context).messageList;
                return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) =>
                      messageList[index].id == email
                          ? ChatBubble(messageList[index])
                          : ChatBubbleFromFriend(messageList[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                _enterMessage = value;
              },
                    controller: controller,
                    onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).sendMessage(message: data, email: email);
                controller.clear();
                
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: kprimaryColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                suffixIcon: BlocListener<ChatCubit, ChatState>(
                  listener: (context, state) {
                    var messageList = BlocProvider.of<ChatCubit>(context).messageList;
                    if (state is ChatSuccess) {
                  messageList = state.messages;
                }
                  },
                  child: IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: kprimaryColor,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<ChatCubit>(context).iconSendMessage(enterMessage: _enterMessage, controller: controller, email: email);
                                  },
                                ),
                ),
                hintText: 'Send Message',
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}
