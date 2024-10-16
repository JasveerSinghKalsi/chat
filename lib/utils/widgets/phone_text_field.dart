import 'package:chat/theme/palette.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneTextField extends StatefulWidget {
  final TextEditingController phone;
  final Function(String) getCountryCode;
  const PhoneTextField({
    super.key,
    required this.phone,
    required this.getCountryCode,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  String _selectedCountryCode = '91';
  String _selectedCountryFlag = '🇮🇳';

  void _pickCountry() {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        setState(() {
          _selectedCountryCode = country.phoneCode;
          _selectedCountryFlag = country.flagEmoji;
          widget.getCountryCode(_selectedCountryCode);
        });
      },
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        textStyle: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: TextField(
        controller: widget.phone,
        keyboardType: TextInputType.phone,
        style: const TextStyle(fontSize: 20),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          prefixIcon: GestureDetector(
            onTap: _pickCountry,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_selectedCountryFlag,
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(
                    '+$_selectedCountryCode',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          hintText: 'Phone',
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Palette.dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Palette.tabColor),
          ),
        ),
      ),
    );
  }
}
