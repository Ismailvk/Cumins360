import 'package:cumins36/controller/login/login_bloc.dart';
import 'package:cumins36/view/signup.dart';
import 'package:cumins36/widgets/button.dart';
import 'package:cumins36/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Sign in to continue',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Form(
                    key: loginKey,
                    child: Column(
                      children: [
                        MyTextField(
                          validator: (value) => null,
                          controller: emailController,
                          hintText: 'Enter Your Email',
                        ),
                        SizedBox(height: size.height * 0.02),
                        MyTextField(
                          validator: (value) => null,
                          controller: passwordController,
                          hintText: 'Enter Your Password',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ButtonWidget(
                        title: 'Login',
                        onPress: () {
                          if (loginKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(LoginUser(
                                context: context,
                                email: emailController.text.trim(),
                                password: passwordController.text));
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account ? "),
                      GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen())),
                          child: const Center(
                              child: Text(
                            'Signup',
                            style: TextStyle(color: Colors.blue),
                          ))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
