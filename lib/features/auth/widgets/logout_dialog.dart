import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final bool showLogoutAllOption;
  const LogoutDialog({super.key, this.showLogoutAllOption = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Choose logout option'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop('current'),
          child: const Text('This device'),
        ),
        if (showLogoutAllOption)
          TextButton(
            onPressed: () => Navigator.of(context).pop('all'),
            child: const Text('All devices'),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
