import 'package:credit_card_ui/presentation/bloc_providers/providers.dart';
import 'package:credit_card_ui/presentation/pages/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_setting/app_init.dart';
import 'core/app_setting/app_setting.dart';
import 'presentation/routes/routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main(List<String> args) async {
  await AppInit.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers(context),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: ThemeData(
            bottomSheetTheme:
                const BottomSheetThemeData(backgroundColor: Colors.transparent),
          ),
          onGenerateTitle: AppSetting(),
          initialRoute: DashboardPage.route,
          onGenerateRoute: RouteManager.generateRoute,
        ),
      ),
    );
  }
}
