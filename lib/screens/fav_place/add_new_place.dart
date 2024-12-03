import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/provider/fav_place_provider.dart';
import 'package:flutter_course_batch_2/screens/fav_place/fav_place_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AddNewPlace extends StatefulWidget {
  const AddNewPlace({super.key});

  @override
  State<AddNewPlace> createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends State<AddNewPlace> {
  String city = '';
  String img64 = '';
  double lat = 0.0;
  double lng = 0.0;
  File? imageFile;
  final imagepicker = ImagePicker();
  final TextEditingController textEditingController = TextEditingController();

  Future<void> getImageFromCamera(ImageSource imgsrc) async {
    if (imageFile != null) {
      setState(() {
        imageFile!.delete();
      });
    }
    try {
      await imagepicker.pickImage(source: imgsrc, imageQuality: 90).then((value) {
        if (value != null) {
          setState(() {
            imageFile = File(value.path);
            final bytes = File(value.path).readAsBytesSync();
            img64 = base64Encode(bytes);
          });
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // check permission location
  Future<bool> checkLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always) {
      getMyLocation();
      return true;
    } else {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse) {
        getMyLocation();
        return true;
      } else {
        const snackBar = SnackBar(
          content: Text('Please allow this permission on app settings'),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // set delay fo 2 seconds
        Future.delayed(Duration(seconds: 2)).then(
          (value) => openAppSettings().then((value) => checkLocationPermission),
        );
        return false;
      }
    }
  }

  // get my current position
  getMyLocation() async {
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      setState(() {
        city = '${placemarks[0].locality}, ${placemarks[0].administrativeArea}, ${placemarks[0].country}';
        lat = position.latitude;
        lng = position.longitude;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    checkLocationPermission();
    super.initState();
  }

  @override
  void dispose() {
    imageFile!.delete();
    textEditingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add New Place'),
            city == ''
                ? SizedBox(
                    height: 14.0,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Text(
                        'Getting your location..',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Text(
                    city,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),
        actions: [
          imageFile == null
              ? SizedBox.shrink()
              : IconButton.outlined(
                  onPressed: () {
                    setState(() {
                      imageFile!.delete();
                      imageFile = null;
                    });
                  },
                  icon: Icon(CupertinoIcons.refresh),
                ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              // show result image
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    imageFile == null
                        ? Container(
                            height: 500,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CupertinoButton(
                                    color: Colors.purple,
                                    child: Text('camera'),
                                    onPressed: () {
                                      getImageFromCamera(ImageSource.camera);
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  CupertinoButton(
                                    color: Colors.purple,
                                    child: Text('gallery'),
                                    onPressed: () {
                                      getImageFromCamera(ImageSource.gallery);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            height: 500,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: FileImage(
                                  imageFile!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    SizedBox(height: 20),
                    TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        label: Text('Description'),
                        hintText: 'Description',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.4),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: CupertinoButton(
                        color: Colors.purple,
                        child: Text('Save'),
                        onPressed: () {
                          debugPrint(textEditingController.text.toString());
                          debugPrint(imageFile!.path.toString());
                          debugPrint(city.toString());
                          debugPrint(lat.toString());
                          debugPrint(lng.toString());

                          //add to provide ot post
                          final favPlacePvdr = context.read<FavPlaceProvider>();
                          favPlacePvdr.addPlace(
                            FavoritePlaceModel(
                              name: textEditingController.text.toString(),
                              image: img64,
                              location: city,
                              lat: lat,
                              lng: lng,
                            ),
                          );

                          const snackBar = SnackBar(
                            content: Text('Data saved'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // back to prev
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
