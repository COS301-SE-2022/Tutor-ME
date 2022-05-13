import 'package:flutter/material.dart';
// import 'package:tutor_me/src/colorPalette.dart';
import 'package:tutor_me/src/tuteeProfilePages/edit_tutee_profile_page.dart';

class TutorProfilePageView extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  TutorProfilePageView(
      {Key? key,
      required this.person,
      required String this.bio,
      required String this.age,
      required String this.location,
      required String this.gender})
      : super(key: key);
  final String person;
  final String bio;
  final String age;
  final String location;
  final String gender;

  static const String route = '/tutor_profile_view';

  @override
  _TutorProfilePageViewState createState() => _TutorProfilePageViewState();
}

class _TutorProfilePageViewState extends State<TutorProfilePageView> {
  @override
  Widget build(BuildContext context) {
    // Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 170,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Pictures/flower.jpg"),
                      fit: BoxFit.fill)),
              child: Container(
                padding: const EdgeInsets.only(top: 60, left: 140),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        // text: "Rose Tumil",
                        // style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: widget.person,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 6.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepOrangeAccent),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: null,
                      child: const Text("Tutee"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 95,
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width - 220,
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage("assets/Pictures/profilePic.jpg")),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    spreadRadius: 5,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width - 270,
              margin: const EdgeInsets.symmetric(
                horizontal: 0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                // ignore: prefer_const_constructors
                color: Color.fromRGBO(214, 82, 7, 1),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 15,
                    spreadRadius: 5,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 200,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 160,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditTuteeProfilePage()),
                  );
                },
                child: const Icon(
                  Icons.edit_note,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black.withOpacity(0))),
              ),
            ),
          ),
          Positioned(
            top: 220,
            left: 55,
            child: Container(
              height: 120,
              width: 170,
              margin: const EdgeInsets.all(15.0),
              // padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrangeAccent),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          children: [
                        const WidgetSpan(child: Icon(Icons.location_pin)),
                        TextSpan(
                            text: widget.location,
                            style: const TextStyle(fontSize: 15)),
                        const WidgetSpan(child: Icon(Icons.transgender)),
                        TextSpan(
                            text: widget.gender,
                            style: const TextStyle(fontSize: 15)),
                        const WidgetSpan(child: Icon(Icons.calendar_month)),
                        TextSpan(
                            text: widget.age,
                            style: const TextStyle(fontSize: 15)),
                        const WidgetSpan(
                            child: Icon(
                          Icons.book,
                        )),
                        const TextSpan(
                            text: 'University Of Pretoria\n',
                            style: TextStyle(fontSize: 15)),
                      ],
                          style: const TextStyle(
                            color: Colors.black,
                          ))),
                ],
              ),
            ),
          ),
          Positioned(
            top: 380,
            left: 30,
            child: Container(
              height: 30,
              width: 255,
              color: Colors.black54,
              child: Column(children: [
                RichText(
                    text: const TextSpan(
                        text: "Bio",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        )))
              ]),
            ),
          ),
          Positioned(
            top: 420,
            left: 30,
            child: SizedBox(
              height: 60,
              width: 255,
              // color: Colors.black38,
              child: Column(children: [
                RichText(
                    text: TextSpan(
                        text: widget.bio,
                        style: const TextStyle(
                          color: Colors.black,
                        )))
              ]),
            ),
          ),
          Positioned(
            top: 490,
            left: 30,
            child: Container(
              height: 30,
              width: 255,
              color: Colors.black54,
              child: Column(children: [
                RichText(
                    text: const TextSpan(
                        text: "Modules I need tutoring for",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        )))
              ]),
            ),
          ),
          Positioned(
            top: 520,
            left: 30,
            child: Container(
              height: 200,
              margin: const EdgeInsets.all(15.0),
              // padding: const EdgeInsets.all(3.0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      // text: "Rose Tumil",
                      // style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: '\u{2795} Calculus\n\n',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: '\u{2795} Algebra\n\n',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: '\u{2795} Mechanics\n\n',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 630,
              left: 100,
              child: ElevatedButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                child: const Text("Send Request"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepOrangeAccent),
                ),
              ))
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget ok = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('OK'));

    AlertDialog requestAlert = AlertDialog(
        title: Text("Alert"),
        content: Text("Your request has been sent!!"),
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
