import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/edit_text_controller.dart';
import '../../util/utils.dart';
import '../../util/widget_utility.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';
import '../theme/ui_constants.dart';

class CustomTextField extends StatefulWidget {
  final bool? enabled;
  final TextInputType? textInputType;
  final String? headerLabel;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isFieldCompulsory;
  final String? defaultText;
  final FocusNode? focusNode;
  final bool obscureText;
  final EditTextController controller;
  final List<TextInputFormatter> inputFormatter;
  final TextInputAction? actionKeyboard;
  final Function(String)? onSubmitField;
  final Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final VoidCallback? onFieldTap;
  final bool autofocus;
  final Color? errorBorderColor;
  final TextStyle? textStyle;

  final bool? isBtn;
  final bool? isReadOnly;
  final bool? showCursor;
  final String? suffixBtnText;
  final Function? onSuffixBtnTap;
  final int? maxLines;
  final Widget? suffix;
  final Key? textKey;
  final Function(PointerDownEvent)? onTapOutside;
  final TextCapitalization textCapitalization;
  final InputBorder? enabledInputBorder;
  final InputBorder? focusedInputBorder;
  final int? maxLength;

  const CustomTextField(
      {super.key,
        this.enabled,
        this.textInputType,
        this.headerLabel,
        this.hintText,
        this.prefixIcon,
        this.suffixIcon,
        this.defaultText,
        this.focusNode,
        this.obscureText = false,
        required this.controller,
        this.actionKeyboard,
        this.onSubmitField,
        this.onChanged,
        this.isReadOnly,
        this.showCursor,
        this.isFieldCompulsory = false,
        this.onSaved,
        this.errorBorderColor,
        this.textStyle,
        this.onFieldTap,
        this.inputFormatter = const [],
        this.autofocus = true,
        this.suffixBtnText,
        this.onSuffixBtnTap,
        this.maxLines,
        this.suffix,
        this.textKey,
        this.isBtn = false,
        this.onTapOutside,
        this.maxLength,
        this.textCapitalization = TextCapitalization.none,
        this.enabledInputBorder,
        this.focusedInputBorder,
      });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: AppColor().colorCultureWhite,
      ),
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          return body();
        },
      ),
    );
  }

  Widget body () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: WidgetUtility.spreadWidgets([
        if (Utils.isValidString(widget.headerLabel))
          Row(
            children: [
              Text(widget.headerLabel!, style: TextStyles.textFieldTextStyle),
              if (widget.isFieldCompulsory)
                Text(
                  " *",
                  style: TextStyles.errorMessage,
                )
            ],
          ),
        Row(
          children: [
            Expanded(
              child: TextField(
                key: widget.textKey,
                enabled: widget.controller.enabled,
                showCursor: widget.showCursor ?? true,
                readOnly: ((widget.isReadOnly ?? false) || (widget.isBtn ?? false)),
                autofocus: widget.isReadOnly == null ? widget.autofocus : widget.isReadOnly!,
                // cursorColor: AppColor().colorCultureWhite,
                obscureText: widget.obscureText,
                keyboardType: widget.textInputType,
                textInputAction: widget.actionKeyboard,
                focusNode: widget.controller.focusNode,
                maxLines: widget.maxLines ?? 1,
                inputFormatters: widget.inputFormatter,
                textCapitalization: widget.textCapitalization,
                maxLength: widget.maxLength,
                style: widget.textStyle ?? (widget.controller.enabled ? TextStyles.textFieldTextStyle : TextStyles.disabledTextFieldTextStyle),
                decoration: InputDecoration(
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.suffixIcon,
                  suffix: widget.suffix,
                  filled: true,
                  fillColor: AppColor().colorCultureWhite,
                  hintText: widget.hintText,
                  enabledBorder: widget.enabledInputBorder ?? UIConstants.borderTextFieldFocused,
                  focusedBorder: widget.focusedInputBorder ?? UIConstants.borderTextFieldDefault,
                  hintStyle: TextStyles.textFieldHintTextStyle,
                  contentPadding: EdgeInsets.only(
                      top: 12,
                      bottom: bottomPaddingToError,
                      left: 10.0,
                      right: 10.0),
                  isDense: true,
                  errorStyle: TextStyles.errorMessage,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: (widget.errorBorderColor ?? Colors.red)),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: (widget.errorBorderColor ?? Colors.red)),
                  ),
                ),
                controller: widget.controller,
                onChanged: (val) {
                  if (widget.onChanged != null) {
                    widget.onChanged!(val);
                  }
                  if (widget.controller?.onTextChanged != null) {
                    widget.controller?.onTextChanged!(val);
                  }
                },
                onTap: widget.onFieldTap,
                onTapOutside: widget.onTapOutside,
                onSubmitted: widget.onSubmitField,
              ),
            ),
          ],
        ),
        if (Utils.isValidString(widget.controller.error)) _errorView()
      ], interItemSpace: 7,flowHorizontal: false),
    );
  }

  Container _errorView() {
    return Container(
      alignment: Alignment.centerLeft,
      child: _errorViewText(),
    );
  }

  Row _errorViewText() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Text(
              (widget.controller as EditTextController).error!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.errorMessage,
            ))
      ],
    );
  }
}

String? commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  if (required != null) {
    return required;
  }
  return null;
}

String? requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

void changeFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
