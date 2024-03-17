import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_asap/core/theme/app_theme.dart';
import 'package:reto_asap/core/utils/pick_image.dart';
import 'package:reto_asap/core/utils/show_snackbar.dart';
import 'package:reto_asap/features/articles/domain/entities/local_article.dart';
import 'package:reto_asap/features/articles/presentation/bloc/local_article_bloc.dart';
import 'package:reto_asap/features/articles/presentation/widgets/create_article_field.dart';

class CreateArticlePage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateArticlePage());
  const CreateArticlePage({super.key});

  @override
  State<CreateArticlePage> createState() => _CreateArticlePageState();
}

class _CreateArticlePageState extends State<CreateArticlePage> {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController contentCtrl = TextEditingController();
  final TextEditingController autorCtrl = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: selectImage,
                      child: SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          )),
                    )
                  : GestureDetector(
                      onTap: selectImage,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: AppPalleteColor.grey,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.folder_open, size: 50),
                            SizedBox(height: 15),
                            Text(
                              "Select your image",
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ['Technology', 'Business', 'Programming', 'Entertainment']
                          .map((type) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedTopics.contains(type)) {
                                      selectedTopics.remove(type);
                                    } else {
                                      selectedTopics.add(type);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: Text(type),
                                    color: selectedTopics.contains(type)
                                        ? const MaterialStatePropertyAll(
                                            AppPalleteColor.gradient1)
                                        : null,
                                    side: selectedTopics.contains(type)
                                        ? null
                                        : const BorderSide(
                                            color: AppPalleteColor.grey,
                                          ),
                                  ),
                                ),
                              ))
                          .toList(),
                ),
              ),
              const SizedBox(height: 20),
              CreateArticleField(controller: autorCtrl, hintText: "Autor"),
              const SizedBox(height: 20),
              CreateArticleField(
                  controller: titleCtrl, hintText: "Article tilte"),
              const SizedBox(height: 20),
              CreateArticleField(
                  controller: contentCtrl, hintText: "Article content"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (image != null) {
            context.read<LocalArticleBloc>().add(OnCreateLocalArticle(
                  article: LocalArticle(
                    autor: autorCtrl.text.trim(),
                    title: titleCtrl.text.trim(),
                    content: contentCtrl.text.trim(),
                    imageUrl: image!.path,
                    topics: selectedTopics,
                    updatedAt: DateTime.now(),
                  ),
                ));
            Navigator.pop(context);
          } else {
            showSnackBar(context, "Choose an Image");
          }
        },
        child: const Icon(Icons.save_alt_outlined),
      ),
    );
  }
}
