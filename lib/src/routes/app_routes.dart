import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kpu/src/features/domain/people.dart';
import 'package:kpu/src/features/presentation/home_page.dart';
import 'package:kpu/src/features/presentation/people_add_page.dart';
import 'package:kpu/src/features/presentation/people_detail_page.dart';
import 'package:kpu/src/features/presentation/people_page.dart';
import 'package:kpu/src/features/presentation/splash_page.dart';
import 'package:kpu/src/routes/routes.dart';

enum Routes {
  splash,
  login,
  people,
  peopleAdd,
  register,
  home,
  detail,
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      initialLocation: '/splash',
      // initialLocation: ref.read(hiveServiceProvider).getUser() != null ? '/home' : '/login',
      routerNeglect: true,
      redirectLimit: 1,
      routes: [
        GoRoute(
          path: '/splash',
          name: Routes.splash.name,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/home',
          name: Routes.home.name,
          builder: (context, state) => const HomePage(),
          routes: const [],
        ),
        GoRoute(
          path: '/people',
          name: Routes.people.name,
          builder: (context, state) => const PeoplePage(),
        ),
        GoRoute(
          path: '/detail',
          name: Routes.detail.name,
          builder: (context, state) {
            final extras = state.extra as Extras;
            final data = extras.datas['people'] as People;
            return PeopleDetailPage(people: data);
          },
        ),
        GoRoute(
          path: '/people-add',
          name: Routes.peopleAdd.name,
          builder: (context, state) => const PeopleAddPage(),
        ),
      ],
      errorBuilder: (context, state) => ErrorPage(
        error: state.error,
      ),
    );
  },
);
