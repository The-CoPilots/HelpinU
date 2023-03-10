import 'package:flutter/material.dart';
import 'package:helpin_u/constants/dummy_data.dart';
import 'package:helpin_u/views/widgets/carousel.dart';
import 'package:helpin_u/views/widgets/listings_list.dart';
import 'package:helpin_u/views/widgets/tag_grid.dart';

import '../constants/constants.dart';
import '../services/nav_bloc/bloc.dart';

class VolunteerHome extends StatefulWidget {
  const VolunteerHome({Key? key}) : super(key: key);

  @override
  State<VolunteerHome> createState() => _VolunteerHomeState();
}

class _VolunteerHomeState extends State<VolunteerHome> {
  @override
  Widget build(BuildContext context) {
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
      
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.person_outline_rounded,
              color: kTextColor,
              size: 25,
            ),
            onPressed: () {
              BlocProvider.of<NavigatorBloc>(context).add(
                NavigateToVolunteerProfileEvent(),
              );
            },
          ),
          const Padding(padding: EdgeInsets.only(right: 20)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CarouselWidget(),
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Divider(
            height: 10,
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Color.fromARGB(255, 195, 195, 195),
          ),
          const SizedBox(height: 10,),
            const Text(
              'Categories',
              style: TextStyle(
                  fontFamily: "Poppins",
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            const TagGrid(),
            const SizedBox(
              height: 20,
            ),
            const Divider(
            height: 10,
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Color.fromARGB(255, 195, 195, 195),
          ),
          const SizedBox(height: 10,),
            const Text(
              'Recent Oppurtunities',
              style: TextStyle(
                  fontFamily: "Poppins",
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            ListingList(
              listings: DummyListings.listings,
            )
          ],
        ),
      ),
    );
  }
}
