import 'package:flutter/material.dart';
import 'package:ntl_labwork1/pages/send/widgets/device_card.dart';
import 'package:ntl_labwork1/pages/send/send_controller.dart';

isLandscape(context) => MediaQuery.sizeOf(context).width >= 456 + 200;

class SendPage extends StatefulWidget {
  const SendPage({super.key});

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  late final controller = SendController(() => setState(() {}));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.scan();
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
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.zero,
                  child: InkWell(
                    onTap: controller.pickFile,
                    child: SizedBox.expand(
                      child: Center(
                        child: controller.imageData == null
                            ? const Icon(Icons.image)
                            : Image.memory(controller.imageData!),
                      ),
                    ),
                  ),
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
                  Text(controller.isSending ? 'Sending...' : 'Scanning...'),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: LinearProgressIndicator(minHeight: 1),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: controller.devices
                          .map(
                            (e) => DeviceCard(
                              device: e.replaceAll('-', '.'),
                              onTap: () => controller.privateSend(context, e),
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
