import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/data/database.dart';
import 'package:studee_app/main.dart';

class FormUniversities extends StatefulWidget {
  FormUniversities({
    super.key,
    required this.labelText,
    required this.setUnivs,
    required this.form,
  });
  String? labelText;
  String? enteredUsername;
  void Function(List<String>? x) setUnivs;
  final form;

  @override
  State<FormUniversities> createState() => _FormUniversitiesState();
}

class _FormUniversitiesState extends State<FormUniversities> {
  bool isSelect = false;
  List<String>? listOfUnivs = [];
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
        data: names,
        onSelected: (selectedItems) {
          List<String> list = [];

          for (var item in selectedItems) {
            list.add(item.data);
          }
          if (list.isNotEmpty && list.length == 3) {
            setState(() {
              widget.labelText = 'Selected';
            });
            widget.setUnivs(list);
            isSelect = true;
          }
        },

        enableMultipleSelection: true,
        maxSelectedItems: 3,
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
        borderRadius: BorderRadius.circular(8.0), 
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
              return 'Please choose 3 the universities';
            }

            return null;
          },
          onSaved: (value) {},
        ),
      ),
    );
  }
}
