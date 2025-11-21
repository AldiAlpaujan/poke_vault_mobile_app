import 'dart:math';

import 'package:flutter/material.dart';

const _lorem =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

extension ContextExt<T> on BuildContext {
  String lorem([int sub = 20]) => _lorem.substring(0, sub);

  String fakeImg([
    int width = 100,
    int height = 100,
    String bg = 'ddd',
    String txt = 'fff',
  ]) {
    int random = Random().nextInt(10);
    return "https://picsum.photos/$width/$height?random=$random";
  }
}
