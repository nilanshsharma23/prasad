import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:prasad/l10n/app_localizations.dart';
import 'package:prasad/pages/pick_location.dart';
import 'package:prasad/utils/classes/globals.dart';
import 'package:prasad/utils/functions/show_error_dialog.dart';
import 'package:prasad/utils/widgets/barriers/barrier_screen.dart';
import 'package:prasad/utils/widgets/barriers/location_permission_screen.dart';
import 'package:time_range/time_range.dart';

class HostPage extends StatefulWidget {
  const HostPage({super.key});

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeRangeResult? selectedTimeRange;
  PickedData? pickedLocationData;
  TextEditingController noOfPeopleController = TextEditingController();
  Uint8List? uploadedProof;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    if (Globals.supabase.auth.currentUser != null) {
      return Scaffold(
        body: LocationPermissionScreen(
          child: Padding(
            padding: EdgeInsetsGeometry.all(32),
            child: Stack(
              children: [
                Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.hostABhandara,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });

                              Location location = Location();
                              LocationData locationData = await location
                                  .getLocation();

                              Navigator.push(
                                mounted ? context : context,
                                MaterialPageRoute(
                                  builder: (context) => PickLocationPage(
                                    currentLocation: LatLong(
                                      locationData.latitude!,
                                      locationData.longitude!,
                                    ),
                                    onLocationPicked: (value) {
                                      setState(() {
                                        pickedLocationData = value;
                                      });

                                      print(value.addressData);
                                    },
                                  ),
                                ),
                              );

                              setState(() {
                                loading = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(8),
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              shadowColor: Colors.transparent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                pickedLocationData != null
                                    ? pickedLocationData!.address
                                    : AppLocalizations.of(
                                        context,
                                      )!.selectLocation,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(
                                  DateTime.now().year + 1,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                ),
                              );

                              setState(() {
                                selectedDate = pickedDate;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(8),
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              shadowColor: Colors.transparent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                selectedDate != null
                                    ? DateFormat.yMMMEd().format(selectedDate!)
                                    : AppLocalizations.of(context)!.selectDate,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TimeRange(
                          timeBlock: 15,
                          fromTitle: Text(
                            AppLocalizations.of(context)!.from,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          toTitle: Text(
                            AppLocalizations.of(context)!.to,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          activeBackgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          activeTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          borderColor: Theme.of(context).colorScheme.outline,
                          onRangeCompleted: (range) {
                            setState(() {
                              selectedTimeRange = range;
                            });
                          },
                          firstTime: TimeOfDay(hour: 5, minute: 0),
                          lastTime: TimeOfDay(hour: 18, minute: 0),
                          timeStep: 15,
                        ),
                        TextFormField(
                          controller: noOfPeopleController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.people),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: AppLocalizations.of(context)!.noOfPeople,
                          ),
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
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
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final ImagePicker imagePicker = ImagePicker();

                              XFile? pickedImage = await imagePicker.pickImage(
                                source: ImageSource.gallery,
                              );

                              if (pickedImage != null) {
                                Uint8List? pickedBytes = await pickedImage
                                    .readAsBytes();

                                Uint8List? compressedBytes =
                                    await FlutterImageCompress.compressWithList(
                                      pickedBytes,
                                      quality: 50,
                                    );

                                setState(() {
                                  uploadedProof = compressedBytes;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(8),
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              shadowColor: Colors.transparent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                spacing: 4,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.uploadProof,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.uploadProofDescription,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (uploadedProof != null)
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(8),
                                child: Image.memory(uploadedProof!),
                              ),
                              Align(
                                alignment: AlignmentGeometry.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      uploadedProof = null;
                                    });
                                  },
                                  icon: Icon(Icons.close),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (selectedDate == null) {
                                  showErrorDialog(
                                    context,
                                    AppLocalizations.of(
                                      context,
                                    )!.dateNotSelected,
                                  );

                                  return;
                                }

                                if (selectedTimeRange == null) {
                                  showErrorDialog(
                                    context,
                                    AppLocalizations.of(
                                      context,
                                    )!.timeNotSelected,
                                  );

                                  return;
                                }

                                if (pickedLocationData == null) {
                                  showErrorDialog(
                                    context,
                                    AppLocalizations.of(
                                      context,
                                    )!.locationNotSelected,
                                  );

                                  return;
                                }

                                if (uploadedProof == null) {
                                  showErrorDialog(
                                    context,
                                    AppLocalizations.of(
                                      context,
                                    )!.proofNotUploaded,
                                  );

                                  return;
                                }

                                setState(() {
                                  loading = true;
                                });

                                String address = "";

                                if (pickedLocationData!
                                        .addressData['amenity'] !=
                                    null) {
                                  address +=
                                      "${pickedLocationData!.addressData['amenity']}, ";
                                }

                                if (pickedLocationData!.addressData['road'] !=
                                    null) {
                                  address +=
                                      "${pickedLocationData!.addressData['road']}, ";
                                }

                                if (pickedLocationData!.addressData['suburb'] !=
                                    null) {
                                  address +=
                                      "${pickedLocationData!.addressData['suburb']}, ";
                                }

                                if (pickedLocationData!
                                        .addressData['amenity'] !=
                                    null) {
                                  address +=
                                      "${pickedLocationData!.addressData['city']}, ";
                                }

                                if (pickedLocationData!.addressData['state'] !=
                                    null) {
                                  address +=
                                      "${pickedLocationData!.addressData['state']}";
                                }

                                var data = await Globals.supabase
                                    .from('listings')
                                    .insert({
                                      'latitude':
                                          pickedLocationData!.latLong.latitude,
                                      'longitude':
                                          pickedLocationData!.latLong.longitude,
                                      'from': selectedTimeRange!.start.format(
                                        context,
                                      ),
                                      'to': selectedTimeRange!.end.format(
                                        context,
                                      ),
                                      'date': selectedDate!.toString(),
                                      'host':
                                          Globals.supabase.auth.currentUser!.id,
                                      'people': int.parse(
                                        noOfPeopleController.text,
                                      ),
                                      'address': address,
                                    })
                                    .select('host, uid')
                                    .single();

                                await Globals.supabase.storage
                                    .from('proofs')
                                    .uploadBinary(
                                      '${data['host']}/${data['uid']}.webp',
                                      uploadedProof!,
                                    );

                                if (context.mounted) {
                                  context.go('/listing-created');
                                }

                                setState(() {
                                  loading = false;
                                });
                              }
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
                              AppLocalizations.of(context)!.host,
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
    } else {
      return BarrierScreen(
        barrierText: AppLocalizations.of(context)!.needToSignIn,
        buttonText: AppLocalizations.of(context)!.signIn,
        onButtonPressed: () {
          context.push('/sign-in');
        },
      );
    }
  }
}
