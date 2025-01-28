import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app_images.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_event.dart';
import '../../bloc/auth_bloc/auth_state.dart';
import '../../text_editing_сontrollers/auth_text_editing_сontrollers.dart';
import 'package:prayer_bloc/screens/authorisation/widgets/auth_input_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.success) {
              context.go('/main-screen');
            } else if (state.status == AuthStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message ?? 'Registration failed')),
              );
            }
          },
          child: Stack(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return Container(
                height: constraints.maxHeight * 0.45,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.backGround),
                    fit: BoxFit.contain,
                  ),
                ),
              );
            }),
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
                    children: [
                      const Text(
                        'Registration',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      CustomInputField(
                        controller: AuthTextEditingControllers.signUpName,
                        labelText: 'Name',
                        fieldType: FieldType.name,
                        isObscureText: false,
                      ),
                      SizedBox(height: 10),
                      CustomInputField(
                        controller: AuthTextEditingControllers.signUpEmail,
                        labelText: 'Email',
                        fieldType: FieldType.email,
                        isObscureText: false,
                      ),
                      SizedBox(height: 10),
                      CustomInputField(
                        controller: AuthTextEditingControllers.signUpPassword,
                        labelText: 'Password',
                        fieldType: FieldType.password,
                      ),
                      SizedBox(height: 10),
                      CustomInputField(
                        controller:
                            AuthTextEditingControllers.signUpConfirmPassword,
                        labelText: 'Confirm password',
                        fieldType: FieldType.confirmPassword,
                      ),
                      SizedBox(height: 20),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return ElevatedButton(
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
                              if (AuthTextEditingControllers
                                      .signUpName.text.isNotEmpty &&
                                  AuthTextEditingControllers
                                      .signUpEmail.text.isNotEmpty &&
                                  AuthTextEditingControllers
                                      .signUpPassword.text.isNotEmpty &&
                                  AuthTextEditingControllers
                                          .signUpPassword.text ==
                                      AuthTextEditingControllers
                                          .signUpConfirmPassword.text) {
                                context.read<AuthBloc>().add(AuthEvent(
                                    email: AuthTextEditingControllers
                                        .signUpEmail.text,
                                    password: AuthTextEditingControllers
                                        .signUpPassword.text,
                                    name: AuthTextEditingControllers
                                        .signUpName.text));
                              }
                            },
                            child: const Text('Register'),
                          );
                        },
                      ),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () => context.go('/sign-in'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account?",
                                    style: TextStyle(color: Colors.black54)),
                                const Text(" Sign in",
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
