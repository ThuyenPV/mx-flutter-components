import 'package:flutter/material.dart';

typedef OnObservation = void Function(Route<dynamic> route, Route<dynamic> previousRoute);

class TestNavigatorObserver extends NavigatorObserver {
  late OnObservation onPushed;
  late OnObservation onPopped;
  late OnObservation onRemoved;
  late OnObservation onReplaced;
  late OnObservation onStartUserGesture;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      onPushed(route, previousRoute);
    }
  }

  attachPushRouteObserver(String expectedRouteName, Function pushCallback) {
    onPushed = (route, previousRoute) {
      final isExpectedRoutePushed = route.settings.name == expectedRouteName;

      /// trigger callback if expected route is pushed
      if (isExpectedRoutePushed) {
        pushCallback();
      }
    };
  }

  attachPushRouteObserverWithArgs(String expectedRouteName, VoidCallback pushCallback(Object args)) {
    onPushed = (route, previousRoute) {
      final isExpectedRoutePushed = route.settings.name == expectedRouteName;

      /// trigger callback if expected route is pushed
      if (isExpectedRoutePushed) {
        if (route.settings.arguments != null) {
          pushCallback(route.settings.arguments!);
        }
      }
    };
  }
}
