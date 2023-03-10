import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_labelling/object_label.dart';
import 'package:image_labelling/ui_state.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as dev;

class ImageProvider extends ChangeNotifier {
  UiState _uiState = UiState.initial();

  UiState get uiState => _uiState;

  void startImageClassification() async {
    try {
      _uiState = UiState.loading();
      notifyListeners();
      final image = await _selectImage();
      if (image != null) {
        final imageFile = File(image.path);
        final result = await _classifyImage(imageFile);
        _uiState = UiState.success(image: imageFile, labels: result);
      } else {
        _uiState = UiState.initial();
      }
      notifyListeners();
    } catch (_) {
      _uiState = UiState.error();
      notifyListeners();
    }
  }

  Future<List<ObjectLabel>> _classifyImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    final imageLabeler =
        ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.70));
    final labels = await imageLabeler.processImage(inputImage);
    final objectLabels = labels
        .map(
          (label) => ObjectLabel(
            confidence: label.confidence.toStringAsFixed(2),
            label: label.label,
          ),
        )
        .toList();
    return objectLabels;
  }

  Future<XFile?> _selectImage() async {
    final imagePicker = ImagePicker();

    final XFile? photo =
        await imagePicker.pickImage(source: ImageSource.gallery);

    return photo;
  }
}
