import 'package:flutter/material.dart';
import '../../core/base/base_singleton.dart';
import '../../core/extensions/ui_extensions.dart';
import 'home_view.dart';
import 'package:provider/provider.dart';

import '../viewmodels/earthquakes_view_model.dart';

class SplashView extends StatelessWidget with BaseSingleton {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final pv = Provider.of<EarthquakesViewModel>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: pv.getLatestEarthquakes(),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: ListView(
                  physics: context.neverScroll,
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Text(
                        constants.appTitle,
                        style: context.textTheme.headline6,
                      ),
                    )
                  ],
                ),
              );
            default:
              return HomeView();
          }
        }),
      ),
    );
  }
}
