import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../models/api_models/user/Geolocation/geolocation.dart';
import '../../../../models/api_models/user/address/address.dart';
import '../../../../models/api_models/user/name/user_name.dart';
import '../../../../models/api_models/user/user.dart';
import '../../../../services/api/profile/fetch_profile/fetch_profile.dart';
import '../../../../services/api/profile/update_profile/update_profile.dart';
import '../../../../view_models/login/login_provider.dart';
import '../../../../view_models/theme_provider/colors/common.dart';
import '../../../../view_models/theme_provider/theme.dart';
import '../../../widgets/assets/icons/app_icons.dart';
import '../../../widgets/buttons/filled_button.dart';
import '../../../widgets/circle_profile/circle_profile.dart';
import '../../../widgets/tb/tb.dart';
import '../../../widgets/text/texts.dart';
import '../../../widgets/tf/textfields.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _accountNoController = TextEditingController();
  final _accHolderNameController = TextEditingController();
  final _ifscController = TextEditingController();

  FetchProfile fetchProfile = FetchProfile();
  UpdateProfileAPI updateAPI = UpdateProfileAPI();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.watch<ThemeProvider>().currentTheme.colorScheme;
    return Scaffold(
      backgroundColor: themeColor.primary,
      appBar: AppBar(
          backgroundColor: themeColor.primary,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                  color: themeColor.secondary, AppIcons.backIcon, scale: 2)),
          title: TextWidget(
              color: themeColor.secondary,
              text: "Checkout",
              fontFamily: "M600",
              fontSize: 18),
          centerTitle: true),
      body: FutureBuilder(
          future: fetchProfile.getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: LottieBuilder.asset(
                    "assets/animations/page Animation - 1729675763838.json"),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: TextWidget(
                    text: "Unable To Fetch",
                    color: themeColor.secondary,
                    fontSize: 23,
                    fontFamily: "M500"),
              );
            } else {
              User user = snapshot.data!;
              _emailController.text = user.email!;
              _passwordController.text = user.password!;
              _pincodeController.text = user.address!.zipcode!;
              _addressController.text = user.address!.street!;
              _cityController.text = user.address!.city!;
              _stateController.text = "England";
              _countryController.text = "India";
              _accountNoController.text = "204356XXXXXXX";
              _accHolderNameController.text = "Abhiraj Sisodiya";
              _ifscController.text = "SBIN00428";
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.only(top: 31),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: CircleProfile(event: () {})),
                      const SizedBox(height: 28),
                      TextWidget(
                          color: themeColor.secondary,
                          text: "Personal Details",
                          fontFamily: "M600",
                          fontSize: 18),
                      const SizedBox(height: 15),
                      TextWidget(
                          color: themeColor.secondary,
                          text: "Email",
                          fontFamily: "M400",
                          fontSize: 12),
                      const SizedBox(height: 10),
                      TextFields(
                          fontSize: 13,
                          controller: _emailController,
                          fontFamily: "M600",
                          fillColor: themeColor.primaryContainer,
                          border: const OutlineInputBorder(),
                          keyboardType: TextInputType.emailAddress,
                          hintText: ''),
                      const SizedBox(height: 23),
                      const Text("Password",
                          style: TextStyle(fontFamily: "M400", fontSize: 12)),
                      const SizedBox(height: 10),
                      Consumer<LoginProvider>(
                        builder: (context, consumer, child) => TextFields(
                            hidePass: consumer.isShown,
                            suffixImage: IconButton(
                                onPressed: () {
                                  consumer.changeView();
                                },
                                icon: !consumer.isShown
                                    ? Image.asset(AppIcons.eyeShow, scale: 2)
                                    : Icon(Icons.visibility_off,
                                        color: themeColor.onSecondary)),
                            controller: _passwordController,
                            fontSize: 13,
                            fontFamily: "M600",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xff3a3a3a))),
                            keyboardType: TextInputType.text,
                            fillColor: themeColor.primaryContainer,
                            hintText: ''),
                      ),
                      const SizedBox(height: 14),
                      Container(
                          height: 20,
                          alignment: Alignment.centerRight,
                          child: TB(
                              style: ButtonStyle(
                                  overlayColor: WidgetStatePropertyAll(
                                      themeColor.tertiary),
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsets.all(0))),
                              event: () {},
                              text: "Change Password",
                              weight: "J500",
                              color: CommonColors.buttonColor,
                              decoration: TextDecoration.underline,
                              decorationColor: CommonColors.buttonColor)),
                      const SizedBox(height: 36),
                      Divider(thickness: 0.5, color: themeColor.tertiary),
                      const SizedBox(height: 34),
                      const Text("Business Address Details",
                          style: TextStyle(fontFamily: "M600", fontSize: 16)),
                      const SizedBox(height: 15),
                      const Text("Pincode",
                          style: TextStyle(fontFamily: "M400", fontSize: 12)),
                      const SizedBox(height: 10),
                      TextFields(
                          controller: _pincodeController,
                          fontSize: 13,
                          fontFamily: "M600",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: themeColor.outline)),
                          keyboardType: TextInputType.number,
                          fillColor: themeColor.primaryContainer,
                          hintText: ''),
                      const SizedBox(height: 23),
                      const Text("Address",
                          style: TextStyle(fontFamily: "M400", fontSize: 12)),
                      const SizedBox(height: 10),
                      TextFields(
                          controller: _addressController,
                          fontSize: 13,
                          fontFamily: "M600",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: themeColor.outline)),
                          keyboardType: TextInputType.text,
                          hintText: '',
                          fillColor: themeColor.primaryContainer),
                      const SizedBox(height: 23),
                      TextWidget(
                          color: themeColor.secondary,
                          text: "City",
                          fontFamily: "M400",
                          fontSize: 12),
                      const SizedBox(height: 10),
                      TextFields(
                          controller: _cityController,
                          fontSize: 13,
                          fontFamily: "M600",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: themeColor.outline)),
                          keyboardType: TextInputType.text,
                          fillColor: themeColor.primaryContainer,
                          hintText: ''),
                      const SizedBox(height: 28),
                      const Text("State",
                          style: TextStyle(fontFamily: "M400", fontSize: 12)),
                      const SizedBox(height: 15),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black87),
                              borderRadius: BorderRadius.circular(8),
                              color: themeColor.primaryContainer),
                          child: DropdownMenu(
                              textStyle:
                                  TextStyle(color: themeColor.onSecondary),
                              controller: _stateController,
                              menuHeight: 200,
                              menuStyle: MenuStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(themeColor.primary),
                              ),
                              hintText: "--State",
                              enableSearch: true,
                              selectedTrailingIcon: Container(
                                  transform:
                                      Matrix4.rotationX(double.maxFinite),
                                  transformAlignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/icons/view_Vector 33 (1).png",
                                    scale: 2,
                                    color: themeColor.tertiary,
                                  )),
                              trailingIcon: Image.asset(
                                "assets/icons/view_Vector 33 (1).png",
                                scale: 2,
                                color: themeColor.tertiary,
                              ),
                              width: double.maxFinite,
                              dropdownMenuEntries: const [
                                DropdownMenuEntry(
                                    value: "England", label: "England"),
                                DropdownMenuEntry(
                                    value: "Scotland", label: "Scotland"),
                                DropdownMenuEntry(
                                    value: "Wales", label: "Wales"),
                                DropdownMenuEntry(
                                    value: "Northern Ireland",
                                    label: "Northern Ireland")
                              ])),
                      const SizedBox(height: 15),
                      TextWidget(
                          color: themeColor.secondary,
                          text: "Country",
                          fontFamily: "M400",
                          fontSize: 12),
                      const SizedBox(height: 15),
                      TextFields(
                          controller: _countryController,
                          fontSize: 13,
                          fontFamily: "M600",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: themeColor.outline)),
                          keyboardType: TextInputType.text,
                          fillColor: themeColor.primaryContainer,
                          hintText: ''),
                      const SizedBox(height: 34),
                      Divider(thickness: 0.5, color: themeColor.tertiary),
                      const SizedBox(height: 32),
                      TextWidget(
                          color: themeColor.secondary,
                          text: "Bank Account Details",
                          fontFamily: "M600",
                          fontSize: 16),
                      const SizedBox(height: 15),
                      Text("Bank Account Number",
                          style: TextStyle(
                              fontFamily: "M400",
                              fontSize: 12,
                              color: themeColor.secondary)),
                      const SizedBox(height: 10),
                      TextFields(
                          controller: _accountNoController,
                          fontSize: 13,
                          fontFamily: "M600",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: themeColor.outline)),
                          keyboardType: TextInputType.number,
                          fillColor: themeColor.primaryContainer,
                          hintText: ''),
                      const SizedBox(height: 15),
                      TextWidget(
                          color: themeColor.secondary,
                          text: "Account Holder's Name",
                          fontFamily: "M400",
                          fontSize: 12),
                      const SizedBox(height: 10),
                      TextFields(
                          controller: _accHolderNameController,
                          fontSize: 13,
                          fontFamily: "M600",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: themeColor.outline)),
                          keyboardType: TextInputType.name,
                          fillColor: themeColor.primaryContainer,
                          hintText: ''),
                      const SizedBox(height: 15),
                      TextWidget(
                          color: themeColor.secondary,
                          text: "IFSC Code",
                          fontFamily: "M400",
                          fontSize: 12),
                      const SizedBox(height: 10),
                      TextFields(
                          controller: _ifscController,
                          fontSize: 13,
                          fontFamily: "M600",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: themeColor.outline)),
                          keyboardType: TextInputType.text,
                          fillColor: themeColor.primaryContainer,
                          hintText: ''),
                      const SizedBox(height: 34),
                      Row(children: [
                        Expanded(
                            child: ColoredButton(
                          event: () async {
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String pincode = _pincodeController.text;
                            String address = _addressController.text;
                            String city = _cityController.text;
                            /*String state = _stateController.text;
                            String country = _countryController.text;*/
                            String name = _accHolderNameController.text;
                            User updateUser = User(
                                phone: user.phone,
                                iV: user.iV,
                                name: Name(
                                    firstname: name.split(" ")[0],
                                    lastname: name.split(" ")[1]),
                                id: user.id,
                                username: _accHolderNameController.text,
                                email: email,
                                password: password,
                                address: Address(
                                  geolocation: Geolocation(
                                      lat: user.address!.geolocation!.lat,
                                      long: user.address!.geolocation!.long),
                                  number: user.address!.number,
                                  zipcode: pincode,
                                  street: address,
                                  city: city,
                                ));
                            User? result =
                                await updateAPI.updateProfile(updateUser);
                            if (result != null) {
                              const snackBar = SnackBar(
                                  backgroundColor: CommonColors.greyC,
                                  content: TextWidget(
                                      fontFamily: "M500",
                                      text: "Profile Successfully updated",
                                      color: CommonColors.whiteC));
                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          },
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 32),
                          borderRadius: 8,
                          backColor: CommonColors.buttonColor,
                          text: 'Save',
                          fontFamily: "M600",
                          fontSize: 15,
                        ))
                      ]),
                      const SizedBox(height: 57)
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
