import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:prasad/utils/classes/listing_object.dart';
import 'package:prasad/utils/enums/status_enum.dart';
import 'package:prasad/utils/widgets/listing_container.dart';
import 'package:prasad/utils/widgets/barriers/location_permission_screen.dart';
import 'package:prasad/utils/widgets/status_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<PermissionStatus>? locationPermissionStatus;

  @override
  void initState() {
    super.initState();
    Location location = Location();
    locationPermissionStatus = location.hasPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/logo_white.svg',
          semanticsLabel: "Prasad Logo",
          width: 128,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: LocationPermissionScreen(
        child: Padding(
          padding: EdgeInsetsGeometry.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 32,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusContainer(
                    primaryColor: Theme.of(context).colorScheme.primary,
                    status: "10",
                    subtext: "Nearby",
                  ),
                  StatusContainer(
                    primaryColor: Theme.of(context).colorScheme.secondary,
                    status: "1.0km",
                    subtext: "Nearest",
                  ),
                ],
              ),
              Text(
                "Nearby Bhandaras",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              ListingContainer(
                listingObject: ListingObject(
                  address: "Raj Nagar, Ghaziabad",
                  date: DateTime(2025, 12, 2),
                  from: TimeOfDay(hour: 0, minute: 5),
                  to: TimeOfDay(hour: 5, minute: 0),
                  uid: "",
                  host: "",
                  latLong: LatLong(40.7128, -74.0060),
                  status: Status.accepted,
                  people: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
