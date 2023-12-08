import 'package:bloc/bloc.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

List<Message> messageList = [];
  void sendMessage({required String message , required String email}) {
    messages.add(
          {'message': message, 'createdAt': DateTime.now(), 'id': email});
    
  }

  void getMessage () {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      messageList.clear();

      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc));
      }

      emit(ChatSuccess(messages: messageList));
    });

  }

  void iconSendMessage({required String enterMessage , required controller , required String email}) {

      messages.add(
          {'message': enterMessage, 'createdAt': DateTime.now(), 'id': email});
      controller.clear();
      enterMessage = '';

    }
}
