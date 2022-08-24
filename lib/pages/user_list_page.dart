import 'package:firebase_batch05/providers/user_provider.dart';
import 'package:firebase_batch05/wigets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListPage extends StatefulWidget {
  static const String routeName = '/user_list_page';
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool isCalled = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (isCalled) {
      Provider.of<UserProvider>(context, listen: false).getAllUsers();
      isCalled = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User list'),
      ),
      drawer: MainDrawer(),
      body: Consumer<UserProvider>(
        builder: (context, provider, _) => Column(
          children: [
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        height: 1,
                      ),
                  itemCount: provider.userList.length,
                  itemBuilder: (context, index) {
                    var user = provider.userList[index];
                    return ListTile(
                      title: user.name == null
                          ? Text(user.email!)
                          : Text(user.name!),
                      subtitle: user.available
                          ? Text('Available')
                          : Text('Unavailable'),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
