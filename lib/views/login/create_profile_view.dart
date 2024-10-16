import 'dart:io';

import 'package:chat/constants/routes.dart';
import 'package:chat/services/auth/auth_controller.dart';
import 'package:chat/theme/palette.dart';
import 'package:chat/utils/functions/pick_image_from_gallery.dart';
import 'package:chat/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateProfileView extends ConsumerStatefulWidget {
  const CreateProfileView({super.key});

  @override
  ConsumerState<CreateProfileView> createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends ConsumerState<CreateProfileView> {
  late final TextEditingController _name;
  File? image;

  @override
  void initState() {
    _name = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  Future<void> storeUserData() async {
    String name = _name.text.trim();
    if (name.isNotEmpty) {
      // Navigate to account creation loading screen
      Navigator.pushNamed(context, loadingRoute);

      ref
          .read(authControllerProvider)
          .saveUserDataToFirebase(context, name, image);

      Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 30),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 100,
                                backgroundColor: Palette.profileColor,
                                foregroundImage:
                                    image != null ? FileImage(image!) : null,
                                child: const Icon(Icons.person, size: 120),
                              ),
                              IconButton(
                                onPressed: selectImage,
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: size.width * 0.75),
                            child: TextField(
                              controller: _name,
                              decoration: const InputDecoration(
                                hintText: 'Profile Name',
                                prefix: Text('~ '),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: size.width * 0.8),
                              child: CustomButton(
                                text: 'Done',
                                onPressed: storeUserData,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
