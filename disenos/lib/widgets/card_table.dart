import 'dart:ui';

import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {
  const CardTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            _SingleCard(
                color: Colors.blue, icon: Icons.border_all, text: 'General'),
            _SingleCard(
                color: Colors.purple, icon: Icons.car_rental, text: 'Transport')
          ],
        ),
        TableRow(
          children: <Widget>[
            _SingleCard(
                color: Colors.pinkAccent,
                icon: Icons.shopping_bag,
                text: 'Shopping'),
            _SingleCard(
                color: Colors.yellowAccent, icon: Icons.ac_unit, text: 'Bills')
          ],
        ),
        TableRow(
          children: <Widget>[
            _SingleCard(
                color: Colors.blueAccent,
                icon: Icons.movie,
                text: 'Entretenimiento'),
            _SingleCard(
                color: Colors.greenAccent,
                icon: Icons.access_alarms_outlined,
                text: 'relot')
          ],
        ),
        TableRow(
          children: <Widget>[
            _SingleCard(
                color: Colors.blueAccent,
                icon: Icons.movie,
                text: 'Entretenimiento'),
            _SingleCard(
                color: Colors.greenAccent,
                icon: Icons.access_alarms_outlined,
                text: 'relot')
          ],
        ),
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _SingleCard({
    Key? key,
    required this.icon,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CardBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: this.color,
            child: Icon(
              this.icon,
              size: 35,
              color: Colors.white,
            ),
            radius: 30,
          ),
          SizedBox(height: 10),
          Text(
            this.text,
            style: TextStyle(color: this.color, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class _CardBackground extends StatelessWidget {
  const _CardBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: Color.fromRGBO(62, 66, 107, 0.7),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: this.child,
          ),
        ),
      ),
    );
  }
}
