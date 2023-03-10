import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_labelling/models/ui_state.dart';

class ImageProvider extends ChangeNotifier {
  UiState _uiState = UiState.initial();

  UiState get uiState => _uiState;
}
