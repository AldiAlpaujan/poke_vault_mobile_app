import 'package:flutter/material.dart';

class AppGridMenu extends StatelessWidget {
  final List<Widget> items;
  final int columnCount;
  final double verticalGap;
  final double horizontalGap;

  const AppGridMenu({
    super.key,
    required this.items,
    this.columnCount = 4,
    this.verticalGap = 8,
    this.horizontalGap = 8,
  });

  @override
  Widget build(BuildContext context) {
    List<List<Widget>> menuGroups = [];

    var wantedRowCount = (items.length / columnCount).ceil();
    var wantedItemCount = wantedRowCount * columnCount;
    var emptyItemCount = wantedItemCount - items.length;

    for (var i = 0; i < items.length; i += columnCount) {
      var g = items
          .sublist(
            i,
            (i + columnCount) > items.length ? items.length : (i + columnCount),
          )
          .map<Widget>((e) => e)
          .toList();

      if (g.length != columnCount && emptyItemCount > 0) {
        g.addAll(List.generate(emptyItemCount, (index) => Container()));
      }
      menuGroups.add(g);
    }

    var tmpRow = menuGroups
        .map(
          (x) => [
            SizedBox(height: verticalGap),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: x
                    .map(
                      (y) => [
                        SizedBox(width: horizontalGap),
                        Expanded(child: y),
                      ],
                    )
                    .expand((y) => y)
                    .skip(1)
                    .toList(),
              ),
            ),
          ],
        )
        .expand((x) => x)
        .skip(1)
        .toList();

    return Column(children: tmpRow);
  }
}
