import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditTextController extends TextEditingController {
  String? _error;
  ValueChanged<String>? _onTextChanged;
  List<TextInputFormatter>? inputFormatters;
  bool enabled;
  FocusNode? focusNode;
  bool _required;

  EditTextController({
    String? error,
    String? text = '',
    ValueChanged<String>? onTextChanged,
    this.inputFormatters,
    this.enabled = true,
    this.focusNode,
    bool required = false
  })  : _required = required{
    _error = error;
    _onTextChanged = onTextChanged;
    super.text = text ?? '';
  }

  String? get error => _error;

  set error(String? value) {
    _error = value;
    notifyListeners();
  }

  ValueChanged<String>? get onTextChanged => _onTextChanged;

  set onTextChanged(ValueChanged<String>? value) {
    _onTextChanged = (text) {
      error = null;
      value!(text);
    };
  }

  bool get required => _required;

  set required(bool isRequired) {
    _required = isRequired;
    notifyListeners();
  }

  void resetField() {
    text = "";
    error = null;
  }
}
