import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_app/greenpoint_profile.dart';
import 'package:get_app/mix.dart';
import 'package:get_app/my_home_page.dart';
import 'package:get_app/profile.dart';
import 'package:get_app/store.dart';

class Appdrawer extends StatefulWidget {
  const Appdrawer({super.key});

  @override
  State<Appdrawer> createState() => _AppdrawerState();
}

class _AppdrawerState extends State<Appdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 98, 204, 128)),
            child: Text(
              '์Napatํs Drawer',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
            onTap: () {
              Get.to(() => const MyHomePage(title: 'Home'));
            },
          ),
          ListTile(
            leading: Icon(Icons.grid_view),
            title: Text('Mixpage'),
            onTap: () {
              Get.to(() => const MixPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              Get.to(() => const ProfilePage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.eco),
            title: const Text('Profile Greenpoint'),
            onTap: () {
              Get.to(() => const GreenPointApp());
            },
          ),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Store'),
            onTap: () {
              Get.to(() => const StorePage());
            },
          ),
        ],
      ),
    );
  }
}
