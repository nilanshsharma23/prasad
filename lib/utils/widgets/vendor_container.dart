import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prasad/utils/widgets/primary_button.dart';

class VendorContainer extends StatelessWidget {
  const VendorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(
                  Icons.store,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 32,
                ),
                Text(
                  "PRASAD BHANDARA VENDORS",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: 32,
                ),
                Text(
                  "1.2km",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Icon(
                  Icons.currency_rupee,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: 32,
                ),
                Text(
                  "~300",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    "Services",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text("Food", style: TextStyle(fontSize: 16)),
                  Text("Tent", style: TextStyle(fontSize: 16)),
                  Text("More", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            RatingBarIndicator(
              itemBuilder: (context, index) {
                return Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.onSurface,
                );
              },
              itemCount: 5,
              itemSize: 50,

              rating: 2.8,
            ),
            Text("300 Ratings", style: TextStyle(fontSize: 16)),
            PrimaryButton(onPressed: () {}, text: "Know More"),
          ],
        ),
      ),
    );
  }
}
