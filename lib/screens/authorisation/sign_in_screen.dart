import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer_bloc/screens/authorisation/widgets/auth_input_field.dart';

import '../../app_images.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_event.dart';
import '../../bloc/auth_bloc/auth_state.dart';
import '../../text_editing_сontrollers/auth_text_editing_сontrollers.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
      if (state.status == AuthStatus.success) {
        context.go('/main-screen');
      } else if (state.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message ?? 'Authentication failed')),
        );
      }},
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: constraints.maxHeight * 0.45,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.backGround),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
             Align(
               alignment: Alignment.center,
               child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16.0),
                     child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Log in',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              const SizedBox(height: 45),
                              CustomInputField(
                                controller: AuthTextEditingControllers.signInEmail,
                                labelText: 'Enter your e-mail',
                                fieldType: FieldType.signInEmail,
                                isObscureText: false,
                              ),
                              CustomInputField(
                                controller: AuthTextEditingControllers.signInPassword,
                                labelText: 'Enter your password',
                                fieldType: FieldType.signInPassword,
                                isObscureText: true,
                              ),
                              const SizedBox(height: 40),
                              BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  return Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                        AuthTextEditingControllers.isFormFilled
                                            ? Colors.black
                                            : Colors.grey.shade300,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 50),
                                        minimumSize: const Size(400, 60),
                                      ),
                                      onPressed: () {
                                        if (AuthTextEditingControllers.signUpEmail
                                            .text.isNotEmpty &&
                                            AuthTextEditingControllers
                                                .signInPassword.text.isNotEmpty) {
                                          context.read<AuthBloc>().add(AuthEvent(
                                            email: AuthTextEditingControllers
                                                .signUpEmail.text,
                                            password:
                                            AuthTextEditingControllers
                                                .signInPassword.text,
                                          ));
                                        }
                                      },
                                      child: const Text('Confirm'),
                                    ),
                                  );
                                },
                              ),
                              Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: () => context.go('/sign-up'),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text("Don't have an account yet?",
                                            style: TextStyle(color: Colors.black54)),
                                        const Text(" Sign up",
                                            style: TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    ),
                  ),
             ),
          ],
        ),
      ),
    );
  }
}
