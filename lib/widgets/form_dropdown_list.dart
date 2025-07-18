import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/data/universityData.dart';

class FormDropDown extends StatefulWidget {
  FormDropDown({
    super.key,
    required this.labelText,
    required this.mySubjectOfInterest,
    required this.form,
    required this.setInterest,
  });
  String? labelText;
  String? enteredUsername;
  String? mySubjectOfInterest;
  void Function(String? x) setInterest;
  final form;

  @override
  State<FormDropDown> createState() => _FormDropDownState();
}

class _FormDropDownState extends State<FormDropDown> {
  bool isSelect = false;
  void showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void onSubjectOfInterestTap() {
    DropDownState<String>(
      dropDown: DropDown<String>(
        isDismissible: true,
        bottomSheetTitle: const Text(
          'Select',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        submitButtonText: 'Save',
        clearButtonText: 'Clear',
        data: _listOfSubjects,
        onSelected: (selectedItems) {
          List<String> list = [];
          list.add(selectedItems[0].data);
          setState(() {
            if (list[0].isNotEmpty) {
              widget.labelText = list[0];
              isSelect = true;
              widget.mySubjectOfInterest = list[0];
              widget.setInterest(widget.mySubjectOfInterest);
            }
          });
        },

        enableMultipleSelection: false,
        maxSelectedItems: 1,
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 60,
      width: size.width * 0.68,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.2),
        borderRadius: BorderRadius.circular(8.0), // Uniform radius
      ),
      child: Form(
        key: widget.form,
        child: TextFormField(
          style: GoogleFonts.raleway(
            textStyle: TextStyle(color: Colors.white, fontSize: 16),
          ),
          decoration: InputDecoration(
            hintText: widget.labelText,
            hintStyle: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 16,
              ),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10.0),
            suffixIcon: Icon(Icons.arrow_downward),
          ),
          onTap: onSubjectOfInterestTap,

          keyboardType: TextInputType.name,
          autocorrect: false,
          textCapitalization: TextCapitalization.none,
          validator: (val) {
            if (!isSelect) {
              return 'Please select your subject of interest';
            }

            return null;
          },
          onSaved: (value) {},
        ),
      ),
    );
  }
}

final List<SelectedListItem<String>> _listOfSubjects =
    uni.map((u) => SelectedListItem<String>(data: u.name)).toList();
