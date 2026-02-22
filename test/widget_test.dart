// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

import 'package:bwnp/main.dart';
import 'package:bwnp/redux/AppReducer.dart';

void main() {
  testWidgets('App boots with MaterialApp', (WidgetTester tester) async {
    final store = Store<AppState>(appReducer, initialState: AppState.initial());

    await tester.pumpWidget(MyApp(store: store, token: null));

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
