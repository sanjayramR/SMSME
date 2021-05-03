import 'package:flutter/material.dart';
import 'customappbar.dart';
import 'package:clip_shadow/clip_shadow.dart';


Widget curvedappBar(){
  return PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: ClipShadow(
            clipper: Customappbar(),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  spreadRadius: 10,
                  offset: Offset(0.0, 1.0))
            ],
            child: Stack(fit: StackFit.expand, children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0xff7b1fa2), const Color(0xff18ffff)],
                    tileMode: TileMode.repeated,
                  ),
                ),
              ),
            ]),
          ),
        );
 }
