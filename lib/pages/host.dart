import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:prasad/pages/pick_location.dart';
import 'package:prasad/utils/widgets/barriers/location_permission_screen.dart';
import 'package:prasad/utils/widgets/barriers/sign_in_barrier_screen.dart';
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
  PickedData? pickedData;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LocationPermissionScreen(
        child: SignInBarrierScreen(
          child: Padding(
            padding: EdgeInsetsGeometry.all(32),
            child: Stack(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Text(
                        "Host A Bhandara",
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
                                      pickedData = value;
                                    });
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
                              pickedData != null
                                  ? pickedData!.address
                                  : "Select Location",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
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
                                  : "Select Date",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TimeRange(
                        timeBlock: 15,
                        fromTitle: Text(
                          "From",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        toTitle: Text(
                          "To",
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
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.people),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: "No Of People",
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: false,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () async {},
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                          ),
                          child: Text(
                            "Host",
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
      ),
    );
  }
}
