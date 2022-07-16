import 'package:flutter/material.dart';
import 'package:tutor_me/src/colorpallete.dart';
// import 'package:tutor_me/src/colorPalette.dart';
//import 'package:tutor_me/src/tuteeProfilePages/edit_tutee_profile_page.dart';

// import 'package:tutor_me/src/tutorProfilePages/tutor_profile_edit.dart';
import 'package:tutor_me/src/tutorProfilePages/user_stats.dart';
import '../../services/models/modules.dart';
import '../../services/models/tutees.dart';
import '../../services/services/tutee_services.dart';
import '../components.dart';
import 'edit_module_list.dart';
import 'tutee_profile_edit.dart';

// ignore: must_be_immutable
class TuteeProfilePage extends StatefulWidget {
  final Tutees user;
  const TuteeProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _TuteeProfilePageState createState() => _TuteeProfilePageState();
}

class _TuteeProfilePageState extends State<TuteeProfilePage> {
  List<Modules> currentModules = List<Modules>.empty();
  late int numConnections;
  late int numTutees;
  getCurrentModules() async {
    final current = await TuteeServices.getTuteeModules(widget.user.getId);
    setState(() {
      currentModules = current;
    });
  }

  int getNumConnections() {
    var allConnections = widget.user.getConnections.split(',');

    return allConnections.length;
  }

  int getNumTutees() {
    var allTutees = widget.user.getTutorsCode.split(',');

    return allTutees.length;
  }

  @override
  void initState() {
    super.initState();
    getCurrentModules();
    numConnections = getNumConnections();
    numTutees = getNumTutees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        topDesign(),
        // readyToTutor(),
        buildBody(),
      ],
    ));
  }

  Widget topDesign() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 78),
            child: buildCoverImage()),
        Positioned(
          top: 100,
          child: buildProfileImage(),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.17,
          left: MediaQuery.of(context).size.height * 0.42,
          child: GestureDetector(
            onTap: (() => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TuteeProfileEdit(
                          user: widget.user,
                        )))),
            child: Icon(
              Icons.edit,
              color: colorOrange,
              size: MediaQuery.of(context).size.height * 0.05,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: const Image(
          image: AssetImage('assets/Pictures/tuteeCover.jpg'),
          width: double.infinity,
          height: 150,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: const AssetImage("assets/Pictures/penguin.png"),
      );

  Widget buildEditImageIcon() => const CircleAvatar(
        radius: 18,
        backgroundColor: colorOrange,
        child: Icon(
          Icons.camera_enhance,
          color: Colors.white,
        ),
      );

  Widget buildBody() {
    final screenWidthSize = MediaQuery.of(context).size.width;
    final screenHeightSize = MediaQuery.of(context).size.height;
    String name = widget.user.getName + ' ' + widget.user.getLastName;
    String personalInfo = name + '(' + widget.user.getAge + ')';
    String courseInfo =
        widget.user.getCourse + ' | ' + widget.user.getInstitution;
    String gender = "";
    if (widget.user.getGender == "F") {
      gender = "Female";
    } else {
      gender = "Male";
    }
    return Column(children: [
      Text(
        personalInfo,
        style: TextStyle(
          fontSize: screenWidthSize * 0.08,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      SmallTagButton(
        btnName: "Tutee",
        onPressed: () {},
        backColor: colorOrange,
      ),
      SizedBox(height: screenHeightSize * 0.01),
      Text(
        courseInfo,
        style: TextStyle(
          fontSize: screenWidthSize * 0.04,
          fontWeight: FontWeight.normal,
          color: colorTurqoise,
        ),
      ),
      SizedBox(height: screenHeightSize * 0.02),
      const UserStats(
        rating: "1",
        numTutees: 2,
        numConnections: 23,
      ),
      SizedBox(height: screenHeightSize * 0.02),
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(
            left: screenWidthSize * 0.06,
            top: screenHeightSize * 0.03,
          ),
          child: Text(
            "About Me",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: screenWidthSize * 0.065,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          left: screenWidthSize * 0.06,
          top: screenHeightSize * 0.01,
          bottom: screenWidthSize * 0.06,
        ),
        child: Text(widget.user.getBio,
            style: TextStyle(
              fontSize: screenWidthSize * 0.05,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            )),
      ),
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(
            left: screenWidthSize * 0.06,
          ),
          child: Text("Gender",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: screenWidthSize * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(
            right: screenWidthSize * 0.06,
            left: screenWidthSize * 0.06,
            top: screenHeightSize * 0.02,
            bottom: screenHeightSize * 0.04,
          ),
          child: Text(gender,
              style: TextStyle(
                fontSize: screenWidthSize * 0.05,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              )),
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(
            left: screenWidthSize * 0.06,
            // top: 16,
          ),
          child: Text("Modules I Have",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: screenWidthSize * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(
            left: screenWidthSize * 0.06,
            right: screenWidthSize * 0.06,
            top: screenHeightSize * 0.02,
          ),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: _moduleListBuilder,
            itemCount: currentModules.length,
          ),
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Padding(
            padding: EdgeInsets.only(
              left: screenWidthSize * 0.1,
              right: screenWidthSize * 0.1,
              top: screenHeightSize * 0.03,
              bottom: screenHeightSize * 0.03,
            ),
            child: SmallTagBtn(
              btnName: "Edit Module list",
              backColor: colorOrange,
              funct: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditModuleList(user: widget.user)));
              },
            )),
      ),
    ]);
  }

  Widget _moduleListBuilder(BuildContext context, int i) {
    String moduleDescription =
        currentModules[i].getModuleName + '(' + currentModules[i].getCode + ')';
    return Row(
      children: [
        Icon(
          Icons.book,
          size: MediaQuery.of(context).size.height * 0.02,
          color: colorTurqoise,
        ),
        Text(
          moduleDescription,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class SmallTagBtn extends StatelessWidget {
  const SmallTagBtn({
    Key? key,
    required this.btnName,
    required this.backColor,
    required this.funct,
  }) : super(key: key);
  final String btnName;

  final Color backColor;
  final Function() funct;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.05,
      width: size.width * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: backColor,
      ),
      child: TextButton(
        onPressed: funct,
        child: Text(
          btnName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
