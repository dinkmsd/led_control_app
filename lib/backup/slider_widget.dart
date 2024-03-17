import 'package:flutter/material.dart';
import 'package:led_control_app/utlis.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

// ignore: must_be_immutable
class SliderWidget extends StatefulWidget {
  Function(double value) onChange;
  Function(double value) onChangeEnd;

  final double initialValue;
  SliderWidget(
      {super.key,
      required this.onChange,
      required this.onChangeEnd,
      required this.initialValue});

  @override
  // ignore: library_private_types_in_public_api
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  // double progressVal = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: kDiameter - 30,
          height: kDiameter - 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SleekCircularSlider(
              min: 0,
              max: 100,
              initialValue: widget.initialValue,
              appearance: CircularSliderAppearance(
                // startAngle: 180,
                angleRange: 240,
                size: 300,
                customWidths: CustomSliderWidths(
                  trackWidth: 20,
                  shadowWidth: 5,
                  progressBarWidth: 20,
                  handlerSize: 9,
                ),
                customColors: CustomSliderColors(
                  progressBarColor: const Color(0xFF818FB4),
                  trackColor: const Color(0xFFB6BBC4),
                  dotColor: const Color(0xFF2D3250),
                ),
              ),
              onChange: (value) {
                widget.onChange(value);
              },
              onChangeEnd: (value) {
                widget.onChangeEnd(value);
              },
              innerWidget: (percentage) {
                return Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.brightness_low_outlined,
                            size: 32,
                          ),
                        ),
                        TextSpan(
                            text: ' ${percentage.toInt()} %',
                            style: const TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
