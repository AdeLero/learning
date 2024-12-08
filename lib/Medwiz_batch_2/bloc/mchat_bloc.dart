import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_learning/Medwiz_batch_2/models/message_model.dart';

part 'mchat_event.dart';
part 'mchat_state.dart';

class MchatBloc extends Bloc<MchatEvent, MchatState> {
  MchatBloc() : super(MchatSuccessState(messages: [])) {
    on<SendNewMessage>(sendNewMessage);
  }

  final List<MessageModel> messages = [];

  FutureOr<void> sendNewMessage(
      SendNewMessage event, Emitter<MchatState> emit) async {
    messages.add(MessageModel(role: "User", text: event.messageInput));
    emit(MchatSuccessState(messages: messages));
  }
}
