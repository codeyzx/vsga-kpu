import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kpu/src/constants/constants.dart';
import 'package:kpu/src/features/domain/people.dart';

class HiveService {
  /// [TODO]
  /// all business logic in hive
  final peopleBox = Hive.box<String>(HiveKey.peopleBox);

  Future<void> savePeople(People people) async {
    debugPrint(people.nik.toString());
    final peopleJson = people.toJson();
    await peopleBox.put(people.nik, peopleJson);
  }

  Future deletePeople(int peopleId) async {
    debugPrint(peopleId.toString());
    await peopleBox.delete(peopleId);
  }

  bool isMovieFavorite(int peopleId) {
    debugPrint(peopleId.toString());
    return peopleBox.containsKey(peopleId);
  }

  List<People> getAllPeoples() {
    try {
      return (peopleBox.values).map<People>((item) {
        return People.fromJson(item);
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}

final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});
