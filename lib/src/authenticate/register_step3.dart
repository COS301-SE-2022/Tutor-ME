import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:tutor_me/services/models/tutors.dart';
import 'package:tutor_me/services/services/tutor_services.dart';
import 'package:tutor_me/src/colorpallete.dart';
import 'package:tutor_me/src/tutor_page.dart';
import '../../services/models/tutees.dart';
import '../../services/services/tutee_services.dart';
import '../components.dart';
import '../tutee_page.dart';

// ignore: must_be_immutable
class RegisterStep3 extends StatefulWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RegisterStep3({Key? key}) : super(key: key);

  @override
  _RegisterStep3State createState() => _RegisterStep3State();
}

class _RegisterStep3State extends State<RegisterStep3> {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode dobFocusNode = FocusNode();
  final FocusNode genderFocusNode = FocusNode();
  final FocusNode institutionFocusNode = FocusNode();
  final FocusNode courseFocusNode = FocusNode();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  String toRegister = 'Tutor';
  late Tutors tutor;
  late Tutees tutee;

  // register() async {
  //   if (toRegister == "Tutor") {
  //     try {
  //       tutor = await TutorServices.registerTutor(
  //         firstNameController.text,
  //         lastNameController.text,
  //         dobController.text,
  //         genderController.text,
  //         institutionController.text,
  //         emailController.text,
  //         passwordController.text,
  //         // courseController.text,
  //         confirmPasswordController.text,
  //       );
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const TutorPage()),
  //       );
  //     } catch (e) {
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: const Text("One Or More Errors Occured"),
  //             content: Text(e.toString()),
  //             backgroundColor: colorWhite,
  //             titleTextStyle: TextStyle(
  //               color: colorOrange,
  //               fontSize: MediaQuery.of(context).size.height * 0.03,
  //               fontWeight: FontWeight.bold,
  //             ),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: const Text("Retry"),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   } else {
  //     try {
  //       tutee = await TuteeServices.registerTuee(
  //         firstNameController.text,
  //         lastNameController.text,
  //         dobController.text,
  //         genderController.text,
  //         institutionController.text,
  //         emailController.text,
  //         passwordController.text,
  //         confirmPasswordController.text,
  //       );

  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const TuteePage()),
  //       );
  //     } catch (e) {
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: const Text("One Or More Errors Occured"),
  //             content: Text(e.toString()),
  //             backgroundColor: colorWhite,
  //             titleTextStyle: TextStyle(
  //               color: colorOrange,
  //               fontSize: MediaQuery.of(context).size.height * 0.03,
  //               fontWeight: FontWeight.bold,
  //             ),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: const Text("Retry"),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   }
  // }

  List<String> items = [
    "University Of Pretoria",
    "Witswaterand University",
    "University of Johanesburg",
    "Northwest University",
    "Cape Town University",
    "Rhodes University",
  ];

  String? institution;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [Colors.black, Colors.transparent],
            ).createShader(rect),
            blendMode: BlendMode.darken,
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Pictures/register_login.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black54,
                        BlendMode.darken,
                      ))),
            ),
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Column(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Flexible(
                child: Text(
                  'Lets Continue...',
                  style: TextStyle(
                    color: colorWhite,
                    fontSize: MediaQuery.of(context).size.width * 0.12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Flexible(
                child: Text(
                  'Step 3/3 - Education',
                  style: TextStyle(
                    color: colorWhite,
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              TextInputField(
                icon: Icons.school,
                hint: 'Course',
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                inputController: courseController,
                // inputFocus: courseFocusNode,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.07,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.06,
                    right: MediaQuery.of(context).size.width * 0.01),
                child: DropdownButton<String>(
                  dropdownColor: colorOrange,
                  icon: Icon(Icons.arrow_drop_down,
                      color: colorWhite,
                      size: MediaQuery.of(context).size.width * 0.08),
                  style: TextStyle(
                    color: colorWhite,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                  hint: institution == null
                      ? Row(
                          children: [
                            const Icon(
                              Icons.school,
                              color: colorWhite,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            const Text('Select Institution',
                                style: TextStyle(color: colorWhite)),
                          ],
                        )
                      : Row(
                          children: [
                            const Icon(
                              Icons.school,
                              color: colorWhite,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            Text(
                              institution!,
                              style: const TextStyle(color: colorWhite),
                            ),
                          ],
                        ),
                  isExpanded: true,
                  value: institution,
                  items: items.map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.house_outlined,
                              color: colorWhite,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            Text(val),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        institution = val;
                      },
                    );
                  },
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[500]!.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorOrange,
                    width: 1,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  '',
                  style: TextStyle(
                    color: colorWhite,
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: colorOrange,
                ),
                child: TextButton(
                  onPressed: () async {
                    String errMsg = "";
                    if (institution == null) {
                      institution = "";
                    } else {
                      institution = institution!.substring(0, 1);
                    }
                    if (institution == "" || courseController.text == "") {
                      errMsg += "ERROR: One or more parametres missing\n";
                    } else {}

                    if (errMsg != "") {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("One Or More Errors Occured"),
                            content: Text(errMsg),
                            backgroundColor: colorWhite,
                            titleTextStyle: TextStyle(
                              color: colorOrange,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
                                  "Retry",
                                  style: TextStyle(color: colorWhite),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TuteePage()),
                      );
                    }
                  },
                  child: Text("Register",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
