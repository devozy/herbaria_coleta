import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:herbaria_coleta/form_page/atributo_page.dart';
import 'package:herbaria_coleta/form_page/coleta_page.dart';
import 'package:herbaria_coleta/form_page/planta_page.dart';
import 'package:herbaria_coleta/list_page/lista_atributos.dart';
import 'package:herbaria_coleta/list_page/lista_coletas.dart';
import 'package:herbaria_coleta/list_page/lista_plantas.dart';

Widget makeTestable(Widget widget) => MaterialApp(home: widget);
void main() {
  testWidgets('Check if main screen loads', (widgetTester) async {
    await widgetTester.pumpWidget(makeTestable(ListaColetas()));
    var finder = find.byType(AppBar);
    expect(finder, findsOneWidget);
  });

  testWidgets('Check if plants screen loads', (widgetTester) async {
    await widgetTester
        .pumpWidget(makeTestable(ListaPlantas(4, 'projeto', '2023-01-01')));
    var finder = find.byType(AppBar);
    expect(finder, findsOneWidget);
  });

  testWidgets('Check if attribute screen loads', (widgetTester) async {
    await widgetTester.pumpWidget(makeTestable(ListaAtributos(1)));
    var finder = find.byType(AppBar);
    expect(finder, findsOneWidget);
  });

  testWidgets('Check if attribute edition screen loads', (widgetTester) async {
    await widgetTester
        .pumpWidget(makeTestable(AtributoPage(1, 2, '1', '1', '1')));
    var finder = find.byType(AppBar);
    expect(finder, findsOneWidget);
  });

  testWidgets('Check if collect edition screen loads', (widgetTester) async {
    await widgetTester.pumpWidget(makeTestable(ColetaPage(1)));
    var finder = find.byType(AppBar);
    expect(finder, findsOneWidget);
  });

  testWidgets('Check if plant edition screen loads', (widgetTester) async {
    await widgetTester.pumpWidget(makeTestable(PlantaPage(1)));
    var finder = find.byType(AppBar);
    expect(finder, findsOneWidget);
  });
}
