import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/desktop_auth_controller.dart';

class SessionMonitorWidget extends StatelessWidget {
  const SessionMonitorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<DesktopAuthController>();
      final remaining = controller.remainingSeconds.value;
      if (remaining > 0 && remaining < 120) {
        return SessionWarningBanner(
          remainingSeconds: remaining,
          onExtendSession: () => controller.refreshToken(),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

class SessionWarningBanner extends StatelessWidget {
  final int remainingSeconds;
  final VoidCallback onExtendSession;
  const SessionWarningBanner({super.key, required this.remainingSeconds, required this.onExtendSession});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Session expires in \$remainingSeconds seconds'),
          TextButton(onPressed: onExtendSession, child: const Text('Extend')),
        ],
      ),
    );
  }
}
