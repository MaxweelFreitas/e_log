import 'dart:convert';

import 'package:e_log/core/base/e_log.dart';
import 'package:e_log/core/base/x_term/x_term_color.dart';
import 'package:e_log/helpers/elegant_json.dart';
import 'package:test/test.dart';

void main() {
  test('elegant json ...', () async {
    String exampleJsonString = jsonEncode(
      {
        'user': {
          'id': 12345,
          'name': 'Alice Johnson',
          'email': 'alice.johnson@example.com',
          'address': {
            'street': '123 Elm Street',
            'number': '24B',
            'city': 'Metropolis',
            'zipcode': '12345'
          },
          'active': true,
          'roles': ['admin', 'user']
        }
      },
    );

    final result = ElegantJson.print(
      jsonString: exampleJsonString,
      lineLength: 50,
      dividerColor: XTermColor.red,
      keyColor: XTermColor.green,
      valueColor: XTermColor.magenta,
    );

    eLog(result);
  });
}
