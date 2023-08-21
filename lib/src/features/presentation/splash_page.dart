import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kpu/gen/assets.gen.dart';
import 'package:kpu/src/common_widgets/common_widgets.dart';
import 'package:kpu/src/routes/app_routes.dart';
import 'package:kpu/src/shared/extensions/extensions.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => SplashPageState();
}

class SplashPageState extends ConsumerState<SplashPage> {
  @override
  initState() {
    _navigateOtherScreen();
    super.initState();
  }

  void _navigateOtherScreen() {
    Future.delayed(const Duration(seconds: 3)).then((_) async {
      context.goNamed(Routes.home.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarWidget(
      child: Scaffold(
        body: CircleBackgroundWidget(
          child: Center(
            child: Assets.icons.kpuLogo.svg(
              width: context.screenWidthPercentage(0.60),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
