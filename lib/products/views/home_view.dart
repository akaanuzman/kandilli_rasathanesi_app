import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/base/base_singleton.dart';
import '../../core/extensions/ui_extensions.dart';
import 'map_view.dart';
import '../../uikit/button/special_button.dart';
import '../../uikit/decoration/special_container_decoration.dart';
import '../../uikit/textformfield/default_text_form_field.dart';
import 'package:provider/provider.dart';

import '../models/earthquake_model.dart';
import '../viewmodels/earthquakes_view_model.dart';

class HomeView extends StatelessWidget with BaseSingleton {
  final _earthquakeController = TextEditingController();
  HomeView({super.key});

  _goToMapPage(BuildContext context, EarthquakeModel earthquake) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EarthquakeMapView(
            model: earthquake,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle(context),
      ),
      body: FadeInRight(
        child: Consumer<EarthquakesViewModel>(
          builder: (context, pv, _) {
            return ListView(
              children: [
                context.emptySizedHeightBox3x,
                _earthquakeInfo(context),
                context.emptySizedHeightBox3x,
                _searchEarthquakeField(context, pv),
                context.emptySizedHeightBox3x,
                _sortByDateButton(context, pv),
                context.emptySizedHeightBox3x,
                _earthquakeList(context, pv),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _earthquakeInfo(BuildContext context) {
    return Container(
      decoration: SpecialContainerDecoration(context: context),
      padding: context.padding2x,
      margin: context.paddingHorizontal2x,
      child: Text(
        AppLocalizations.of(context)!.earthquakesInfo,
        style: context.textTheme.subtitle1!.copyWith(fontWeight: context.fw700),
        textAlign: context.taCenter,
      ),
    );
  }

  FadeInLeft _appBarTitle(BuildContext context) {
    return FadeInLeft(
      child: Text(AppLocalizations.of(context)!.lastEarthquakes),
    );
  }

  Padding _searchEarthquakeField(
      BuildContext context, EarthquakesViewModel pv) {
    return Padding(
      padding: context.paddingHorizontal2x,
      child: DefaultTextFormField(
        context: context,
        labelText: AppLocalizations.of(context)!.searchEarthQuake,
        prefixIcon: icons.search,
        onChanged: pv.searchEarthquake,
        controller: _earthquakeController,
      ),
    );
  }

  Padding _sortByDateButton(BuildContext context, EarthquakesViewModel pv) {
    bool isHasIcon = true;
    return Padding(
      padding: context.paddingHorizontal2x,
      child: SpecialButton(
        padding: context.padding2x,
        borderRadius: context.borderRadius4x,
        buttonLabel: AppLocalizations.of(context)!.sortByDate,
        isHasIcon: isHasIcon,
        icon: Icons.date_range_rounded,
        onTap: () => pv.sortByDate,
      ),
    );
  }

  Widget _earthquakeList(BuildContext context, EarthquakesViewModel pv) {
    bool shrinkWrap = true;
    int itemCount = pv.earthquakes.length;
    if (_earthquakeController.text.isNotEmpty) {
      itemCount = pv.searchList.length;
    }
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: context.neverScroll,
      itemCount: itemCount,
      separatorBuilder: (BuildContext context, int index) {
        return context.emptySizedHeightBox3x;
      },
      itemBuilder: (BuildContext context, int index) {
        EarthquakeModel earthquake = pv.earthquakes[index];
        if (_earthquakeController.text.isNotEmpty) {
          earthquake = pv.searchList[index];
        }
        return _eartquakeInfo(context, earthquake);
      },
    );
  }

  Container _eartquakeInfo(
    BuildContext context,
    EarthquakeModel earthquake,
  ) {
    String location = "${earthquake.lokasyon}";
    String date = "${earthquake.date}";
    double mag = earthquake.mag == null ? 0 : earthquake.mag!.toDouble();
    return Container(
      padding: context.padding2x,
      decoration: SpecialContainerDecoration(context: context),
      child: ListTile(
        onTap: () => _goToMapPage(context, earthquake),
        leading: _circleAvatarInsideIcon(context, mag),
        title: _subtitle1BoldText(
          context: context,
          data: location,
        ),
        subtitle: Text(
          date,
          style: context.textTheme.subtitle2,
        ),
        trailing: _subtitle1BoldText(
          context: context,
          data: "$mag",
        ),
      ),
    );
  }

  CircleAvatar _circleAvatarInsideIcon(BuildContext context, double mag) {
    Color bgColor = mag > 4.0
        ? colors.redAccent4
        : mag > 3.0
            ? colors.orangeAccent4
            : mag > 2.0
                ? colors.amberAccent4
                : colors.greenAccent4;
    return CircleAvatar(
      minRadius: 25,
      maxRadius: 30,
      backgroundColor: bgColor,
      child: _warningIcon(context),
    );
  }

  Icon _warningIcon(BuildContext context) {
    return Icon(
      Icons.warning,
      size: context.dynamicWidth(0.08),
      color: colors.white,
    );
  }

  Text _subtitle1BoldText({
    required BuildContext context,
    required String data,
  }) {
    return Text(
      data,
      style: context.textTheme.subtitle1!.copyWith(
        fontWeight: context.fw700,
      ),
    );
  }
}
