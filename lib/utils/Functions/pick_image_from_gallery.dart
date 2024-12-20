import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chat/utils/helpers/show_snack_bar.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    if (context.mounted) showSnackBar(context: context, content: e.toString());
  }
  return image;
}
