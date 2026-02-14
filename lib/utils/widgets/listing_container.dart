import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:prasad/l10n/app_localizations.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/classes/listing_object.dart';
import 'package:prasad/utils/functions/helpers/get_clicks.dart';
import 'package:prasad/utils/functions/helpers/get_status_color.dart';
import 'package:prasad/utils/widgets/primary_button.dart';

class ListingContainer extends StatelessWidget {
  const ListingContainer({
    super.key,
    required this.listingObject,
    required this.onStartToLoad,
    required this.onStoppedLoading,
  });

  final ListingObject listingObject;

  final void Function()? onStartToLoad;
  final void Function()? onStoppedLoading;

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
                Expanded(
                  child: Text(
                    listingObject.address,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
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
                      "${listingObject.date.day}/${listingObject.date.month}",
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
                      "${MaterialLocalizations.of(context).formatTimeOfDay(listingObject.from)} - ${MaterialLocalizations.of(context).formatTimeOfDay(listingObject.to)}",
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
                      "${listingObject.people}+",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (Globals.supabase.auth.currentUser != null &&
                listingObject.host == Globals.supabase.auth.currentUser!.id)
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.status,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    listingObject.status.label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: getStatusColor(
                        context,
                        status: listingObject.status,
                      ),
                    ),
                  ),
                ],
              ),
            if (Globals.supabase.auth.currentUser != null &&
                listingObject.host == Globals.supabase.auth.currentUser!.id)
              FutureBuilder(
                future: getClicks(uid: listingObject.uid),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    return Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.clicks,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          asyncSnapshot.data!.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.times,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            PrimaryButton(
              onPressed: () async {
                onStartToLoad!();

                final data = await Globals.supabase
                    .from('listings')
                    .select('clicks')
                    .eq('uid', listingObject.uid)
                    .single();

                await Globals.supabase
                    .from('listings')
                    .update({'clicks': data['clicks'] + 1})
                    .eq('uid', listingObject.uid);

                onStoppedLoading!();

                MapsLauncher.launchCoordinates(
                  listingObject.latLong.latitude,
                  listingObject.latLong.longitude,
                );
              },
              text: AppLocalizations.of(context)!.takeMeThere,
            ),
          ],
        ),
      ),
    );
  }
}
