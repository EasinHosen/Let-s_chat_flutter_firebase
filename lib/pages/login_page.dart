import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_batch05/auth/auth_service.dart';
import 'package:firebase_batch05/models/user_model.dart';
import 'package:firebase_batch05/pages/profile_page.dart';
import 'package:firebase_batch05/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscure = true;
  bool isNewUser = false;

  String errMsg = '';

  final form_key = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: form_key,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'This field cannot be empty';
                    } else if (val.length < 6) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: (isObscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: authenticate,
                  child: isNewUser
                      ? const Text('Register')
                      : const Text('Login'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New user?'),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isNewUser = !isNewUser;
                          });
                        },
                        child: const Text('Click here!'))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Forgot password?'),
                    TextButton(
                        onPressed: () {
                        },
                        child: const Text('Click here!'))
                  ],
                ),
                const SizedBox(height: 10,),
                Text(errMsg, style: TextStyle(color: Theme.of(context).errorColor),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  authenticate() async{

    if(form_key.currentState!.validate()){
      bool status;
      try{
        if(isNewUser){
          status = await AuthService.register(emailController.text, passwordController.text);
          await AuthService.sendVerificationEmail();
          final userModel = UserModel(
              uid: AuthService.user!.uid,
              email: AuthService.user!.email
          );
          await Provider.of<UserProvider>(context, listen: false).addUser(userModel);
        }else{
          status = await AuthService.login(emailController.text, passwordController.text);
        }
        if(status){
          if(!mounted) return;
          Navigator.pushReplacementNamed(context, ProfilePage.routeName);
        }
      } on FirebaseAuthException catch(e){
        setState((){
          errMsg = e.message!;
        });
      }
    }
  }
}



