# sparkler_button

A widget button that can sparkle.

## Getting Started

 
 
 

## Installation

Add dependency to pubspec.yaml

```bash
dependencies:
...
sparkler_button: ^lastest_version
```

Run in your terminal

```bash
flutter packages get
```

## How to use

```dart
import 'package:sparkler_button/sparkler_button.dart';
```

```dart
SparklerButton(
buttonTitle: Text(
 'Button that can Sparkle',
 style: TextStyle(
   color: Colors.white,
       fontWeight: FontWeight.w300,
       fontSize: 17.0,
     ),
 ),
 buttonColor: Color(0xff3dce89),
 onclickButtonFunction: () {
   print('hello');
 }
);

```

## Attribute

| Parameter  | Default   | Description |
| :------------ |:---------------:| :-----|
| buttonTitle | null  | Change this value if you what to put pagination in other placeThe text on the button, cannot be omitted. |
| buttonColor | null | Button background color, cannot be omitted. |
| buttonHeight | 50.0 | Height of button. |
| buttonWidth | 200.0 | Width of button. |
| durationTime | 3 | Button blink interval.(seconds) |
| twinkleTime | 300 | Blink time.(milliseconds) |
| highlightColor | Colors.white | Flash effect background color. |
| onclickButtonFunction | null | Events executed by clicking the button, cannot be omitted. |