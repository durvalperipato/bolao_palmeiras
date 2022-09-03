import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        final bool admin = user.displayName! == 'Durval Peripato Neto';
        Modular.to.pushNamed('/home', arguments: {
          "name": user.displayName,
          "user_id": user.uid,
          "admin": admin,
          "avatar": user.photoURL,
        });
      } else {
        Modular.to.pushNamed(
          '/login',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/fundo.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator.adaptive(),
                SizedBox(
                  height: 32,
                ),
                Text('Preparem as apostas...')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
