import 'package:firebase_batch05/auth/auth_service.dart';
import 'package:firebase_batch05/pages/chat_room_page.dart';
import 'package:firebase_batch05/pages/launcher_page.dart';
import 'package:firebase_batch05/pages/profile_page.dart';
import 'package:firebase_batch05/pages/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: AuthService.user!.displayName == null ||
                    AuthService.user!.displayName!.isEmpty
                ? const Text('Unnamed User')
                : Text(AuthService.user!.displayName!),
            accountEmail: Text(AuthService.user!.email!),
            currentAccountPicture: AuthService.user!.photoURL == null ||
                    AuthService.user!.photoURL!.isEmpty
                ? Image.asset('assets/images/person.png')
                : Image.network(AuthService.user!.photoURL!),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, UserListPage.routeName);
            },
            leading: Icon(Icons.people),
            title: Text('Users'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, ChatRoomPage.routeName);
            },
            leading: Icon(Icons.chat),
            title: Text('Chat Room'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, ProfilePage.routeName);
            },
            leading: Icon(Icons.person),
            title: Text('Profile'),
          ),
          ListTile(
            onTap: () async {
              Provider.of<UserProvider>(context, listen: false)
                  .updateAvailable(AuthService.user!.uid, {'available': false});
              await AuthService.logout();
              Navigator.pushReplacementNamed(context, LauncherPage.routeName);
            },
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          )
        ],
      ),
    );
  }
}
