import 'dart:typed_data';

import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.imageData,
    required this.deviceName,
    required this.onSend,
  });

  final Uint8List imageData;
  final String deviceName;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Are your sure?'),
          Text(
            'Send to $deviceName',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
      content: Image.memory(imageData!),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onSend();
            },
            child: const Text('Confirm'))
      ],
    );
  }
}

void confirmDialog(
  BuildContext context,
  Uint8List imageData,
  String deviceName,
  VoidCallback onSend,
) =>
    showDialog(
      context: context,
      builder: (_) {
        return ConfirmDialog(
          imageData: imageData,
          deviceName: deviceName,
          onSend: onSend,
        );
      },
    );
