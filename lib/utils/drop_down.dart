import 'package:flutter/material.dart';

class StarRatingDropdown extends StatefulWidget {
  final double selectedRating;
  final Function(double) onRatingSelected;

  StarRatingDropdown({
    required this.selectedRating,
    required this.onRatingSelected,
  });

  @override
  _StarRatingDropdownState createState() => _StarRatingDropdownState();
}

class _StarRatingDropdownState extends State<StarRatingDropdown> {
  // List of star rating options
  final List<double> starRatings = [
    0.0,
    0.5,
    1.0,
    1.5,
    2.0,
    2.5,
    3.0,
    3.5,
    4.0,
    4.5,
    5.0
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
      width: MediaQuery.of(context).size.width,
      child: DropdownButton<double>(
        isExpanded: true,
        value: widget.selectedRating,
        onChanged: (double? newValue) {
          if (newValue != null) {
            widget.onRatingSelected(newValue); // Callback to parent
          }
        },
        items: starRatings.map<DropdownMenuItem<double>>((double value) {
          return DropdownMenuItem<double>(
            value: value,
            child: Text(value.toString() != '0.0' ? '$value Stars' : 'Select rating'),
          );
        }).toList(),
      ),
    );
  }
}