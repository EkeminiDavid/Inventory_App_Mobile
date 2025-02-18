import 'package:flutter/material.dart';

class SeasonDropdown extends StatelessWidget {
  final String selectedEvent;
  final Function(String) onEventSelected;

  SeasonDropdown({super.key,
    required this.selectedEvent,
    required this.onEventSelected,
  });

  // List of events
  final List<String> events = [
    'Christmas',
    'New Year',
    'Valentine',
    'Easter',
    'Back to School',
    'Ramadan',
    'Normal',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      height: 56,
      width: MediaQuery.of(context).size.width, // 80% of screen width
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedEvent,
        onChanged: (String? newValue) {
          if (newValue != null) {
            onEventSelected(newValue); // Callback to parent
          }
        },
        items: events.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}