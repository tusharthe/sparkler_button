library sparkler_button;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SparklerButton extends StatefulWidget {
  final Text buttonTitle;
  final Color buttonColor;
  final double buttonHeight;
  final double buttonWidth;
  final int durationTime;
  final int time;
  final Color highlightColor;
  final GestureTapCallback onclickButtonFunction;

  const SparklerButton({
    Key? key,
    required this.buttonTitle,
    required this.buttonColor,
    required this.onclickButtonFunction,
    this.highlightColor = Colors.white,
    this.buttonHeight = 50.0,
    this.buttonWidth = 280.0,
    this.durationTime = 3,
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
          Duration(seconds: widget.durationTime),
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
      onTap: widget.onclickButtonFunction,
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
                width: widget.buttonWidth,
                height: widget.buttonHeight,
                child: ElevatedButton(
                  onPressed: () async {
                    return null;
                  },
                  child: null,
                  style: ElevatedButton.styleFrom(
                      primary: widget.buttonColor,
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
                width: widget.buttonWidth,
                height: widget.buttonHeight,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child: Opacity(
                  opacity: 0.6,
                  child: Shimmer.fromColors(
                    baseColor: widget.buttonColor,
                    highlightColor: widget.highlightColor,
                    child: Container(
                      width: widget.buttonWidth,
                      height: widget.buttonHeight,
                      decoration: new BoxDecoration(
                        color: widget.buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: widget.buttonWidth,
                height: widget.buttonHeight,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child: Center(
                  child: widget.buttonTitle,
                ),
              ),
            ],
          ),
        ),
      );
}
