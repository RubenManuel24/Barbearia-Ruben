import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:flutter/material.dart';

class WeekdaysPainel extends StatelessWidget {
  WeekdaysPainel({
    required this.onDayPressed,
    this.enableDay,
  });

  final List<String>? enableDay;
  ValueChanged<String> onDayPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione os dias da semana',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonDay(
                  enableDay: enableDay,
                  textDay: 'Seg',
                  onDayPressed: onDayPressed),
              ButtonDay(
                  enableDay: enableDay,
                  textDay: 'Ter',
                  onDayPressed: onDayPressed),
              ButtonDay(
                  enableDay: enableDay,
                  textDay: 'Qua',
                  onDayPressed: onDayPressed),
              ButtonDay(
                  enableDay: enableDay,
                  textDay: 'Qui',
                  onDayPressed: onDayPressed),
              ButtonDay(
                  enableDay: enableDay,
                  textDay: 'Sex',
                  onDayPressed: onDayPressed),
              ButtonDay(
                  enableDay: enableDay,
                  textDay: 'Sab',
                  onDayPressed: onDayPressed),
              ButtonDay(
                  enableDay: enableDay,
                  textDay: 'Dom',
                  onDayPressed: onDayPressed),
            ],
          ),
        )
      ],
    );
  }
}

class ButtonDay extends StatefulWidget {
  ButtonDay({
    required this.textDay,
    required this.onDayPressed,
    this.enableDay,
  });

  String textDay;
  ValueChanged<String> onDayPressed;
  final List<String>? enableDay;

  @override
  State<ButtonDay> createState() => _ButtonDayState();
}

class _ButtonDayState extends State<ButtonDay> {
  var buttonselected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = buttonselected ? Colors.white : ColorConstant.grey;
    var buttonColor = buttonselected ? ColorConstant.brow : Colors.white;
    final borderButtonColor =
        buttonselected ? ColorConstant.brow : ColorConstant.grey;

    final ButtonDay(:textDay, :onDayPressed, :enableDay) = widget;

    final disableDay = enableDay != null && !enableDay.contains(textDay);

    if (disableDay) {
      buttonColor = Colors.grey.shade400;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: disableDay
            ? null
            : () {
                onDayPressed(textDay);
                setState(() {
                  buttonselected = !buttonselected;
                });
              },
        child: Container(
          height: 56,
          width: 40,
          decoration: BoxDecoration(
              border: Border.all(color: borderButtonColor),
              color: buttonColor,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              textDay,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
