import 'package:collab_doc/feature/settings/presentation/view/widgets/appareditprofile.dart';
import 'package:collab_doc/feature/settings/presentation/view/widgets/buttonseditprofile.dart';
import 'package:collab_doc/feature/settings/presentation/view/widgets/textformfieldedit.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final TextEditingController _usernameController =
      TextEditingController(text: "JohnDoe");
  final TextEditingController _emailController =
      TextEditingController(text: "john.doe@example.com");
  final TextEditingController _phoneController =
      TextEditingController(text: "+123456789");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApparEditProfile(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextfieldEditProfile(
              controller: _usernameController,
              labelText: "username",
              prefixIcon: Icon(Icons.person),
            ),
            const SizedBox(height: 16),
            TextfieldEditProfile(
              controller: _emailController,
              labelText: "email",
              prefixIcon: Icon(Icons.email),
            ),
            const SizedBox(height: 16),
            TextfieldEditProfile(
              controller: _phoneController,
              labelText: "Phone Number",
              prefixIcon: Icon(Icons.phone),
            ),
            const Spacer(),
            ButtonsEditProfile(),
          ],
        ),
      ),
    );
  }
}
