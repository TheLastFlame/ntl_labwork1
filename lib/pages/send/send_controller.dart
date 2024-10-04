import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'widgets/confirm_dialog.dart';

class SendController {
  VoidCallback update;

  SendController(this.update);

  Set<String> devices = {};

  Uint8List? imageData;
  bool isSending = false;

  void scan() {
    devices.clear();
    update();

    zc.scanGen(serviceId: 'ntll-service', time: Duration.zero).listen(
      (value) {
        devices.add(value.nodeId);
        update();
      },
    );
  }

  void pickFile() {
    FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    ).then(
      (value) {
        imageData = value?.files.first.bytes;
        update();
      },
    );
  }

  void broadcastSend() {
    zc.broadcastBytes(
      imageData!,
      serviceId: 'ntll-broadcast',
    );
  }

  void sendToDevice(String deviceName) async {
    var string = imageData.toString();

    isSending = true;
    update();

    final connect = await zc.connectToFirst(
      serviceId: 'ntll-service',
      nodeId: deviceName,
    );

    connect?.sendBytes(imageData!);
    connect?.sendString(string);
  }

  void privateSend(BuildContext context, String deviceName) {
    if (imageData == null) return pickFile();
    return confirmDialog(
      context,
      imageData!,
      deviceName,
      () => sendToDevice(deviceName),
    );
  }
}
