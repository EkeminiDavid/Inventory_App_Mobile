import 'package:flutter/material.dart';
import 'package:inv_management_app/components/universal/universal_settings.dart';
import 'package:inv_management_app/features/sample_dir/provider/sample_controller.dart';
import 'package:provider/provider.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
        // final controller = Provider.of<CounterModel>(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Consumer<ThemeModel>(
            //   builder: (context, counter, child) {
            //     return Text(controller.name);
            //   }
            // ),
            // ElevatedButton(
            //     onPressed: () {
            //       controller.changeName();
            //     },
            //     child: const Text('Click me'))
          ],
        ),
      ),
    );
  }
}
