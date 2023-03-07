import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

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
        const SizedBox(
          width: 5,
        ),
        badges.Badge(
          badgeStyle: const badges.BadgeStyle(
            badgeColor: Colors.amber,
          ),
          badgeContent: Text(
            _count.toString(),
            style: const TextStyle(
              color: Colors.black,
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
