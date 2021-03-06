import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tutor_me/src/colorpallete.dart';
import 'package:tutor_me/src/tutorProfilePages/tutor_profile_edit.dart';
import 'package:tutor_me/src/tutorProfilePages/user_stats.dart';

import '../../services/models/modules.dart';
import '../../services/models/tutors.dart';
import '../../services/services/tutor_services.dart';
import '../components.dart';
import '../tuteeProfilePages/edit_module_list.dart';

class ToReturn {
  Uint8List image;
  Tutors user;
  ToReturn(this.image, this.user);
}

// ignore: must_be_immutable
class TutorSettingsProfileView extends StatefulWidget {
  Tutors user;
  Uint8List image;
  bool imageExists;
  TutorSettingsProfileView(
      {Key? key,
      required this.user,
      required this.image,
      required this.imageExists})
      : super(key: key);

  @override
  _TutorSettingsProfileViewState createState() =>
      _TutorSettingsProfileViewState();
}

class _TutorSettingsProfileViewState extends State<TutorSettingsProfileView> {
  List<Modules> currentModules = List<Modules>.empty();
  late int numConnections;
  late int numTutees;
  bool _isLoading = true;

  getCurrentModules() async {
    final current = await TutorServices.getTutorModules(widget.user.getId);
    setState(() {
      currentModules = current;
      _isLoading = false;
    });
  }

  int getNumConnections() {
    var allConnections = widget.user.getConnections.split(',');

    return allConnections.length;
  }

  int getNumTutees() {
    var allTutees = widget.user.getTuteesCode.split(',');

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
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : WillPopScope(
                onWillPop: () async {
                  Navigator.pop(context, ToReturn(widget.image, widget.user));
                  return false;
                },
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    topDesign(),
                    // readyToTutor(),
                    buildBody(),
                  ],
                ),
              ));
  }

  Widget buildBody() {
    final screenWidthSize = MediaQuery.of(context).size.width;
    final screenHeightSize = MediaQuery.of(context).size.height;
    String userName = widget.user.getName + ' ' + widget.user.getLastName;
    String courseInfo =
        widget.user.getCourse + ' | ' + widget.user.getInstitution;
    String personalDets = userName + '(' + widget.user.getAge + ')';
    String gender = "";
    if (widget.user.getGender == "F") {
      gender = "Female";
    } else {
      gender = "Male";
    }
    return Column(children: [
      Text(
        personalDets,
        style: TextStyle(
          fontSize: screenWidthSize * 0.08,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      SmallTagButton(
        btnName: "Tutor",
        onPressed: () {},
        backColor: colorTurqoise,
      ),
      SizedBox(height: screenHeightSize * 0.01),
      Text(
        courseInfo,
        style: TextStyle(
          fontSize: screenWidthSize * 0.04,
          fontWeight: FontWeight.normal,
          color: colorOrange,
        ),
      ),
      SizedBox(height: screenHeightSize * 0.02),
      UserStats(
        rating: widget.user.getRating,
        numTutees: numTutees,
        numConnections: numConnections,
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
      SizedBox(
        width: double.infinity,
        child: Padding(
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
          child: Text("Modules I tutor",
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
            top: screenHeightSize * 0,
          ),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, index) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02);
            },
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
              funct: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditModuleList(user: widget.user)),
                );
                getCurrentModules();
              },
            )),
      ),
    ]);
  }

  Widget topDesign() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height * 0.25,
            margin: const EdgeInsets.only(bottom: 78),
            child: buildCoverImage()),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.18,
          child: buildProfileImage(),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.17,
          left: MediaQuery.of(context).size.height * 0.42,
          child: GestureDetector(
            onTap: () async {
              final results = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TutorProfileEdit(user: widget.user,image: widget.image,imageExists: widget.imageExists)));

              setState(() {
                widget.image = results.image;
                widget.user = results.user;
              });
            },
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
          image: AssetImage('assets/Pictures/tutorCover.jpg'),
          width: double.infinity,
          height: 150,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.127,
        child: widget.imageExists
            ? ClipOval(
                child: Image.memory(
                  widget.image,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.253,
                  height: MediaQuery.of(context).size.width * 0.253,
                ),
              )
            : ClipOval(
                child: Image.asset(
                "assets/Pictures/penguin.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.253,
                height: MediaQuery.of(context).size.width * 0.253,
              )),
      );

  Widget buildEditImageIcon() => const CircleAvatar(
        radius: 18,
        backgroundColor: colorOrange,
        child: Icon(
          Icons.camera_enhance,
          color: Colors.white,
        ),
      );

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
        Expanded(
          child: Text(
            moduleDescription,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    Widget ok = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('OK'));

    AlertDialog requestAlert = AlertDialog(
        title: const Text("Alert"),
        content: const Text("Your request has been sent!!"),
        actions: [
          ok,
        ]);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return requestAlert;
        });
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
