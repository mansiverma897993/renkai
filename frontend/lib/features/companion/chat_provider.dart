import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final List<String>? options;
  final bool isLoading;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.options,
    this.isLoading = false,
  });

  ChatMessage copyWith({String? text, bool? isLoading}) {
    return ChatMessage(
      text: text ?? this.text,
      isUser: this.isUser,
      options: this.options,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  late final GenerativeModel _model;
  late final ChatSession _chat;

  ChatNotifier() : super([
    ChatMessage(
      text: "Hi Sage,\nHow would you like me to assist you today?",
      isUser: false,
      options: [
        "Mental Health Assessment Test",
        "Book A Therapy",
        "Emergency Support",
        "Have a chat 😅"
      ],
    )
  ]) {
    _initGemini();
  }

  void _initGemini() {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system("You are Renki, a compassionate, empathetic, and professional mental health AI companion in the Renkai app. Speak in a warm, calming tone. Keep your responses relatively concise but highly supportive."),
    );
    _chat = _model.startChat();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    final userMsg = ChatMessage(text: text, isUser: true);
    // Add empty loading bot message
    final botMsg = ChatMessage(text: "", isUser: false, isLoading: true);
    
    state = [...state, userMsg, botMsg];

    try {
      final responseStream = _chat.sendMessageStream(Content.text(text));
      
      await for (final chunk in responseStream) {
        if (chunk.text != null) {
          _updateLastBotMessage(chunk.text!);
        }
      }
      _finalizeLastBotMessage();
    } catch (e) {
      _updateLastBotMessage("I'm sorry, I seem to be having trouble connecting to my servers right now.");
      _finalizeLastBotMessage();
    }
  }

  void _updateLastBotMessage(String newTextChunk) {
    var newState = List<ChatMessage>.from(state);
    var lastMsg = newState.last;
    newState[newState.length - 1] = lastMsg.copyWith(
      text: lastMsg.text + newTextChunk,
    );
    state = newState;
  }

  void _finalizeLastBotMessage() {
    var newState = List<ChatMessage>.from(state);
    var lastMsg = newState.last;
    newState[newState.length - 1] = lastMsg.copyWith(isLoading: false);
    state = newState;
  }
}

final aiChatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  return ChatNotifier();
});
