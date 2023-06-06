import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';

class CompanyAddTourState {
  final titleController = TextEditingController();
  final titleNode = FocusNode();

  final locationController = TextEditingController();
  final locationNode = FocusNode();

  final priceController = TextEditingController();
  final priceNode = FocusNode();

  final descrepController = TextEditingController();
  final descrepNode = FocusNode();

  final catValue = "".obs;

  final tourPeople = "".obs;

  final loading = false.obs;
}
