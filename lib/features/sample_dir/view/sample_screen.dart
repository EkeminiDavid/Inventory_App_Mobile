import 'package:flutter/material.dart';
import 'package:inv_management_app/features/sample_dir/provider/sample_controller.dart';
import 'package:provider/provider.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final controller = Provider.of<SampleProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(controller.crazy.toString()),
            ElevatedButton(
                onPressed: () {
                  controller.calc();
                },
                child: const Text('Click me'))
          ],
        ),
      ),
    );
  }
}
