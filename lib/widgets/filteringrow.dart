import 'package:flutter/material.dart';
import 'package:studee_app/data/universityData.dart';
import 'package:studee_app/model/filterchipitem.dart';
import 'package:studee_app/widgets/filtering/filterchipdropdown.dart';

enum Filter { location, degree, programme }

class FilterRow extends StatefulWidget {
  FilterRow({
    super.key,
    required this.filter,
    required this.onSelectDegree,
    required this.onSelectLocation,
    required this.onSelectProgramme,
  });
  final Map<Filter, String> filter;
  void Function(String? x) onSelectDegree;
  void Function(String? x) onSelectLocation;
  void Function(String? x) onSelectProgramme;

  @override
  State<FilterRow> createState() => _FilterRowState();
}

class _FilterRowState extends State<FilterRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 1.0,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FilterChipDropdown(
          initialLabel: 'Location',
          leading: Icon(Icons.holiday_village),
          onSelectionChanged: (selected) {
            widget.onSelectLocation(selected);
          },
          items:
              uni
                  .map((u) => u.country)
                  .toSet()
                  .map(
                    (country) => FilterChipItem(label: country, value: country),
                  )
                  .toList(),

          //FilterChipItem(label: "A very long option", value: "long_option")
        ),
        FilterChipDropdown(
          initialLabel: 'Degree',
          leading: Icon(Icons.holiday_village),
          onSelectionChanged: (selected) {
            widget.onSelectDegree(selected);
          },
          items:
              uni
                  .map((u) => u.degree)
                  .toSet()
                  .map(
                    (country) => FilterChipItem(label: country, value: country),
                  )
                  .toList(),

          //FilterChipItem(label: "A very long option", value: "long_option")
        ),
        FilterChipDropdown(
          initialLabel: 'Programme',
          leading: Icon(Icons.holiday_village),
          onSelectionChanged: (selected) {
            widget.onSelectProgramme(selected);
          },
          items:
              uni
                  .map((u) => u.programme)
                  .toSet()
                  .map(
                    (country) => FilterChipItem(label: country, value: country),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
