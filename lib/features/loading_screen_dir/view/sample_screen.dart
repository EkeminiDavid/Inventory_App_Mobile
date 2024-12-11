import 'package:flutter/material.dart';
import 'package:inv_management_app/components/universal/universal_settings.dart';
import 'package:inv_management_app/features/sample_dir/provider/sample_controller.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 8,
              child: Container(
                height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.height/5,
                child: const Column(
                  mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Please wait...'),
                    CircularProgressIndicator(strokeCap: StrokeCap.round, strokeWidth: 6.0,)
                  ],
                ),
              ),
            )
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
