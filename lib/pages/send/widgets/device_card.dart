import 'package:flutter/material.dart';

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
