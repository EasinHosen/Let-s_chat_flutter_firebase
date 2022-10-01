import 'package:firebase_batch05/auth/auth_service.dart';
import 'package:firebase_batch05/pages/chat_room_page.dart';
import 'package:firebase_batch05/pages/launcher_page.dart';
import 'package:firebase_batch05/pages/login_page.dart';
import 'package:firebase_batch05/pages/profile_page.dart';
import 'package:firebase_batch05/pages/user_list_page.dart';
import 'package:firebase_batch05/providers/chat_room_provider.dart';
import 'package:firebase_batch05/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => ChatRoomProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    print('init');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (AuthService.user != null) {
      Provider.of<UserProvider>(context, listen: false)
          .updateAvailable(AuthService.user!.uid, {'available': true});
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    switch (state) {
      case AppLifecycleState.paused:
        {
          if (AuthService.user != null) {
            Provider.of<UserProvider>(context, listen: false)
                .updateAvailable(AuthService.user!.uid, {'available': false});
          }
          break;
        }
      case AppLifecycleState.resumed:
        {
          if (AuthService.user != null) {
            Provider.of<UserProvider>(context, listen: false)
                .updateAvailable(AuthService.user!.uid, {'available': true});
          }
          break;
        }
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (context) => const LauncherPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        ChatRoomPage.routeName: (context) => const ChatRoomPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        UserListPage.routeName: (context) => const UserListPage(),
      },
    );
  }
}
