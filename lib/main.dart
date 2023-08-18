import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoomclone/controller/authController.dart';
import 'package:zoomclone/controller/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: Root(),
    );
  }
}

class Root extends StatelessWidget {
  Root({super.key});
  AuthController auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return auth.user.value == null ? const Login() : Home();
    });
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.1),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Create and join meetings",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Image(image: AssetImage('assets/onboarding.jpg')),
          SizedBox(
            height: 20,
          ),
          ButtonTheme(
            minWidth: 130,
            child: ElevatedButton(
              onPressed: () {
                Get.find<AuthController>().login();
              },
              child: Text("Login with google"),
            ),
          ),
        ],
      )),
    );
  }
}
