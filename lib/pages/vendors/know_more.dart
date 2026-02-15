import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prasad/pages/image_preview.dart';
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
                          "Services",
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
                        Text(
                          "Images",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder(
                          future: getVendorImages(uid: widget.uid),
                          builder: (context, imageSnapshot) {
                            if (imageSnapshot.hasData) {
                              return SingleChildScrollView(
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
                                            builder: (context) => ImagePreview(
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
                              );
                            }

                            return SizedBox(
                              width: 100,
                              height: 100,
                              child: Center(
                                child: SpinKitChasingDots(
                                  size: 32,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            );
                          },
                        ),
                        Text(
                          "Ratings",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (snapshot.data!.ratings.isEmpty)
                          Text("No Ratings", style: TextStyle(fontSize: 24)),
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
