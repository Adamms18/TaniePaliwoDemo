import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool get _isDarkMode => themeNotifier.value == ThemeMode.dark;

  Future<void> _toggleDarkMode(bool value) async {
    themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ustawienia'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Tryb ciemny'),
            value: _isDarkMode,
            onChanged: _toggleDarkMode,
            secondary: const Icon(Icons.dark_mode),
          ),
          const Divider(),
          const Center(child: Text('Strona Ustawień')),
        ],
      ),
    );
  }
}