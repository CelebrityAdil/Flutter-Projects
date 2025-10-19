import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:food_app/home_screen.dart';
import 'package:http/http.dart' as http;

// 🔹 Replace with your own local/Ngrok FastAPI URL
const String CHATBOT_SERVER_URL =
    "https://untameable-shanita-unusurping.ngrok-free.dev";

// ---------------- Helper Functions ----------------

String detectIntentFromText(String text) {
  text = text.toLowerCase();
  if (text.contains("add") || text.contains("want") || text.contains("order")) {
    return "order.add";
  } else if (text.contains("remove") || text.contains("delete")) {
    return "order.remove";
  } else if (text.contains("complete") ||
      text.contains("place") ||
      text.contains("done")) {
    return "order.complete";
  } else if (text.contains("track") || text.contains("status")) {
    return "track_order-context: ongoing-tracking";
  } else {
    return "order.add"; // Default fallback
  }
}

Map<String, dynamic> extractParameters(String text) {
  RegExp numberExp = RegExp(r'\d+');
  List<int> numbers = numberExp
      .allMatches(text)
      .map((m) => int.parse(m.group(0)!))
      .toList();

  String withoutNumbers = text.replaceAll(numberExp, '');
  List<String> foodItems = withoutNumbers
      .split(RegExp(r'\s+'))
      .where(
        (word) =>
            word.isNotEmpty &&
            ![
              "add",
              "order",
              "remove",
              "delete",
              "complete",
              "place",
              "track",
            ].contains(word.toLowerCase()),
      )
      .toList();

  if (foodItems.isEmpty) foodItems = ["item"];
  if (numbers.isEmpty) numbers = [1];

  return {"food-item": foodItems, "number": numbers};
}

Future<String> sendMessageToServer(String text, String sessionId) async {
  String intentName = detectIntentFromText(text);
  Map<String, dynamic> parameters = extractParameters(text);

  final Map<String, dynamic> payload = {
    "queryResult": {
      "intent": {"displayName": intentName},
      "parameters": parameters,
      "outputContexts": [
        {
          "name":
              "projects/demo-agent/agent/sessions/$sessionId/contexts/order",
        },
      ],
    },
  };

  try {
    final response = await http.post(
      Uri.parse(CHATBOT_SERVER_URL),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded["fulfillmentText"] ??
          "Sorry, I didn’t get any response from server.";
    } else {
      return "Server Error: ${response.statusCode}";
    }
  } catch (e) {
    return "Network Error: Could not connect to server.\nError: $e";
  }
}

// ---------------- Chat Screen ----------------

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  String sessionId = 'user-${Random().nextInt(100000)}';

  @override
  void initState() {
    super.initState();
    _addMessage(
      ChatMessage(
        text: 'Hello! I\'m your food order bot. How can I help you today?',
        isUser: false,
      ),
    );
  }

  void _addMessage(ChatMessage message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  // ---------------- Send Message ----------------
  Future<void> _handleSubmitted(String text) async {
    if (text.isEmpty) return;

    _textController.clear();
    _addMessage(ChatMessage(text: text, isUser: true));

    setState(() {
      _isTyping = true;
    });

    String botReply = await sendMessageToServer(text, sessionId);

    _addMessage(ChatMessage(text: botReply, isUser: false));

    setState(() {
      _isTyping = false;
    });
  }

  // ---------------- Input Field ----------------
  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: _isTyping
                  ? null
                  : () => _handleSubmitted(_textController.text),
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Chatbot'),
        backgroundColor: Colors.green.shade600,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index].isUser
                  ? _buildUserMessage(_messages[index].text)
                  : _buildBotMessage(_messages[index].text),
              itemCount: _messages.length,
            ),
          ),
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Bot is typing...',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}

// ---------------- Message Bubbles ----------------

Widget _buildUserMessage(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.green.shade500,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Text(text, style: const TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(width: 8.0),
        const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.person, color: Colors.white, size: 20),
        ),
      ],
    ),
  );
}

Widget _buildBotMessage(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: const Icon(Icons.android, color: Colors.green, size: 20),
        ),
        const SizedBox(width: 8.0),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Text(text, style: const TextStyle(color: Colors.black87)),
          ),
        ),
      ],
    ),
  );
}
