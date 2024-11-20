import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:flutter/material.dart';

class HoursPainel extends StatelessWidget {
  const HoursPainel(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.onHoursPressed,
      this.enableHours});

  final List<int>? enableHours;
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHoursPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecione os horários de atendimento',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              for (int i = startTime; i <= endTime; i++)
                ButtonHours(
                  enableHours: enableHours,
                  hours: '${i.toString().padLeft(2, '0')}:00',
                  onHoursPressed: onHoursPressed,
                  value: i,
                ),
            ],
          )
        ],
      ),
    );
  }
}

class ButtonHours extends StatefulWidget {
  const ButtonHours(
      {super.key,
      required this.hours,
      required this.onHoursPressed,
      required this.value,
      this.enableHours});

  final List<int>? enableHours;
  final String hours;
  final ValueChanged<int> onHoursPressed;
  final int value;

  @override
  State<ButtonHours> createState() => _ButtonHoursState();
}

class _ButtonHoursState extends State<ButtonHours> {
  var buttonSelected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = buttonSelected ? Colors.white : ColorConstant.grey;
    var buttonColor = buttonSelected ? ColorConstant.brow : Colors.white;
    final borderButtonColor =
        buttonSelected ? ColorConstant.brow : ColorConstant.grey;

    final ButtonHours(:hours, :onHoursPressed, :value, :enableHours) = widget;

    final disableHours = enableHours != null && !enableHours.contains(value);

    if (disableHours) {
      buttonColor = Colors.grey.shade400;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disableHours
          ? null
          : () {
              setState(
                () {
                  buttonSelected = !buttonSelected;
                  onHoursPressed(value);
                },
              );
            },
      child: Container(
        height: 36,
        width: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor,
          border: Border.all(color: borderButtonColor),
        ),
        child: Center(
          child: Text(
            hours,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
