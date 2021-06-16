library sparkler_button;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SparklerButton extends StatefulWidget {
  final Text title;
  final Color bgColor;
  final double height;
  final double width;
  final int interval;
  final int time;
  final Color highlightColor;
  final GestureTapCallback onclick;

  const SparklerButton({
    Key? key,
    required this.title,
    required this.bgColor,
    required this.onclick,
    this.highlightColor = Colors.white,
    this.height = 50.0,
    this.width = 280.0,
    this.interval = 3,
    this.time = 300,
  }) : super(key: key);

  @override
  _SparklerButtonState createState() => _SparklerButtonState();
}

class _SparklerButtonState extends State<SparklerButton> with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  late Timer _timer;
  late int _count;

  void _loopAnimation(int sparklerCount) {
    if (sparklerCount == 1) {
      setState(() {
        _timer = Timer(
          Duration(seconds: widget.interval),
          _forward,
        );
      });
    } else {
      _forward();
    }
  }

  @override
  void initState() {
    super.initState();
    _count = 0;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.time),
      lowerBound: 0.0,
      upperBound: 0.1,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((listener) {
        if (listener == AnimationStatus.completed) {
          _controller.reverse();
        } else if (listener == AnimationStatus.dismissed) {
          if (_count == 1) {
            _count = 0;
          } else {
            _count++;
          }
          _loopAnimation(_count);
        }
      });
    _loopAnimation(_count);
  }

  void _forward() {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 + _controller.value;

    return GestureDetector(
      onTap: widget.onclick,
      child: Transform.scale(
        scale: _scale,
        child: _sparklerButton,
      ),
    );
  }

  Widget get _sparklerButton => Container(
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                width: widget.width,
                height: widget.height,
                child: ElevatedButton(
                  onPressed: () async {
                    return null;
                  },
                  child: null,
                  style: ElevatedButton.styleFrom(
                      primary: widget.bgColor,
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        left: 15.0,
                        right: 15.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      textStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              Container(
                width: widget.width,
                height: widget.height,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child: Opacity(
                  opacity: 0.6,
                  child: Shimmer.fromColors(
                    baseColor: widget.bgColor,
                    highlightColor: widget.highlightColor,
                    child: Container(
                      width: widget.width,
                      height: widget.height,
                      decoration: new BoxDecoration(
                        color: widget.bgColor,
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: widget.width,
                height: widget.height,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child: Center(
                  child: widget.title,
                ),
              ),
            ],
          ),
        ),
      );
}
