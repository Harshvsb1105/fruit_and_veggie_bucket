import 'package:fruit_and_veggie_bucket/src/model/model.dart';
import 'package:flutter/material.dart';

class Screen {
  final String title;
  final ScreenEnum screenEnum;
  final Widget child;

  Screen(this.title, this.screenEnum, this.child);
}

final Screen cart = Screen('CART', ScreenEnum.cart, CartScreen());
final Screen home = Screen('HOME', ScreenEnum.home, HomeScreen());
final Screen account = Screen('ACCOUNT', ScreenEnum.account, AccountScreen());