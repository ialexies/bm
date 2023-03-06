import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class TabBarEach extends StatelessWidget {
  const TabBarEach(this._title, this._count);

  final String _title;
  final int _count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_title),
        badges.Badge(
          badgeStyle: const badges.BadgeStyle(
            badgeColor: Colors.black,
          ),
          badgeContent: Text(
            _count.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          child: const Icon(
            Icons.image,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
