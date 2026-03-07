import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/my_text_field.dart';

void main() {
  Widget buildTestWidget({
    required TextEditingController controller,
    String hintText = 'Email',
    String errorText = 'Required',
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          child: MyTextField(
            controller: controller,
            hintText: hintText,
            errorText: errorText,
            keyboardType: keyboardType,
            obscureText: obscureText,
          ),
        ),
      ),
    );
  }

  testWidgets('shows hint text', (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      buildTestWidget(controller: controller, hintText: 'Username'),
    );

    expect(find.text('Username'), findsOneWidget);
  });

  testWidgets('updates controller when user types', (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(buildTestWidget(controller: controller));

    await tester.enterText(find.byType(TextFormField), 'test@example.com');
    expect(controller.text, 'test@example.com');
  });

  testWidgets('returns validation error on empty value', (tester) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: MyTextField(
              controller: controller,
              hintText: 'Email',
              errorText: 'Please enter email',
            ),
          ),
        ),
      ),
    );

    formKey.currentState!.validate();
    await tester.pump();
    expect(find.text('Please enter email'), findsOneWidget);
  });

  testWidgets('obscures text when obscureText is true', (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      buildTestWidget(controller: controller, obscureText: true),
    );

    final editableText = tester.widget<EditableText>(find.byType(EditableText));
    expect(editableText.obscureText, isTrue);
  });
}
