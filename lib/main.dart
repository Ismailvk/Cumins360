import 'package:cumins36/controller/login/login_bloc.dart';
import 'package:cumins36/controller/signup/signup_bloc.dart';
import 'package:cumins36/data/shared_preference.dart';
import 'package:cumins36/view/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreference.instance.initStorage();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCjRmxalUuu-KqT8mO_zkhRBGX0K29jH88",
      appId: "1:41562949456:android:438ff14c048cdd58380e55",
      messagingSenderId: "41562949456",
      projectId: "cumins36-bc184",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupBloc>(create: (context) => SignupBloc()),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          buttonTheme: const ButtonThemeData(buttonColor: Colors.black),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
