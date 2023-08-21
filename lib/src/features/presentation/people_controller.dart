import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kpu/src/features/domain/people.dart';
import 'package:kpu/src/features/presentation/people_state.dart';
import 'package:kpu/src/services/services.dart';
import 'package:kpu/src/shared/extensions/extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';

class PeopleController extends StateNotifier<PeopleState> {
  final HiveService _hiveService;
  PeopleController(
    this._hiveService,
  ) : super(PeopleState());

  final nikController = TextEditingController();
  final fullnameController = TextEditingController();
  final handphoneController = TextEditingController();

  Future<void> addPeople() async {
    if (!state.formKey.currentState!.validate()) return;

    final people = People(
      nik: nikController.text,
      fullname: fullnameController.text,
      handphone: handphoneController.text,
      createdAt: state.date.toString(),
      address: state.address,
      gender: state.genderValue,
      image: state.image,
    );

    _hiveService.savePeople(people);
  }

  void getPeoples() async {
    state = state.copyWith(
      peopleListValue: const AsyncLoading(),
    );
    final data = _hiveService.getAllPeoples();
    state = state.copyWith(
      peopleList: data,
      peopleListValue: AsyncData(data),
    );
  }

  @override
  void dispose() {
    nikController.dispose();
    fullnameController.dispose();
    handphoneController.dispose();
    super.dispose();
  }

  String? validate(String? value) {
    if (value.isNullOrEmpty()) {
      return "Cannot be empty";
    }
    return null;
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      state = state.copyWith(
        image: pickedImage.path,
      );
    }
  }

  Future<void> addImage({required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambahkan Gambar'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Select image from'),
                Text('Gallery or Camera'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => pickImage(ImageSource.gallery),
              child: const Text('Gallery'),
            ),
            TextButton(
              onPressed: () => pickImage(ImageSource.camera),
              child: const Text('Camera'),
            ),
          ],
        );
      },
    );
  }

  void onRoleValueChanged(value) {
    state = state.copyWith(
      genderValue: value,
    );
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      toast('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        toast('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      toast('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark placemark = placemarks[0];

    String completeAddress =
        '${placemark.street} ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';

    state = state.copyWith(
      address: completeAddress,
    );
  }

  void showDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      state = state.copyWith(
        date: date,
      );
    }
  }
}

final peopleControllerProvider = StateNotifierProvider<PeopleController, PeopleState>((ref) {
  final hiveService = ref.read(hiveServiceProvider);
  return PeopleController(hiveService);
});
