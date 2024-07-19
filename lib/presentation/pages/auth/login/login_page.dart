import 'package:auto_route/auto_route.dart';
import 'package:chatico/common/utils/utils.dart';
import 'package:chatico/core/extension/string.dart';
import 'package:chatico/core/router/app_router.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Country _country = Country.worldWide;
  final _countryController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _phoneNumberFocus = FocusNode();
  bool _isLoading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_isLoading) {
            return;
          }
          if (_countryController.text.isEmpty) {
            setState(() {
              _error = "Country is Empty";
            });
            return;
          }
          if (!_phoneNumberController.text.isPhoneNumber()) {
            setState(() {
              _error = "Invalid Phone Number";
            });
            return;
          }

          setState(() {
            _isLoading = true;
            _error = null;
          });
          final phoneNumber =
              "+${_country.phoneCode}${_phoneNumberController.text.replaceFirst(RegExp("^[0]"), '')}";
          setState(() {
            _isLoading = false;
          });
          context.router.push(CodeVerificationRoute(
            phoneNumber: phoneNumber,
          ));
        },
        shape: const CircleBorder(),
        child: _isLoading
            ? const CircularProgressIndicator()
            : const FaIcon(FontAwesomeIcons.arrowRight),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 220,
            ),
            const Text(
              "Your number phone",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 21,
              ),
            ),
            const SizedBox(
              width: 250,
              child: Text(
                "Please confirm your country code and enter your phone number.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 36),
              child: TextField(
                readOnly: true,
                controller: _countryController,
                autofocus: true,
                onTap: () {
                  showCountryPicker(
                    context: context,
                    countryListTheme: const CountryListThemeData(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    onSelect: (value) {
                      setState(() {
                        _country = value;
                      });
                      _countryController.text = value.name;
                      _phoneNumberFocus.requestFocus();
                    },
                  );
                },
                decoration: InputDecoration(
                  labelText: "Country",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  prefix: Text(
                      "${Utils.countryCodeToEmoji(_country.countryCode)}   "),
                  suffix: const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.grey,
                    size: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 36),
              child: TextField(
                controller: _phoneNumberController,
                focusNode: _phoneNumberFocus,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Phone number",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: "00 00 00",
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        width: 44,
                        child: Text(
                          "+${_country.phoneCode}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Container(
                        height: 28,
                        width: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Visibility(
              visible: _error != null,
              child: Text(
                _error ?? "",
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
