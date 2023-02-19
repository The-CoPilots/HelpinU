import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:helpin_u/constants/constants.dart';
import 'package:helpin_u/constants/dummy_data.dart';
import 'package:helpin_u/models/volunteer_model.dart';
import 'package:helpin_u/services/auth_bloc/bloc.dart';
import 'package:helpin_u/services/db_bloc/db_bloc.dart';
import 'package:helpin_u/services/nav_bloc/bloc.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../constants/tags.dart';

class VolunteerProfile extends StatefulWidget {
  const VolunteerProfile({super.key});

  @override
  State<VolunteerProfile> createState() => _VolunteerProfileState();
}

// TODO: UI consistency

class _VolunteerProfileState extends State<VolunteerProfile> {
  double _distanceToField = 0;
  final TextfieldTagsController _controller = TextfieldTagsController();
  bool editingControl = false;
  String imageFileEncode = '';

  

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }


  



  @override
  Widget build(BuildContext context) {
    final VolunteerModel volunteer = DummyVolunteers.volunteers[0];
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 0,
        title: const Text(
          'HelpingU',
          style: TextStyle(
              fontFamily: "Poppins",
              color: kTextColor,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        leading: Image.asset('assets/images/logo.png'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home_outlined,
              color: kTextColor,
              size: 25,
            ),
            onPressed: () {
              BlocProvider.of<NavigatorBloc>(context).add(
                NavigateToVolunteerHomeEvent(),
              );
            },
          ),
          const Padding(padding: EdgeInsets.only(right: 20)),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: width * 0.8,
            top: height * 0.15,
            child: TextButton(
              onPressed: () {
                setState(() {
                  editingControl = !editingControl;
                });
              },
              child: const Icon(
                Icons.edit_rounded,
                color: Colors.grey,
                size: 30,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                "Volunteer Profile",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  color: kTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap : () async {
                  
                  FilePickerResult? inputFile =
                  await FilePicker.platform.pickFiles(
                    type: FileType.image,
                    allowedExtensions: ['jpg', 'png', 'jpeg'],
                  );
                
                  if (inputFile != null) {
                    File file = File(inputFile.files.single.path!);
                    Uint8List imagebytes = await file.readAsBytes(); //convert to bytes
                    String base64encode = base64.encode(imagebytes);
                    setState(() {
                      imageFileEncode = base64encode;
                    });

                  } else {
                    // User canceled the picker
                  }
                },
                child: Icon
                (
                  Icons.person_sharp,
                  color: Colors.grey,
                  size: 100,
                ),
              ),

              const SizedBox(height: 20),

              //create a textfield for the name
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      'Name:',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: width * 0.6,
                      child: TextField(
                        controller: TextEditingController()
                          ..text = "Name of volunteer",
                        enabled: editingControl,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: kSecondaryColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      'Email:',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: width * 0.6,
                      child: TextField(
                        controller: TextEditingController()
                          ..text = "abc@gmail.com",
                        // make it ineditable
                        enabled: false,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: kSecondaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      'Bio:',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: width * 0.6,
                      child: TextField(
                        maxLines: 2,
                        controller: TextEditingController()
                          ..text =
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labori",
                        enabled: editingControl,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: kSecondaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      'Interest:',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: width * 0.6,
                      child: TextFieldTags(
                        textfieldTagsController: _controller,
                        initialTags: const [
                          'pick',
                        ],
                        textSeparators: const [' ', ','],
                        letterCase: LetterCase.normal,
                        validator: (String tag) {
                          return null;
                        },
                        inputfieldBuilder:
                            (context, tec, fn, error, onChanged, onSubmitted) {
                          return ((context, sc, tags, onTagDelete) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: tec,
                                focusNode: fn,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kSecondaryColor,
                                      width: 3.0,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kSecondaryColor,
                                      width: 3.0,
                                    ),
                                  ),
                                  hintText:
                                      _controller.hasTags ? '' : "Enter tag...",
                                  errorText: error,
                                  enabled: editingControl,
                                  prefixIconConstraints: BoxConstraints(
                                      maxWidth: _distanceToField * 0.7),
                                  prefixIcon: tags.isNotEmpty
                                      ? SingleChildScrollView(
                                          controller: sc,
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                              children: tags.map((String tag) {
                                            return Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(40.0),
                                                ),
                                                color: kSecondaryColor,
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    child: Text(
                                                      tag,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onTap: () {
                                                      // print("$tag selected");
                                                    },
                                                  ),
                                                  const SizedBox(width: 4.0),
                                                  InkWell(
                                                    child: const Icon(
                                                      Icons.cancel,
                                                      size: 14.0,
                                                      color: Color.fromARGB(
                                                          255, 233, 233, 233),
                                                    ),
                                                    onTap: () {
                                                      onTagDelete(tag);
                                                    },
                                                  )
                                                ],
                                              ),
                                            );
                                          }).toList()),
                                        )
                                      : null,
                                ),
                                onChanged: onChanged,
                                onSubmitted: onSubmitted,
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              editingControl == true
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() => editingControl = !editingControl);
                          context
                              .read<DbBloc>()
                              .add(const OrganizationUpdateEvent(
                                organizationId: '123',
                              ));
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    )
                  : Container(),
              const Padding(padding: EdgeInsets.only(top: 25)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.05,
                // Logout button
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogout());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Logout'),
                ),
              )
            ],
          ),
        ],
      ),

    );
  }
}
