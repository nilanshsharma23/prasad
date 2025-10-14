import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:prasad/utils/classes/listing_object.dart';
import 'package:prasad/utils/widgets/listing_container.dart';
import 'package:prasad/utils/widgets/status_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/logo_white.svg',
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
      body: Padding(
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
                location: "Raj Nagar, Ghaziabad",
                date: "Today",
                time: "9:00AM - 5:00PM",
                people: "100+",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
