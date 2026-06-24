import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('fk_user_agent');

  TestWidgetsFlutterBinding.ensureInitialized();

  late int invocationCount;

  Map<String, dynamic> responseForCall(int callNumber) {
    return <String, dynamic>{
      'userAgent': 'agent-$callNumber',
      'webViewUserAgent': 'web-$callNumber',
      'buildNumber': '$callNumber',
    };
  }

  setUp(() {
    invocationCount = 0;
    FkUserAgent.release();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      expect(methodCall.method, 'getProperties');
      invocationCount += 1;
      return responseForCall(invocationCount);
    });
  });

  tearDown(() {
    FkUserAgent.release();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('init caches properties and populates getters', () async {
    await FkUserAgent.init();
    await FkUserAgent.init();

    expect(invocationCount, 1);
    expect(FkUserAgent.userAgent, 'agent-1');
    expect(FkUserAgent.webViewUserAgent, 'web-1');
    expect(FkUserAgent.getProperty('buildNumber'), '1');
  });

  test('force init refetches native properties', () async {
    await FkUserAgent.init();
    await FkUserAgent.init(force: true);

    expect(invocationCount, 2);
    expect(FkUserAgent.userAgent, 'agent-2');
  });

  test('release clears cached properties', () async {
    await FkUserAgent.init();

    FkUserAgent.release();

    expect(FkUserAgent.properties, isNull);
  });

  test('getPropertyAsync initializes lazily', () async {
    final dynamic buildNumber = await FkUserAgent.getPropertyAsync('buildNumber');

    expect(invocationCount, 1);
    expect(buildNumber, '1');
  });

  test('properties map is unmodifiable', () async {
    await FkUserAgent.init();

    expect(
      () => FkUserAgent.properties!['anotherKey'] = 'value',
      throwsUnsupportedError,
    );
  });
}
