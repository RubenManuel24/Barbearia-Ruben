import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:flutter/material.dart';

class HoursPainel extends StatefulWidget {
  final List<dynamic>? enableHours;
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHoursPressed;
  final bool singleSelection;

  const HoursPainel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHoursPressed,
    this.enableHours,
  }) : singleSelection = false;

  const HoursPainel.singleSelection({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHoursPressed,
    this.enableHours,
  }) : singleSelection = true;

  @override
  State<HoursPainel> createState() => _HoursPainelState();
}

class _HoursPainelState extends State<HoursPainel> {
  int? lastSelected;

  @override
  Widget build(BuildContext context) {
    final HoursPainel(:singleSelection) = widget;
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
              for (int i = widget.startTime; i <= widget.endTime; i++)
                ButtonHours(
                  enableHours: widget.enableHours,
                  hours: '${i.toString().padLeft(2, '0')}:00',
                  singleSelected: singleSelection,
                  timeSelected: lastSelected,
                  onHoursPressed: (timeSelected) {
                    setState(() {
                      if (singleSelection) {
                        if (lastSelected == timeSelected) {
                          lastSelected = null;
                        } else {
                          lastSelected = timeSelected;
                        }
                      }
                    });

                    widget.onHoursPressed(timeSelected);
                  },
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
      this.enableHours,
      required this.singleSelected,
      required this.timeSelected});

  final List<dynamic>? enableHours;
  final String hours;
  final ValueChanged<int> onHoursPressed;
  final int value;
  final bool singleSelected;
  final int? timeSelected;

  @override
  State<ButtonHours> createState() => _ButtonHoursState();
}

class _ButtonHoursState extends State<ButtonHours> {
  var buttonSelected = false;

  @override
  Widget build(BuildContext context) {
    final ButtonHours(
      :hours,
      :onHoursPressed,
      :value,
      :enableHours,
      :singleSelected,
      :timeSelected
    ) = widget;

    if (singleSelected) {
      if (timeSelected != null) {
        if (timeSelected == value) {
          buttonSelected = true;
        } else {
          buttonSelected = false;
        }
      }
    }

    final textColor = buttonSelected ? Colors.white : ColorConstant.grey;
    var buttonColor = buttonSelected ? ColorConstant.brow : Colors.white;
    final borderButtonColor =
        buttonSelected ? ColorConstant.brow : ColorConstant.grey;

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
