import 'package:flutter/material.dart';
import '../constant.dart';
import '../screens/transation_screen.dart';
import '../screens/personal_screen.dart';
import '../screens/couple_saving_screen.dart';

class DrawerCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: kMainColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.supervised_user_circle,
                    size: 100,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('User Name'),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, TransationScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Saving'),
            onTap: () {
              Navigator.pushNamed(context, PersonalScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Couple Saving'),
            onTap: () {
              Navigator.pushNamed(context, CoupleSavingScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
