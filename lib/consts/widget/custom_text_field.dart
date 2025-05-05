import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Hoppr/consts/app_colors.dart';
import 'package:Hoppr/providers/theme_provider.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool? isPassword;
  final String? hint;
  final String? label;
  final bool? enabled;
  final TextStyle? textStyle;
  final int? maxLines, minLines, maxLength;
  final String? obscuringCharacter, value;
  final String? Function(String?)? onValidate;
  final void Function(String)? onChanged, onFieldSubmitted;
  final void Function(String?)?  onSaved;
  final void Function()? onEditingComplete, onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidget, prefixIcon;
  final IconData? icon;
  final TextInputAction? action;
  final FocusNode? focusNode;
  final Color? hintColor;
  final String? prefixtext;
  final TextDirection? textDirection;
  final EdgeInsets? edgeInsets;

  const CustomTextField({
    super.key,
    this.controller,
    this.isPassword,
    this.hint,
    this.textStyle,
    this.label,
    this.enabled,
    this.obscuringCharacter,
    this.value,
    this.onValidate,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onSaved,
    this.onTap,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.suffixWidget,
    this.icon,
    this.prefixIcon,
    this.action,
    this.focusNode,
    this.textDirection,
    this.edgeInsets = const EdgeInsets.only(
      top: 14,
      left: 16,
      right: 16,
      bottom: 14,
    ),
    this.hintColor = Colors.white, this.prefixtext,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    // var provider=Provider.of<ThemeProvider>(context);
    var theme = Theme.of(context);
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      textDirection: widget.textDirection,
      controller: widget.controller,
      textAlignVertical: TextAlignVertical.center,
      initialValue: widget.value,
      validator: widget.onValidate,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      obscureText: widget.isPassword ?? false ? obscureText : false,
      obscuringCharacter: '*',
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      style: widget.textStyle ??
          theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.darkScaffoldColor, fontWeight: FontWeight.w500),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: widget.action ?? TextInputAction.done,
      focusNode: widget.focusNode,
      cursorColor: theme.primaryColor,
      decoration: InputDecoration(
        prefixText: widget.prefixtext,
        labelText: widget.label,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF777777),
          fontWeight: FontWeight.w500,
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 56),
        suffixIcon: widget.isPassword ?? false
            ? InkWell(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
              )
            : widget.suffixWidget,
        prefixIcon: widget.prefixIcon,

        hintText: widget.hint,
        hintStyle: TextStyle(
          fontFamily: "Inter",
          fontSize: 16,
          color: widget.hintColor,
          fontWeight: FontWeight.w500,
        ),
        counterText: "",
        fillColor: AppColors.lightScaffoldColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.gray,
            width: 1,
          ),
        ),
        // suffix: isPass widget.suffixWidget,
        contentPadding: widget.edgeInsets,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:  BorderSide(
            color: AppColors.gray,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:  BorderSide(
            color: AppColors.gray,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:  BorderSide(
            color: AppColors.gray,
            width: 1,
          ),
        ),

        errorStyle: const TextStyle(
          color: Color(0xFFCC0000),
          fontSize: 12,
        ),
        errorMaxLines: 6,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFCC0000),
            width: 1,
          ),
        ),
      ),
    );
  }
}
