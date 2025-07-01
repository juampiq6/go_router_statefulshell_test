import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_test/A_detail.dart';
import 'package:router_test/screenA.dart';
import 'package:router_test/screenB.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}

final router = GoRouter(
  initialLocation: '/a',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('GoRouter'),
            leading: context.canPop() ? BackButton() : null,
          ),
          body: navigationShell,
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'A'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'B'),
            ],
            currentIndex: navigationShell.currentIndex,
            onTap: (index) {
              navigationShell.goBranch(index);
            },
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/a',
              builder: (context, state) => const ScreenA(),
              routes: [
                GoRoute(
                  path: 'detail',
                  builder: (context, state) => const ScreenADetail(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/b', builder: (context, state) => const ScreenB()),
          ],
        ),
      ],
    ),
  ],
);
