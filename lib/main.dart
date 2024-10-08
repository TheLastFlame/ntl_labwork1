import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:ntl_labwork1/app/app.dart';
import 'package:ntl_labwork1/app/edge2edge.dart';
import 'package:ntl_labwork1/pages/images/images.dart';
import 'package:zeroconnect/zeroconnect.dart';

late String localId;
GlobalKey rootKey = GlobalKey();
late final ZeroConnect zc;

Future<void> initServers() async {
  localId = (await NetworkInfo().getWifiIP())!.replaceAll('.', '-');
  zc = ZeroConnect(localId: localId);

  var serviceId = "ntll-service";
  await zc.advertise(
    port: 16699,
    serviceId: serviceId,
    callback: (messageSock, nodeId, serviceId) async {
      var img = await messageSock.recvBytes();
      ImagesContext.of(rootKey.currentContext!)!.addImage(img!);
    },
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await settingUpSystemUIOverlay();
  await initServers();
  runApp(const TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ImagesContext(
      notifier: ImagesNotifier(),
      child: MaterialApp(
        key: rootKey,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: App(),
      ),
    );
  }
}
