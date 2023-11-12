import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';
  import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{

WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const ScholarChat());
}


class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.routeName :(context) => LoginPage(),
        SignUpPage.routeName:(context) => SignUpPage(),
        ChatPage.routName:(context) => ChatPage()

      },
      initialRoute: LoginPage.routeName,
    );
  }
}