import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart'; 

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.leading,
    this.trailing,
    this.validator,
    this.obscureText = false,
    this.isPhoneNumber = false, 
    this.phoneController, 
    this.onInputChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final Widget? leading;
  final Widget? trailing;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool isPhoneNumber;
  final TextEditingController? phoneController;
  final Function(PhoneNumber)? onInputChanged; 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: leading!,
            ),
          ],
          Expanded(
            child: isPhoneNumber
                ? InternationalPhoneNumberInput(
                    onInputChanged: onInputChanged,
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    textFieldController: phoneController,
                    inputDecoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                    ),
                  )
                : TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: obscureText,
                    controller: controller,
                    validator: validator,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                    ),
                  ),
          ),
          if (trailing != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: trailing!,
            ),
          ],
        ],
      ),
    );
  }
}
