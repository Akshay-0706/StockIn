import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() async {
  FlutterDriver driver = await FlutterDriver.connect();

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    await driver.close();
  });
  test('Check flutter driver health', () async {
    Health health = await driver.checkHealth();
    print(health.status);
  });

  group("Clicking on", () {
    // test("Login", () async {
    //   // final login =
    //   // await driver.waitFor(login);
    //   final login = find.text("Login");
    //   await driver.waitFor(login);
    //   await driver.tap(login);

    //   print("Login button tapped!");
    // });

    test("scroll", () async {
      await driver.waitFor(find.text("Market Mood Index"));
      await driver.scrollIntoView(find.text("Market Mood Index"));
      await driver.waitFor(find.text("Top Losers"));
      print("Scrolled!");
    });

    test("Indices", () async {
      // final login =
      // await driver.waitFor(login);
      final indices = find.text("Indices");
      await driver.waitFor(indices);
      await driver.tap(indices);

      print("Indices button tapped!");
    });
  });
}
