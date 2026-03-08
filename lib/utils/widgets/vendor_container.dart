import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:prasad/l10n/app_localizations.dart';
import 'package:prasad/utils/classes/vendor_object.dart';
import 'package:prasad/utils/functions/helpers/get_average_rating.dart';
import 'package:prasad/utils/functions/helpers/get_distance_between.dart';
import 'package:prasad/utils/widgets/primary_button.dart';

class VendorContainer extends StatelessWidget {
  const VendorContainer({super.key, required this.vendorObject});

  final VendorObject vendorObject;

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
                  vendorObject.name,
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
                  "${getDistanceBetween(vendorObject.latLong).toStringAsFixed(2)}km",
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
                  vendorObject.rate.toString(),
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
                    AppLocalizations.of(context)!.services,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: List.generate(
                      vendorObject.services.length,
                      (index) => Text(
                        vendorObject.services[index],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
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
              rating: getAverageRating(vendorObject.ratings),
            ),
            Text(
              vendorObject.ratings.isNotEmpty
                  ? "${vendorObject.ratings.length} ${AppLocalizations.of(context)!.ratings}"
                  : AppLocalizations.of(context)!.ratings,
              style: TextStyle(fontSize: 16),
            ),
            PrimaryButton(
              onPressed: () {
                context.push('/vendors/${vendorObject.uid}');
              },
              text: "Know More",
            ),
          ],
        ),
      ),
    );
  }
}
