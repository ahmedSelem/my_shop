import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:my_shop/Widgets/Collecting_Data_Widget/collecting_title.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SecondScreen extends StatefulWidget {
  final Function prevPage, submitDate; 
  SecondScreen(this.prevPage, this.submitDate);
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool isLoading;
  LatLng currentPosition;
  String currentAddress;

  @override
  void initState() {
    super.initState();
    isLoading = true;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    currentPosition = LatLng(_locationData.longitude, _locationData.latitude);
    currentAddress = await getAddress(currentPosition);
    setState(() {
      isLoading = false;
    });
  }

  Future<String> getAddress(currentPosition) async {
    final coordinates = new Coordinates(
      currentPosition.latitude,
      currentPosition.longitude,
    );
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first.addressLine;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 9,
            child: Column(
              children: [
                CollectingTitle(
                  'One Step Left',
                  ' Select Your Location So We Can Deliver To You',
                ),
                SizedBox(height: 20),
                Expanded(
                  child: (isLoading)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Stack(
                          children: [
                            GoogleMap(
                              myLocationEnabled: true,
                              onCameraMove: (position) {
                                setState(() {
                                  currentPosition = position.target;
                                });
                              },
                              onCameraIdle: () async {
                                currentAddress =
                                    await getAddress(currentPosition);
                                setState(() {});
                              },
                              initialCameraPosition: CameraPosition(
                                target: currentPosition,
                                zoom: 18,
                              ),
                            ),
                            Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: EdgeInsets.fromLTRB(12, 60, 12, 0),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  currentAddress,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Icon(
                                    Icons.place,
                                    size: 40,
                                  )),
                            ),
                          ],
                        ),
                ),
              ],
            )),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // FlatButton(
              //   color: Colors.white,
              //   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
              //   child: Text(
              //     'Back',
              //     style: TextStyle(
              //         color: Theme.of(context).primaryColor, fontSize: 18),
              //   ),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   onPressed: () {
              //     widget.prevPage();
              //   },
              // ),
              FlatButton(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Text(
                  'submit',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {
                  widget.submitDate(currentAddress);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
