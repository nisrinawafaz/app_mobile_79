import 'package:flutter/material.dart';
import 'package:taskify/shared/style.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final bool password;
  final TextEditingController? controller;
  final bool? disable;

  const CustomTextField({
    Key? key,
    this.placeholder,
    this.label,
    this.password = false,
    this.controller,
    this.disable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
            ),
            child: Text(
              label!,
              style: TextStyle(
                color: black,
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (password)
            PasswordInput(
              controller: controller!,
              placeholder: placeholder!,
            )
          else
            TextField(
              controller: controller,
              style: TextStyle(
                fontSize: 12,
                color: black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: disable! ? greySoft : mainColor.withOpacity(0.2),
                hintText: placeholder,
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: grey,
                  fontWeight: FontWeight.w600,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: mainColor,
                    width: 1,
                  ),
                ),
                enabled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: secondaryColor,
                    width: 1,
                  ),
                ),
              ),
              enabled: !disable!,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
              ],
            )
        ],
      ),
    );
  }
}

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;

  const PasswordInput({
    super.key,
    required this.controller,
    required this.placeholder,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      style: TextStyle(
        fontSize: 12,
        color: black,
      ),
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: TextStyle(
          fontSize: 12,
          color: grey,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: mainColor.withOpacity(0.2), // ganti sesuai mainColor
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: mainColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: secondaryColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red.shade200, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red.shade400, width: 2),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Password cannot be empty';
        return null;
      },
    );
  }
}
