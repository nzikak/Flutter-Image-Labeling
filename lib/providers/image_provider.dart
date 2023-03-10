import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_labelling/models/object_label.dart';
import 'package:image_labelling/models/ui_state.dart';
import 'package:image_picker/image_picker.dart';

class ImageProvider extends ChangeNotifier {
  UiState _uiState = UiState.initial();

  UiState get uiState => _uiState;
}
