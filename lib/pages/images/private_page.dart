import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ntl_labwork1/main.dart';
import 'package:ntl_labwork1/pages/images/images.dart';

class PrivatePage extends StatefulWidget {
  const PrivatePage({super.key});

  @override
  State<PrivatePage> createState() => _PrivatePageState();
}

class _PrivatePageState extends State<PrivatePage> {
  late List<Uint8List> items;

  @override
  void didChangeDependencies() {
    setState(() {
      items = ImagesContext.of(context)!.images;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Your ip: ${localId.replaceAll('-', '.')}'),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              children: items
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 400),
                          child: Card(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                FilePicker.platform.saveFile(
                                  dialogTitle: 'Please select an output file:',
                                  fileName: 'image.jpg',
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Image.memory(e),
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
