import 'package:flutter/material.dart';
import 'package:tutor_me/services/services/tutor_services.dart';
import 'package:tutor_me/src/colorpallete.dart';
import 'package:tutor_me/src/tuteeProfilePages/tutee_data.dart';
import '../../services/models/tutors.dart';
import '../chat/chat.dart';
// import 'package:tutor_me/modules/api.services.dart';
// import 'package:tutor_me/modules/tutors.dart';
// import 'tutorProfilePages/tutor_profile_view.dart';
// import 'Navigation/nav_drawer.dart';
// import 'tuteeProfilePages/tutee_data.dart';
// import 'theme/themes.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key, required this.user}) : super(key: key);

  final Tutee user;

  @override
  State<StatefulWidget> createState() {
    return ChatsState();
  }
}

class ChatsState extends State<Chats> {
  List<Tutors> tutors = List<Tutors>.empty();

  void getConnections() async {
    int conLength = widget.user.connections.length;
    for (int i = 0; i < conLength; i++) {
      final tutor = await TutorServices.getTutor(widget.user.connections[i]);
      setState(() {
        tutors += tutor;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
      child: SizedBox(
        child: ListView.builder(
          itemBuilder: _chatBuilder,
          itemCount: tutors.length,
        ),
      ),
    ));
  }

  Widget _chatBuilder(BuildContext context, int i) {
    String name = tutors[i].getName + ' ' + tutors[i].getLastName;
    return GestureDetector(
        child: Card(
          elevation: 7.0,
          // shape: RoundedRectangleBorder(
          //   side: const BorderSide(color: Colors.red, width: 1),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                    child: Text(name[0]), backgroundColor: colorTurqoise),
                title: Text(name),
                subtitle: const Text('Hi, how are you'),
                // trailing: ,
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Chat(user: tutors[i])));
        });
  }
}
