import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpu/src/features/domain/people.dart';

class PeopleState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<People> peopleList;
  final AsyncValue<List<People>?> peopleListValue;
  final String genderValue;
  final DateTime? date;
  final String image;
  final String address;
  final List<Map<String, String>> gender;

  PeopleState({
    this.peopleList = const [],
    this.peopleListValue = const AsyncData(null),
    this.genderValue = 'PRIA',
    this.image = '',
    this.date,
    this.address = '',
  }) : gender = [
          {
            'text': 'Pria',
            'value': 'PRIA',
          },
          {
            'text': 'Wanita',
            'value': 'WANITA',
          },
        ];

  bool get isLoading => peopleListValue.isLoading;

  PeopleState copyWith({
    List<People>? peopleList,
    AsyncValue<List<People>>? peopleListValue,
    String? genderValue,
    String? image,
    DateTime? date,
    String? address,
  }) {
    return PeopleState(
      peopleList: peopleList ?? this.peopleList,
      peopleListValue: peopleListValue ?? this.peopleListValue,
      genderValue: genderValue ?? this.genderValue,
      date: date ?? this.date,
      image: image ?? this.image,
      address: address ?? this.address,
    );
  }
}
