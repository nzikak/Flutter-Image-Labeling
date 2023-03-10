import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_labelling/models/object_label.dart';
part 'ui_state.freezed.dart';

@freezed
class UiState with _$UiState {
  factory UiState.loading() = _loading;

  factory UiState.error() = _error;

  factory UiState.success({
    required File image,
    required List<ObjectLabel> labels,
  }) = _success;

  factory UiState.initial() = _initial;
}
