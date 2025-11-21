import 'package:flutter/material.dart';

extension WidgetExtenstion on Widget {
  Widget get toSliver {
    return SliverToBoxAdapter(child: this);
  }

  Widget all(double margin) {
    return Padding(padding: EdgeInsets.all(margin), child: this);
  }

  Widget xy(double marginX, [double? marginY]) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: marginX,
        vertical: marginY ?? marginX,
      ),
      child: this,
    );
  }

  Widget x(double margin) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin),
      child: this,
    );
  }

  Widget y(double margin) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: margin),
      child: this,
    );
  }

  Widget l(double margin) {
    return Padding(
      padding: EdgeInsets.only(left: margin),
      child: this,
    );
  }

  Widget t(double margin) {
    return Padding(
      padding: EdgeInsets.only(top: margin),
      child: this,
    );
  }

  Widget r(double margin) {
    return Padding(
      padding: EdgeInsets.only(right: margin),
      child: this,
    );
  }

  Widget b(double margin) {
    return Padding(
      padding: EdgeInsets.only(bottom: margin),
      child: this,
    );
  }

  Widget ifNull(Widget? other) {
    return other ?? this;
  }

  Widget ifCond(bool showWhen, Widget other) {
    return showWhen ? this : other;
  }

  Widget get expand {
    return Expanded(child: this);
  }

  Widget onTap(VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }
}
