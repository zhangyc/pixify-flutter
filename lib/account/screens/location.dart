import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sona/account/event/account_event.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/utils/dialog/common.dart';
import 'package:sona/utils/location/location.dart';

import '../../core/match/util/local_data.dart';
import '../../generated/l10n.dart';
import '../../utils/global/global.dart';
import 'nation_language.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen(
      {super.key,
      required this.name,
      required this.birthday,
      required this.gender,
      required this.avatar,
      required this.country});
  final String name;
  final DateTime birthday;
  final Gender gender;
  final Uint8List avatar;
  final SonaCountry country;

  @override
  State<StatefulWidget> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _check();
    }
    super.didChangeAppLifecycleState(state);
  }

  void _check() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _next();
    }
  }

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
              bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/location_authorization.png',
                height: 228,
              ),
              SizedBox(height: 16),
              Text(
                S.current.locationPermissionRequestTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 4),
              Text(
                S.current.locationPermissionRequestSubtitle,
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
          child: Text(S.current.buttonNext),
          onPressed: _next,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _next() async {
    Position location;
    // try {
    //   //PermissionStatus permission = await Permission.location.request();
    //   location = await determinePosition();
    // } catch(e) {
    //   var permission = await Geolocator.checkPermission();
    //   if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    //     if (!mounted) return;
    //     await showCommonBottomSheet(
    //       context: context,
    //       title: S.current.permissionRequiredTitle,
    //       content: S.current.permissionRequiredContent,
    //       actions: [
    //         FilledButton(
    //           onPressed: () async {
    //             Navigator.pop(context);
    //             //await SystemSettings.app();
    //           },
    //           child: Text(S.current.buttonGo)
    //         )
    //       ]
    //     );
    //   }
    //   return;
    // }
    //,"longitude":"116.32696513904762","latitude":"39.98198198198198",
    longitude = 116.32696513904762;
    latitude = 39.98198198198198;
    location = Position(
        longitude: longitude!,
        latitude: latitude!,
        timestamp: DateTime.now(),
        accuracy: 10,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0);

    if (mounted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => NationAndLanguageScreen(
                  name: widget.name,
                  birthday: widget.birthday,
                  gender: widget.gender,
                  avatar: widget.avatar,
                  location: location,
                  country: widget.country)));
    }
    SonaAnalytics.log(AccountEvent.reg_location_next.name);
  }
}
