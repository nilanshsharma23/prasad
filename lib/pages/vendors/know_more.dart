import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prasad/l10n/app_localizations.dart';
import 'package:prasad/pages/image_preview.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/functions/show_error_dialog.dart';
import 'package:prasad/utils/functions/vendors/add_rating.dart';
import 'package:prasad/utils/functions/vendors/get_vendor_details.dart';
import 'package:prasad/utils/functions/vendors/get_vendor_images.dart';
import 'package:prasad/utils/widgets/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';

class KnowMorePage extends StatefulWidget {
  const KnowMorePage({super.key, required this.uid});

  final String uid;

  @override
  State<KnowMorePage> createState() => _KnowMorePageState();
}

class _KnowMorePageState extends State<KnowMorePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVendorDetails(uid: widget.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                snapshot.data!.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(32),
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.description,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          AppLocalizations.of(context)!.services,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            snapshot.data!.services.length,
                            (index) {
                              return Text(
                                "\u2022 ${snapshot.data!.services[index]}",
                                style: TextStyle(fontSize: 16),
                              );
                            },
                          ),
                        ),
                        FutureBuilder(
                          future: getVendorImages(uid: widget.uid),
                          builder: (context, imageSnapshot) {
                            if (!imageSnapshot.hasData) {
                              return SizedBox(
                                width: 100,
                                height: 100,
                                child: Center(
                                  child: SpinKitChasingDots(
                                    size: 32,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              );
                            }

                            if (imageSnapshot.data!.isEmpty) {
                              return SizedBox();
                            }

                            return Column(
                              spacing: 16,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.images,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    spacing: 16,
                                    children: List.generate(
                                      imageSnapshot.data!.length,
                                      (index) => InkWell(
                                        radius: 8,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ImagePreview(
                                                    images: imageSnapshot.data!,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: SizedBox(
                                          height: 256,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.memory(
                                              imageSnapshot.data![index],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Text(
                          AppLocalizations.of(context)!.ratings,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (snapshot.data!.ratings.isEmpty)
                          Text(
                            AppLocalizations.of(context)!.noRatings,
                            style: TextStyle(fontSize: 24),
                          ),
                        if (snapshot.data!.ratings.isNotEmpty)
                          Column(
                            spacing: 16,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              snapshot.data!.ratings.length,
                              (index) {
                                return Column(
                                  spacing: 8,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.ratings[index].raterName,
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    RatingBarIndicator(
                                      itemBuilder: (context, index) {
                                        return Icon(
                                          Icons.star,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        );
                                      },
                                      itemCount: 5,
                                      itemSize: 50,
                                      rating:
                                          snapshot.data!.ratings[index].rating,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              if (Globals.supabase.auth.currentUser == null) {
                                showErrorDialog(
                                  context,
                                  AppLocalizations.of(context)!.needToSignIn,
                                );

                                return;
                              }

                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Rate ${snapshot.data!.name}"),
                                    content: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: RatingBar.builder(
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                        onRatingUpdate: (rating) async {
                                          await addRating(
                                            snapshot.data!.ratings,
                                            snapshot.data!.uid,
                                            rating,
                                          );

                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        itemSize: 50,
                                      ),
                                    ),
                                  );
                                },
                              );

                              setState(() {});
                            },
                            child: Row(
                              children: [
                                Icon(Icons.add, size: 32),
                                Text(
                                  "Rate ${snapshot.data!.name}",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: PrimaryButton(
                      onPressed: () async {
                        await launchUrl(
                          Uri.parse("tel:${snapshot.data!.mobile}"),
                        );
                      },
                      text: "Call ${snapshot.data!.name}",
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: SpinKitChasingDots(
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}
