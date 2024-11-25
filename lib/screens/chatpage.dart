import 'package:comet/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart'; // Make sure this is the correct import path for your ApiService

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieverID;
  final String recieverUserName;

  const ChatPage({
    super.key,
    required this.recieverEmail,
    required this.recieverID,
    required this.recieverUserName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  final List<Map<String, dynamic>> _messages = [];
  final ApiService _apiService = ApiService(); // Initialize the API service

  bool isLoading = false; // Track loading state

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollcontroller = ScrollController();

  void scrollDown() {
    _scrollcontroller.animateTo(_scrollcontroller.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  // Updated _sendMessage function to call API
Future<void> _sendMessage({String? fileUrl}) async {
  String message = _messageController.text.trim();
  if (message.isNotEmpty || fileUrl != null) {
    setState(() {
      isLoading = true;
      // Add user message to chat
      _messages.add({
        'senderID': 'currentUser',
        'message': message,
        'fileUrl': fileUrl,
      });
    });

    print('Received message: $message'); // Debugging statement

    if (message.toLowerCase().contains('college')) {
      // Extract the last two words
      List<String> words = message.split(" ");
      String collegeName = words.length >= 2 
          ? "${words[words.length - 2]} ${words[words.length - 1]}"
          : words.last;

      print('Extracted college name: $collegeName'); // Debugging statement

      var collegeDetails = await _apiService.fetchCollegeData();
      print('College details: $collegeDetails'); // Debugging statement

      var collegeInfo = collegeDetails.firstWhere(
        (college) => (college['University'] as String?)?.toLowerCase() == collegeName.toLowerCase(),
        orElse: () => {}, // Empty map if no match
      );

      if (collegeInfo.isNotEmpty) {
        String responseMessage = '''
College: ${collegeInfo['University']}
Course Fees: ${collegeInfo['Course Fees']}
Hostel Fees: ${collegeInfo['Hostel Fees']}
Total Fees: ${collegeInfo['Total Fees']}
Placement Rate: ${collegeInfo['Placement Rate']}
Average Salary: ${collegeInfo['Average Salary']}
        ''';

        setState(() {
          isLoading = false; // Stop loading spinner
          _messages.add({
            'senderID': 'bot',
            'message': responseMessage,
            'fileUrl': null,
          });
        });
      } else {
        setState(() {
          isLoading = false; // Stop loading spinner
          _messages.add({
            'senderID': 'bot',
            'message': "Sorry, I couldn't find details for the specified college.",
            'fileUrl': null,
          });
        });
      }
    } else {
      setState(() {
        isLoading = false; // Stop loading spinner
        _messages.add({
          'senderID': 'bot',
          'message': "Hi, I am here to help!!",
          'fileUrl': null,
        });
      });
    }
    _messageController.clear();
    scrollDown();
  }
}


  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 5,),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextField(
                enabled: true,
                style: const TextStyle(color: Vx.white, fontSize: 16),
                controller: _messageController,
                decoration: InputDecoration(
                  fillColor: Vx.red500,
                  hintText: "Type a message...",
                  hintStyle: const TextStyle(color: Vx.gray300, fontWeight: FontWeight.w300),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                focusNode: myFocusNode,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(right: 7, left: 12),
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => _sendMessage(),
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white, // Force the color to white
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Vx.gray400,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            widget.recieverUserName,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: Vx.blue200,), // Show loading spinner
                    )
                  : ListView.builder(
                      controller: _scrollcontroller,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final data = _messages[index];
                        bool isCurrentUser = data['senderID'] == 'currentUser';
                        var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

                        return Container(
                          alignment: alignment,
                          child: ChatBubble(
                            message: data["message"],
                            isCurrentUser: isCurrentUser,
                          ),
                        );
                      },
                    ),
            ),
            _buildUserInput(),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({super.key, 
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: isCurrentUser ? 60 : 8,
          right: isCurrentUser ? 8 : 60),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.blue[200] : Colors.grey[300],
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser ? Vx.black : Vx.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
