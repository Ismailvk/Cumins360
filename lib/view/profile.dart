import 'dart:io';
import 'package:cumins36/data/shared_preference.dart';
import 'package:cumins36/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ImagePicker picker = ImagePicker();
  File? imageFile;

  @override
  void initState() {
    super.initState();
    String? profile = SharedPreference.instance.getProfile();
    if (profile != null) {
      imageFile = File(profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
              child:
                  imageFile == null ? const Icon(Icons.person, size: 40) : null,
            ),
            const SizedBox(height: 5),
            Text(auth.currentUser!.displayName!),
            Text(auth.currentUser!.email!),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Update Profile'),
              onTap: () {
                showUpdateProfileBottomSheet(context, (File? image) {
                  setState(() {
                    imageFile = image;
                  });
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                showPopup(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void showUpdateProfileBottomSheet(
      BuildContext context, Function(File?) onImageSelected) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          imageFile != null ? FileImage(imageFile!) : null,
                      child: imageFile == null
                          ? const Icon(Icons.person, size: 40)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () async {
                          File? selectedImage = await pickImage();
                          onImageSelected(selectedImage);
                          await SharedPreference.instance
                              .storeProfile(selectedImage?.path);
                          Navigator.pop(context);
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.edit),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Additional content can go here
              ],
            ),
          ),
        );
      },
    );
  }

  Future<File?> pickImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to proceed?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await auth.signOut();
                  SharedPreference.instance.storeToken('0');
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                } catch (e) {
                  //
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
