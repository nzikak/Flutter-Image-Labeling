import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_labelling/models/ui_state.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as dev;

class ImageProvider extends ChangeNotifier {
  UiState _uiState = UiState.initial();

  UiState get uiState => _uiState;

  late ImageLabeler _imageLabeler;

  @override
  void dispose() {
    _imageLabeler.close();
    super.dispose();
  }

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
    } catch (e) {
      dev.log(e.toString());
      _uiState = UiState.error();
      notifyListeners();
    }
  }

  Future<List<ImageLabel>> _classifyImage(File image) async {
    final inputImage = InputImage.fromFile(image);
     _imageLabeler =
        ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.70));
    final labels = await _imageLabeler.processImage(inputImage);
    return labels;
  }

  Future<XFile?> _selectImage() async {
    final imagePicker = ImagePicker();

    final XFile? photo =
        await imagePicker.pickImage(source: ImageSource.gallery);

    return photo;
  }
}
