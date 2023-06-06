import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';

class CompanyAddTourState {
  final titleController = TextEditingController();
  final titleNode = FocusNode();

  final locationController = TextEditingController();
  final locationNode = FocusNode();

  final priceController = TextEditingController();
  final priceNode = FocusNode();

  final descrepController = TextEditingController();
  final descrepNode = FocusNode();

  final catValue="".obs;

  final tourPeople="".obs;

  // Rx<XFile> _image="".obs as Rx<XFile>;
  // final Rx<XFile> selectedImage="" as Rx<XFile>;



}