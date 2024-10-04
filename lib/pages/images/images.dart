import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImagesContext extends InheritedWidget {
  final List<Uint8List> images;

  const ImagesContext({
    super.key,
    required this.images,
    required super.child,
  });

  static ImagesContext? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ImagesContext>();
  }

  @override
  bool updateShouldNotify(ImagesContext oldWidget) {
    return images != oldWidget.images;
  }
}
