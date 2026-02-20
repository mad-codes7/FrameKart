import 'package:flutter_test/flutter_test.dart';
import 'package:ar_app2/main.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const FurnitureARApp());
    expect(find.text('AR Furniture'), findsOneWidget);
  });
}
