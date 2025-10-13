import 'package:flutter/material.dart';
import 'package:prasad/utils/classes/listing_object.dart';

class ListingContainer extends StatelessWidget {
  const ListingContainer({super.key, required this.listingObject});

  final ListingObject listingObject;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          spacing: 16,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 32,
                ),
                Text(
                  listingObject.location,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: 16,
                    ),
                    Text(
                      listingObject.date,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: 16,
                    ),
                    Text(
                      listingObject.time,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.people_outline_outlined,
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: 16,
                    ),
                    Text(
                      listingObject.people,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "Take Me There",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
