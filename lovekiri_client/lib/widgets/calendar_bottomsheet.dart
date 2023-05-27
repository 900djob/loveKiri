import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarBottomSheet extends StatefulWidget {
  const CalendarBottomSheet({
    super.key,
  });

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    final now = DateTime.now();
    _focusedDay = now;
    _selectedDay = now;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xfff9f9f9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.0),
          topRight: Radius.circular(14.0),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 4, left: 16.0, right: 16.0),
          child: Wrap(
            children: [
              Column(
                children: [
                  _calendarHeader(),
                  _getCalendar(),
                  const SizedBox(height: 16),
                  _completeBtn(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _calendarHeader() {
    return Row(
      children: [
        Text(
          tr('calendar.등록'),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.close,
          ),
        ),
      ],
    );
  }

  Widget _getCalendar() {
    return TableCalendar(
      selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
      calendarStyle: const CalendarStyle(
        rangeHighlightColor: Colors.black,
        selectedDecoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black,),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black,)
      ),
      locale: EasyLocalization.of(context)!.currentLocale!.languageCode,
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2000,1,1),
      lastDay: DateTime.utc(2099, 12, 31),
      onDaySelected: (selectedDay, focusedDay) {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
        setState(() {});
      },
    );
  }

  Widget _completeBtn() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        onPressed: () => Get.back(result: _selectedDay),
        child: Text(
          tr('calendar.선택완료'),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
