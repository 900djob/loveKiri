import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectBottomSheet extends StatefulWidget {
  const SelectBottomSheet({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final List<dynamic> data;

  @override
  State<SelectBottomSheet> createState() => _SelectBottomSheetState();
}

class _SelectBottomSheetState extends State<SelectBottomSheet> {
  late String _selectedData = widget.data[0];

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
                  _header(title: widget.title),
                  _picker(data: widget.data),
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

  Widget _header({required String title}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
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

  Widget _picker({required data}) {
    return SizedBox(
      height: 220,
      child: CupertinoPicker(
        itemExtent: 48,
        onSelectedItemChanged: (int index) {
          setState(() {
            _selectedData = data[index];
          });
        },
        children: List<Widget>.generate(data.length, (int index) {
          return Center(
            child: Text(
              data[index],
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
          );
        }),
      ),
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
        onPressed: () => Get.back(result: _selectedData),
        child: Text(
          tr('calendar.선택완료'),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
