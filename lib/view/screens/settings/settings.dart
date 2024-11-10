import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/shared_pref/theme_store/theme_pref.dart';
import '../../../view_models/theme_provider/theme.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text("Your Account"),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Account Settings"),
          ),
          const ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text("Privacy"),
          ),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Account Settings"),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text("Theme"),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text("Dark Theme"),
            // onTap: () {
            //   context.read<ThemeProvider>().toggleTheme();
            // })
            trailing: CupertinoSwitch(
                activeColor: const Color(0xffF83758),
                value: !context.watch<ThemeProvider>().isThemeLight,
                onChanged: (value) {
                  context.read<ThemeProvider>().toggleTheme();
                  ThemePrefManager.storeTheme(
                      context.read<ThemeProvider>().isThemeLight);
                }),
          )
        ],
      ),
    );
  }
}
