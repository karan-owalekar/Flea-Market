import 'package:flutter/material.dart';

import '../data.dart';
import './category_style.dart';

class CategorieWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 50,
        mainAxisSpacing: 50,
        childAspectRatio: 3 / 2,
      ),
      delegate: SliverChildListDelegate(DUMMY_CATEGORIES
          .map((item) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategorieStyle(
                  item.id,
                  item.title,
                  item.image,
                  item.description,
                ),
              ))
          .toList()),
    );
  }
}
