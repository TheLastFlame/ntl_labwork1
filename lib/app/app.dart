import 'package:flutter/material.dart';
import 'package:ntl_labwork1/app/tab.dart';
import 'package:ntl_labwork1/pages/images/private_page.dart';
import 'package:ntl_labwork1/pages/send/send_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            padding: const EdgeInsets.only(left: 24),
            splashBorderRadius: BorderRadius.circular(13),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: const [
              MyTab(
                text: 'Get',
                icon: Icons.image,
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
            PrivatePage(),
            SendPage(),
          ],
        ),
      ),
    );
  }
}
