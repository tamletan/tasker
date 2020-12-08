import 'package:flutter/material.dart';

enum ToggleType {
  android,
  custom,
  ios,
  square,
}

class Toggle extends StatefulWidget {
  const Toggle(
      {Key key,
      @required this.onChanged,
      this.value,
      this.enabledText,
      this.disabledText,
      this.enabledTextStyle,
      this.enabledThumbColor,
      this.enabledTrackColor,
      this.disabledTextStyle,
      this.disabledTrackColor,
      this.disabledThumbColor,
      this.type,
      this.boxShape,
      this.borderRadius,
      this.duration = const Duration(milliseconds: 400)})
      : super(key: key);

  final String enabledText;
  final String disabledText;
  final TextStyle enabledTextStyle;
  final TextStyle disabledTextStyle;
  final Color enabledThumbColor;
  final Color disabledThumbColor;
  final Color enabledTrackColor;
  final Color disabledTrackColor;
  final BoxShape boxShape;
  final BorderRadius borderRadius;
  final Duration duration;
  final ToggleType type;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  _ToggleState createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  AnimationController controller;
  Animation<Offset> offset;
  bool isOn;

  @override
  void initState() {
    setState(() {
      isOn = widget.value ?? false;
    });
    controller = AnimationController(duration: widget.duration, vsync: this);
    offset = (isOn
            ? Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            : Tween<Offset>(begin: Offset.zero, end: const Offset(1, 0)))
        .animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    if (animationController != null) {
      animationController.dispose();
    }
    if (controller != null) {
      controller.dispose();
    }
    super.dispose();
  }

  void onStatusChange() {
    if (widget.onChanged != null) {
      setState(() {
        isOn = !isOn;
      });
      switch (controller.status) {
        case AnimationStatus.dismissed:
          controller.forward();
          break;
        case AnimationStatus.completed:
          controller.reverse();
          break;
        default:
      }
      widget.onChanged(isOn);
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Container(
            height: widget.type == ToggleType.android ? 25 : 30,
            width: widget.type == ToggleType.android ? 40 : 50,
          ),
          Positioned(
            top: 5,
            child: InkWell(
              onTap: onStatusChange,
              child: Container(
                width: widget.type == ToggleType.ios ? 45 : 36,
                height: widget.type == ToggleType.ios ? 25 : 15,
                decoration: BoxDecoration(
                    color: isOn
                        ? widget.enabledTrackColor ?? Colors.lightGreen
                        : widget.disabledTrackColor ?? Colors.grey,
                    borderRadius: widget.type == ToggleType.square
                        ? const BorderRadius.all(Radius.circular(0))
                        : widget.borderRadius ??
                            const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: widget.type == ToggleType.ios
                      ? const EdgeInsets.only(left: 3.5, right: 3.5, top: 5.4)
                      : const EdgeInsets.only(left: 3, right: 3, top: 3.4),
                  child: isOn
                      ? Text(
                          widget.enabledText ??
                              (widget.type == ToggleType.custom ? 'ON' : ''),
                          style: widget.enabledTextStyle ??
                              (widget.type == ToggleType.ios
                                  ? const TextStyle(
                                      color: Colors.white, fontSize: 12)
                                  : const TextStyle(
                                      color: Colors.white, fontSize: 8)))
                      : Text(
                          widget.disabledText ??
                              (widget.type == ToggleType.custom ? 'OFF' : ''),
                          textAlign: TextAlign.end,
                          style: widget.disabledTextStyle ??
                              (widget.type == ToggleType.ios
                                  ? const TextStyle(
                                      color: Colors.white, fontSize: 12)
                                  : const TextStyle(
                                      color: Colors.white, fontSize: 8)),
                        ),
                ),
              ),
            ),
          ),
          Positioned(
            top: widget.type == ToggleType.ios ? 7.5 : 3,
            left: widget.type == ToggleType.ios ? 2 : 0,
            child: InkWell(
              onTap: onStatusChange,
              child: SlideTransition(
                position: offset,
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: widget.type == ToggleType.square
                        ? BoxShape.rectangle
                        : widget.boxShape ?? BoxShape.circle,
                    color: isOn
                        ? widget.enabledThumbColor ?? Colors.white
                        : widget.disabledThumbColor ?? Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        blurRadius: 6,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
