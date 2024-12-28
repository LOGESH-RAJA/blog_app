import 'dart:io';
import 'dart:math';

import 'package:blog_app/core/common/pick_image.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/blog/presenstation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final TextEditingController _blogTitle = TextEditingController();
  final TextEditingController _blogContent = TextEditingController();
  List<String> selectedtopics = [];
  File? image;
  @override
  void dispose() {
    _blogTitle.dispose();
    _blogContent.dispose();
    super.dispose();
  }

  // Select image from the Gallery
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Blog"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  selectImage();
                },
                child: image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            )),
                      )
                    : DottedBorder(
                        color: AppPallete.borderColor,
                        dashPattern: const [20, 4],
                        borderType: BorderType.RRect,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text("Select you Image",
                                  style:
                                      Theme.of(context).textTheme.titleMedium)
                            ],
                          ),
                        )),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children:
                        ['Technology', 'Gaming', 'Bussiness', 'Programming']
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedtopics.contains(e)) {
                                      selectedtopics.remove(e);
                                    } else {
                                      selectedtopics.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                      color: selectedtopics.contains(e)
                                          ? const WidgetStatePropertyAll(
                                              AppPallete.gradient1)
                                          : null,
                                      side: selectedtopics.contains(e)
                                          ? null
                                          : const BorderSide(
                                              color: AppPallete.borderColor),
                                      label: Text(e)),
                                ),
                              ),
                            )
                            .toList()),
              ),
              BlogEditor(
                  textEditingController: _blogTitle, hintText: "Blog Title"),
              const SizedBox(
                height: 20,
              ),
              BlogEditor(
                  textEditingController: _blogContent, hintText: "Blog Content")
            ],
          ),
        ),
      ),
    );
  }
}
