import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:ntl_labwork1/pages/images.dart';
import 'package:ntl_labwork1/pages/send_page.dart';
import 'package:zeroconnect/zeroconnect.dart';

import 'pages/private_page.dart';

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
      ImagesContext.of(rootKey.currentContext!)!.images.add(img!);
    },
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServers();
  runApp(const TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ImagesContext(
      images: [],
      child: MaterialApp(
        key: rootKey,
        theme: ThemeData(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                padding: const EdgeInsets.only(left: 24),
                splashBorderRadius: BorderRadius.circular(13),
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: const [
                  MyTab(
                    text: 'Public Images',
                    icon: Icons.group_work_outlined,
                  ),
                  MyTab(
                    text: 'Private Images',
                    icon: Icons.lock_outline,
                  ),
                  MyTab(
                    text: 'Send',
                    icon: Icons.screen_share_outlined,
                  ),
                ],
              ),
              title: const Text('Not [ TheLast ] Labwork'),
            ),
            body: const TabBarView(
              children: [
                Icon(Icons.group_work_outlined),
                PrivatePage(),
                SendPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTab extends StatelessWidget {
  const MyTab({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Icon(icon), const SizedBox(width: 8), Text(text)],
      ),
    );
  }
}
