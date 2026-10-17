import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_practice/model/user_model.dart';
import 'package:rest_api_practice/provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Login"), centerTitle: true),

          body: Padding(
            padding: const EdgeInsets.all(20),

            child: Form(
              key: formKey,

              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextFormField(
                      validator: provider.validateUsername,
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      validator: provider.validatePassword,
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: provider.isLoading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  UserModel model = UserModel(
                                    username: usernameController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                  provider.login(model, context);
                                }
                              },
                        child: provider.isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text("Login"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
