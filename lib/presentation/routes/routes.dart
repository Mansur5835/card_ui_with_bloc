import 'package:credit_card_ui/presentation/pages/add_card_style/add_card_style_page.dart';
import 'package:credit_card_ui/presentation/pages/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import '../pages/edit_card/edit_card_page.dart';
import 'app_navigator.dart';
import 'package:page_transition/page_transition.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    args.set = settings.arguments;

    switch (settings.name) {
      case DashboardPage.route:
        return PageTransition(
          child: DashboardPage(),
          alignment: Alignment.center,
          type: PageTransitionType.scale,
          settings: settings,
        );

      case AddCardStylePage.route:
        return PageTransition(
          child: AddCardStylePage(),
          alignment: Alignment.center,
          type: PageTransitionType.scale,
          settings: settings,
        );

      case EditCardPage.route:
        return PageTransition(
          child: EditCardPage(),
          alignment: Alignment.center,
          type: PageTransitionType.bottomToTop,
          settings: settings,
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
