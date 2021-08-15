import 'package:flutter/material.dart';
import 'package:weather_app/utils/focus_utils.dart';

class RoundedTextField extends StatelessWidget {
  final double bottomMargin;
  final double topMargin;
  final Color borderColor;
  final double borderWidth;
  final double borderColorOpacity;
  final TextEditingController? controller;
  final double contentHorizontalPadding;
  final double contentVerticalPadding;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final String? hintText;
  final double? hintTextSize;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final String? prefixText;
  final TextStyle? prefixTextStyle;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final bool editable;
  final int maxLines;
  final String? labelText;
  final TextCapitalization textCapitalization;
  final bool errorState;
  final String? errorText;
  final FocusNode? focusNode;
  final Widget? prefixWidget;
  final String? initialText;

  const RoundedTextField(
      {Key? key,
      this.bottomMargin: 6,
      this.topMargin: 2,
      this.borderColor: Colors.black,
      this.borderWidth: 0.5,
      this.controller,
      this.contentHorizontalPadding: 15,
      this.contentVerticalPadding: 0,
      this.onChanged,
      this.borderColorOpacity = 0.3,
      this.hintText,
      this.hintTextSize: 12,
      this.suffixText,
      this.suffixTextStyle,
      this.prefixText,
      this.prefixTextStyle,
      this.textAlign: TextAlign.start,
      this.keyboardType: TextInputType.text,
      this.editable: true,
      this.onSaved,
      this.maxLines: 1,
      this.textCapitalization = TextCapitalization.sentences,
      this.labelText,
      this.errorState = false,
      this.focusNode,
      this.prefixWidget,
      this.initialText,
      this.errorText})
      : assert(onChanged != null || controller != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin, top: topMargin),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
          color: (errorState ? Colors.red : borderColor)
              .withOpacity(borderColorOpacity),
          blurRadius: 1,
          spreadRadius: 0.5,
        ),
      ], borderRadius: BorderRadius.all(Radius.circular(8))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: TextFormField(
            controller: controller,
            initialValue: initialText,
            textAlign: textAlign,
            textCapitalization: textCapitalization,
            focusNode: focusNode != null
                ? focusNode
                : editable
                    ? null
                    : AlwaysDisabledFocusNode(),
            keyboardType: keyboardType,
            decoration: new InputDecoration(
                labelText: labelText,
                border: InputBorder.none,
                errorText: errorText,
                errorMaxLines: 1,
                hintText: hintText ?? "",
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: contentHorizontalPadding,
                    vertical: contentVerticalPadding),
                filled: true,
                hintStyle: TextStyle(fontSize: hintTextSize),
                suffixStyle: suffixTextStyle ?? TextStyle(),
                suffixText: suffixText,
                prefix: prefixText != null
                    ? Text(prefixText!, style: prefixTextStyle ?? TextStyle())
                    : null,
                prefixIcon: prefixWidget ?? null,
                prefixIconConstraints:
                    BoxConstraints(minHeight: 10, minWidth: 10),
                fillColor: Colors.white),
            maxLines: maxLines,
            onSaved: onSaved,
            onChanged: onChanged),
      ),
    );
  }
}
