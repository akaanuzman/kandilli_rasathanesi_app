import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kandilli_rasathanesi_app/core/base/base_singleton.dart';
import 'package:kandilli_rasathanesi_app/core/extensions/ui_extensions.dart';
import 'package:kandilli_rasathanesi_app/uikit/decoration/special_container_decoration.dart';
import 'package:kandilli_rasathanesi_app/uikit/textformfield/default_text_form_field.dart';

class HomeView extends StatelessWidget with BaseSingleton {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle(context),
      ),
      body: FadeInRight(
        child: ListView(
          children: [
            _searchEarthquakeField(context),
            context.emptySizedHeightBox2x,
            _earthquakeList(context),
          ],
        ),
      ),
    );
  }

  FadeInLeft _appBarTitle(BuildContext context) {
    return FadeInLeft(
      child: Text(AppLocalizations.of(context)!.lastEarthquakes),
    );
  }

  Padding _searchEarthquakeField(BuildContext context) {
    return Padding(
      padding: context.padding2x,
      child: DefaultTextFormField(
        context: context,
        labelText: AppLocalizations.of(context)!.searchEarthQuake,
        prefixIcon: icons.search,
      ),
    );
  }

  ListView _earthquakeList(BuildContext context) {
    bool shrinkWrap = true;
    int itemCount = 10;
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: context.neverScroll,
      itemCount: itemCount,
      separatorBuilder: (BuildContext context, int index) {
        return context.emptySizedHeightBox3x;
      },
      itemBuilder: (BuildContext context, int index) {
        return _item(context);
      },
    );
  }

  Container _item(BuildContext context) {
    return Container(
      padding: context.padding2x,
      decoration: SpecialContainerDecoration(context: context),
      child: ListTile(
        leading: _circleAvatarInsideIcon(context),
        title: _subtitle1BoldText(
          context: context,
          data: "H. HUSEYINYAYLASI-BIGA (CANAKKALE)",
        ),
        subtitle: Text(
          "2022.12.18 23:43:58",
          style: context.textTheme.subtitle2,
        ),
        trailing: _subtitle1BoldText(
          context: context,
          data: "4.4",
        ),
      ),
    );
  }

  CircleAvatar _circleAvatarInsideIcon(BuildContext context) {
    return CircleAvatar(
      minRadius: 25,
      maxRadius: 30,
      backgroundColor: colors.redAccent4,
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
