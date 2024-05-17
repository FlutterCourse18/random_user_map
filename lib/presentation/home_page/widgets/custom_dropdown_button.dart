import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({
    super.key,
    required this.selectedValue,
    required this.genderItems,
    this.onSelectedValueChanged,
    required this.hintalue,
  });

  final String selectedValue;
  final String? hintalue;
  final List<String> genderItems;
  final ValueChanged<String>? onSelectedValueChanged;
  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Text(widget.hintalue ?? ''),
          const SizedBox(
            width: 10,
          ),
          DropdownButton(
            value: selectedValue,
            menuMaxHeight: 300,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 42,
            underline: const SizedBox(),
            items: widget.genderItems
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.toString()),
                  ),
                )
                .toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
                widget.onSelectedValueChanged!(newValue);
              });
            },
          ),
        ],
      ),
    );
  }
}
