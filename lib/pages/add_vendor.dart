import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:prasad/l10n/app_localizations.dart';
import 'package:prasad/utils/functions/show_error_dialog.dart';
import 'package:prasad/utils/widgets/pick_location_button.dart';

class AddVendorPage extends StatefulWidget {
  const AddVendorPage({super.key});

  @override
  State<AddVendorPage> createState() => _AddVendorPageState();
}

class _AddVendorPageState extends State<AddVendorPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PickedData? pickedLocationData;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> services = [];
  List<Uint8List> images = [];

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Stack(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Text(
                      "Add Vendor",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Enter Vendor Name",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.pleaseEnterSomething;
                        }

                        return null;
                      },
                    ),
                    PickLocationButton(
                      pickedLocationData: pickedLocationData,
                      onLocationPicked: (value) {
                        setState(() {
                          pickedLocationData = value;
                        });
                      },
                      onStart: () {
                        setState(() {
                          loading = true;
                        });
                      },
                      onStop: () {
                        setState(() {
                          loading = false;
                        });
                      },
                    ),
                    TextFormField(
                      controller: numberController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: AppLocalizations.of(
                          context,
                        )!.enterMobileNumber,
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.pleaseEnterSomething;
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: rateController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.currency_rupee),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Enter Rate",
                      ),
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.pleaseEnterSomething;
                        }

                        return null;
                      },
                    ),
                    Text(
                      "Services",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: List.generate(services.length, (index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              services[index],
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  services.removeAt(index);
                                });
                              },
                              icon: Icon(Icons.delete, size: 24),
                            ),
                          ],
                        );
                      }),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            TextEditingController serviceController =
                                TextEditingController();

                            return AlertDialog(
                              content: TextField(
                                controller: serviceController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelText: "Enter Service",
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (serviceController.text.isEmpty) return;

                                    setState(() {
                                      services.add(serviceController.text);
                                    });

                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.ok,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                        shadowColor: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.onSurface,
                            size: 24,
                          ),
                          Text(
                            "Add Service",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 16,
                        children: [
                          Row(
                            spacing: 16,
                            children: List.generate(
                              images.length,
                              (index) => SizedBox(
                                height: 256,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.memory(images[index]),
                                    ),
                                    Align(
                                      alignment: AlignmentGeometry.topRight,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            images.removeAt(index);
                                          });
                                        },
                                        icon: Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                loading = true;
                              });
                              final ImagePicker imagePicker = ImagePicker();

                              final List<XFile> pickedImages = await imagePicker
                                  .pickMultiImage();

                              for (var image in pickedImages) {
                                Uint8List pickedBytes = await image
                                    .readAsBytes();

                                Uint8List compressedBytes =
                                    await FlutterImageCompress.compressWithList(
                                      pickedBytes,
                                      quality: 50,
                                    );

                                setState(() {
                                  images.add(compressedBytes);
                                });
                              }

                              setState(() {
                                loading = false;
                              });
                            },
                            radius: 8,
                            child: Container(
                              width: 256,
                              height: 256,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      size: 32,
                                    ),
                                    Text(
                                      "Add Photo",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Enter Desciption (Optional)",
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.pleaseEnterSomething;
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          if (pickedLocationData == null) {
                            showErrorDialog(
                              context,
                              AppLocalizations.of(context)!.locationNotSelected,
                            );

                            return;
                          }

                          setState(() {
                            loading = true;
                          });

                          setState(() {
                            loading = false;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                          ),
                        ),
                        child: Text(
                          "Add Vendor",
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
              if (loading)
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(100, 0, 0, 0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 50,
                    height: 50,
                    child: SpinKitThreeBounce(
                      color: Theme.of(context).colorScheme.primary,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
