part of 'mchat_bloc.dart';

@immutable
sealed class MchatState {}

final class MchatInitial extends MchatState {}

class MchatSuccessState extends MchatState {
  final List<MessageModel> messages;

  MchatSuccessState({required this.messages});
}
