import 'package:flutter/services.dart';

Future<void> settingUpSystemUIOverlay() async {
// Setting SystemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      statusBarColor: Color(0x00000000),
      systemNavigationBarColor: Color(0x00000000),
      systemNavigationBarDividerColor: Color(0x00000000),
    ),
  );
// Setting SystemUIMode
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}
