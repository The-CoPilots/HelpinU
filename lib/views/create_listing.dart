import 'package:flutter/material.dart';
import 'package:helpin_u/services/db_bloc/db_bloc.dart';
import '../constants/constants.dart';
import '../services/nav_bloc/bloc.dart';

class CreateListing extends StatefulWidget {
  const CreateListing({Key? key}) : super(key: key);

  @override
  State<CreateListing> createState() => _CreateListingState();
}

class _CreateListingState extends State<CreateListing> {
  String listingTitle = '';
  String location = '';
  String date = '';
  String desc = '';

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 0,
          title: const Text(
            'HelpinU',
            style: TextStyle(
                fontFamily: "Poppins",
                color: kTextColor,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          leading: Image.asset('assets/images/logo.png'),
          actions: <Widget>[
            //add text
            IconButton(
              icon: const Icon(
                Icons.person_outline_rounded,
                color: kTextColor,
                size: 25,
              ),
              onPressed: () {
                BlocProvider.of<NavigatorBloc>(context).add(
                  NavigateToOrgProfileEvent(),
                );
              },
            ),

            const Padding(padding: EdgeInsets.only(right: 20)),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Create Volunteer Listing',
              style: TextStyle(
                  fontFamily: "Poppins",
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(height: 10),
            Image(
              image: const AssetImage('assets/images/company.png'),
              height: height * 0.15,
              width: width * 0.15,
            ),
            const SizedBox(height: 10),
            const Text(
              'Company Name',
              style: TextStyle(
                  fontFamily: "Poppins", color: kTextColor, fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _titleController,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  listingTitle = value;
                },
                decoration: const InputDecoration(
                    hintText: "Title",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: kSecondaryColor))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _descController,
                keyboardType: TextInputType.name,
                maxLines: 3,
                onChanged: (value) {
                  desc = value;
                },
                decoration: const InputDecoration(
                    hintText: "Description",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: kSecondaryColor))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _locationController,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  location = value;
                },
                decoration: const InputDecoration(
                    hintText: "Location",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: kSecondaryColor))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _dateController,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  date = value;
                },
                decoration: const InputDecoration(
                    hintText: "Date of posting",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: kSecondaryColor))),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      _titleController.clear();
                      _locationController.clear();
                      _dateController.clear();
                      _descController.clear();
                    },
                    child: const Text(
                      "Clear",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (location == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in all fields'),
                          ),
                        );
                      } else {
                        BlocProvider.of<DbBloc>(context).add(
                          ListingCreateEvent(
                            organizationId: '123',
                            title: _titleController.text,
                            location: _locationController.text,
                            datePosted: _dateController.text,
                            description: _descController.text,
                          ),
                        );
                        _titleController.clear();
                        _locationController.clear();
                        _dateController.clear();
                        _descController.clear();
                      }
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
                ),
              ],
            ),
          ],
        ));
  }
}
