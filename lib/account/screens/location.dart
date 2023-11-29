import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/utils/location/location.dart';

import 'nation_language.dart';


class LocationScreen extends StatefulWidget {
  const LocationScreen({
    super.key,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.avatar,
    required this.country
  });
  final String name;
  final DateTime birthday;
  final Gender gender;
  final Uint8List avatar;
  final SonaCountry country;

  @override
  State<StatefulWidget> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: false,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: MediaQuery.of(context).viewPadding.top + 16,
              bottom: 16
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/location_authorization.png', height: 228,),
              SizedBox(height: 16),
              Text(
                'Authorize location',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 4),
              Text(
                'Find foreigners in the same city',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              // Spacer()
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: FilledButton(
          child: Text('Next'),
          onPressed: _next,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _next() async {
    final location = await determinePosition();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NationAndLanguageScreen(
      name: widget.name,
      birthday: widget.birthday,
      gender: widget.gender,
      avatar: widget.avatar,
      location: location,
      country: widget.country
    )));
  }
}