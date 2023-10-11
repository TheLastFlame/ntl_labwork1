import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ntl_labwork1/main.dart';

isLandscape(context) => MediaQuery.sizeOf(context).width >= 456 + 200;

class SendPage extends StatefulWidget {
  const SendPage({super.key});

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  @override
  void initState() {
    scanner();
    super.initState();
  }

  Set devices = {};
  Uint8List? imageData;
  bool isSending = false;

  void scanner() {
    if (context.mounted) {
      setState(() {
        devices.clear();
      });
    }
    zc
        .scanGen(
      serviceId: 'ntll-service',
      time: Duration.zero,
    )
        .listen(
      (value) {
        if (context.mounted) {
          setState(() {
            devices.add(value.nodeId);
          });
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void filePicker() {
    FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    ).then(
      (value) {
        if (context.mounted) {
          setState(() {
            imageData = value?.files.first.bytes;
          });
        }
      },
    );
  }

  void confirmDialog(String e) {
    showDialog(
      context: context,
      builder: (_) {
        send() async {
          var string = imageData.toString();
          // var limit = 1000000;

          if (context.mounted) {
            setState(() {
              isSending = true;
            });
          }

          final connect = await zc.connectToFirst(
            serviceId: 'ntll-service',
            nodeId: e,
          );

          connect?.sendBytes(imageData!);
          connect?.sendString(string);

          // for (int i = 0; i < string.length; i += limit) {
          //   var end = i + limit;
          //   if (end > string.length) {
          //     end = string.length;
          //     setState(() {
          //       isSending = false;
          //     });
          //   }
          //   connect?.sendString(string.substring(i, end));
          // }
        }

        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Are your sure?'),
              Text(
                'Send to $e',
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
                  send();
                },
                child: const Text('Confirm'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: isLandscape(context) ? Axis.horizontal : Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 16,
              right: 16,
            ),
            child: Container(
              height: 300,
              width: 440,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: SizedBox.expand(
                          child: Center(
                            child: imageData == null
                                ? const Icon(Icons.image)
                                : Image.memory(imageData!),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: filePicker, child: const Text('Select')),
                        ElevatedButton(
                            onPressed: imageData == null
                                ? null
                                : () async {
                                    zc.broadcastBytes(
                                      imageData!,
                                      serviceId: 'ntll-broadcast',
                                    );
                                  },
                            child: const Text('Send to all'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: isLandscape(context) ? double.infinity : 472,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text(isSending ? 'Sending...' : 'Scanning...'),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: LinearProgressIndicator(minHeight: 1),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: devices
                          .map(
                            (e) => DeviceCard(
                              device: e.replaceAll('-', '.'),
                              onTap: () => imageData != null
                                  ? confirmDialog(e)
                                  : filePicker(),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  const DeviceCard({
    super.key,
    required this.device,
    required this.onTap,
  });
  final String device;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: SizedBox(
          height: 48,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: onTap,
            leading: const Icon(Icons.devices),
            title: Center(
              heightFactor: 0,
              child: Text(device, textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }
}
