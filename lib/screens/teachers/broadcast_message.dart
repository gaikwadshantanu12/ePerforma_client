import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/middleware/teachers/teacher_mw.dart';
import 'package:student_performance_monitoring_app/models/batches/batch_detail.dart';
import 'package:student_performance_monitoring_app/models/messages/messages_detail.dart';

class BroadcastMessages extends StatefulWidget {
  const BroadcastMessages({super.key});

  @override
  State<BroadcastMessages> createState() => _BroadcastMessagesState();
}

class _BroadcastMessagesState extends State<BroadcastMessages> {
  late BatchDetails _batchDetails;
  List<MessagesDetails> messages = [];

  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _batchDetails = ModalRoute.of(context)!.settings.arguments as BatchDetails;
    fetchMessages();
  }

  void fetchMessages() {
    TeachersMiddleWare.getMessagesByTeacherID(_batchDetails.teacherID)
        .then((messagesList) {
      setState(() {
        messages = messagesList;
      });
    });
  }

  void sendMessage(MessagesDetails details) {
    TeachersMiddleWare.broadcastMessage(details, context).then((value) {
      setState(() {
        messages.add(details);
        _messageController.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'Broadcast Message',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Display past messages
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index].message),
                  subtitle:
                      Text("${messages[index].date} - ${messages[index].time}"),
                );
              },
            ),
          ),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration:
                      const InputDecoration(hintText: 'Type your message'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  setState(() {
                    DateTime dateTime = DateTime.now();

                    MessagesDetails details = MessagesDetails(
                      teacherID: _batchDetails.teacherID,
                      message: _messageController.text.trim(),
                      date: dateTime.toString().split(" ")[0],
                      time: dateTime.toString().split(" ")[1],
                    );
                    sendMessage(details);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
