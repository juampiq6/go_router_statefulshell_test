import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            leading:
                navigationShell.shellRouteContext.navigatorKey.currentContext
                            ?.canPop() ??
                        false
                    ? BackButton()
                    : Icon(Icons.question_mark_rounded),
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

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('Screen A')),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.push('/a/detail');
            },
            child: const Text('Go to detail'),
          ),
        ],
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Screen B'));
  }
}

class ScreenADetail extends StatelessWidget {
  const ScreenADetail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Screen A Detail'));
  }
}
