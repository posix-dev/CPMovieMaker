import 'dart:io';

import 'package:flutter/material.dart';

class MovieCardWidget extends StatelessWidget {
  final String thumb;
  final String title;

  MovieCardWidget(this.thumb, this.title);

  @override
  Widget build(BuildContext context) {
    final radius = 8.0;
    final borderRadius = Radius.circular(radius);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: borderRadius,
                  topRight: borderRadius,
                ),
                child: Image.file(
                  File(thumb),
                  fit: BoxFit.fitWidth,
                  width: constraints.maxWidth,
                  height: constraints.maxWidth,
                )),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: borderRadius,
                bottomRight: borderRadius,
              ),
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight - constraints.maxWidth - radius,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16, fontFamily: "Roboto-Light"),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
