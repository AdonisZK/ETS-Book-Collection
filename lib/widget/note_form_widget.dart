import 'package:flutter/material.dart';
import 'dart:io';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final String? imagePath;

  const NoteFormWidget({
    Key? key,
    this.imagePath,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              const SizedBox(height: 8),
              buildDescription(),
              const SizedBox(height: 16),
              ImageDisplayWidget(imagePath: imagePath),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );
}

class ImageDisplayWidget extends StatelessWidget {
  final String? imagePath;

  const ImageDisplayWidget({
    Key? key,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) {
      return SizedBox.shrink(); // Return an empty widget if there's no image
    }

    final file = File(imagePath!);

    return Image.file(
      file,
      width: double.infinity, // You can adjust the size as needed
      height: double.infinity, // You can adjust the size as needed
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print('Error loading image: $error');
        return Text('Error loading image');
      },
    );
  }
}