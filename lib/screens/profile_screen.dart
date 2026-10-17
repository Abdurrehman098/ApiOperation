import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_practice/provider/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  final String token;

  const ProfileScreen({
    super.key,
    required this.token,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).profile(widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final user = provider.user;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
          ),

          body: user == null
              ? const Center(
            child: Text("No profile data"),
          )
              : Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ID: ${user.id}",
                  style: const TextStyle(fontSize: 20),
                ),

                const SizedBox(height: 15),

                Text(
                  "Username: ${user.username}",
                  style: const TextStyle(fontSize: 20),
                ),

                const SizedBox(height: 15),

                Text(
                  "Password: ${user.password}",
                  style: const TextStyle(fontSize: 20),
                ),
                

              ],
            ),
          ),
        );
      },
    );
  }
}