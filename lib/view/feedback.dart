import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cumins36/widgets/button.dart';
import 'package:cumins36/widgets/textfield.dart';
import 'package:cumins36/model/post_model.dart';

class FeedbackScreen extends StatefulWidget {
  final Function(PostModel) onSubmit;

  const FeedbackScreen({super.key, required this.onSubmit});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _selectImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        _image = File(selectedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            GestureDetector(
              onTap: _selectImage,
              child: Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[200],
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : const Icon(Icons.add_photo_alternate,
                        size: 100, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16.0),
            MyTextField(
                validator: (value) {
                  if (value!.isEmpty || titleController.text.trim().isEmpty) {
                    return 'Please add title';
                  } else {
                    return null;
                  }
                },
                controller: titleController,
                hintText: "Enter Title"),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  hintText: 'Enter Description',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  labelText: 'Description'),
              maxLines: 5,
            ),
            const SizedBox(height: 20.0),
            ButtonWidget(
              title: 'Submit Post',
              onPress: () => submitPost(),
            )
          ],
        ),
      ),
    );
  }

  void submitPost() {
    String title = titleController.text.trim();
    String description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please fill all fields and select an image'),
      ));
      return;
    } else {
      PostModel newPost = PostModel(
        image: _image!.path,
        title: title,
        description: description,
        isFile: true,
      );
      widget.onSubmit(newPost);
      Navigator.of(context).pop();
    }
  }
}
