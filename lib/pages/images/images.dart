import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImagesNotifier extends ChangeNotifier {
  final List<Uint8List> _images = [];

  List<Uint8List> get images => _images;

  void addImage(Uint8List image) {
    _images.add(image);
    notifyListeners();
  }
}

class ImagesContext extends InheritedNotifier<ImagesNotifier> {
  const ImagesContext({
    super.key,
    required ImagesNotifier notifier,
    required super.child,
  }) : super(notifier: notifier);

  static ImagesNotifier? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ImagesContext>()
        ?.notifier;
  }

  @override
  bool updateShouldNotify(
      covariant InheritedNotifier<ImagesNotifier> oldWidget) {
    return notifier != oldWidget.notifier;
  }
}
