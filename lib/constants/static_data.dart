import 'package:flutter/material.dart';

class StaticData {
  static List<DropdownMenuItem<String>> get departmentNames {
    List<DropdownMenuItem<String>> dropDownItems = [
      const DropdownMenuItem(
        value: "Mechanical Engineering",
        child: Text("Mech. Engineering"),
      ),
      const DropdownMenuItem(
        value: "E&TC Engineering",
        child: Text("E&TC Engineering"),
      ),
      const DropdownMenuItem(
        value: "Civil Engineering",
        child: Text("Civil Engineering"),
      ),
      const DropdownMenuItem(
        value: "Computer Science & Engineering",
        child: Text("CSE Engineering"),
      ),
      const DropdownMenuItem(
        value: "AI&DS Engineering",
        child: Text("AI&DS Engineering"),
      ),
    ];

    return dropDownItems;
  }

  static List<DropdownMenuItem<String>> get academicYears {
    List<DropdownMenuItem<String>> dropDownItems = [
      const DropdownMenuItem(
        value: "FE",
        child: Text("FE"),
      ),
      const DropdownMenuItem(
        value: "SE",
        child: Text("SE"),
      ),
      const DropdownMenuItem(
        value: "TE",
        child: Text("TE"),
      ),
      const DropdownMenuItem(
        value: "BE",
        child: Text("BE"),
      ),
    ];

    return dropDownItems;
  }

  static List<DropdownMenuItem<String>> get sections {
    List<DropdownMenuItem<String>> dropDownItems = [
      const DropdownMenuItem(
        value: "A",
        child: Text("A"),
      ),
      const DropdownMenuItem(
        value: "B",
        child: Text("B"),
      ),
      const DropdownMenuItem(
        value: "C",
        child: Text("C"),
      ),
      const DropdownMenuItem(
        value: "D",
        child: Text("D"),
      ),
      const DropdownMenuItem(
        value: "E",
        child: Text("E"),
      ),
    ];

    return dropDownItems;
  }

  static List<DropdownMenuItem<String>> get documentType {
    List<DropdownMenuItem<String>> dropDownItems = [
      const DropdownMenuItem(
        value: "10th Marksheet",
        child: Text("10th Marksheet"),
      ),
      const DropdownMenuItem(
        value: "10th LC",
        child: Text("10th LC"),
      ),
      const DropdownMenuItem(
        value: "12th Marksheet",
        child: Text("12th Marksheet"),
      ),
      const DropdownMenuItem(
        value: "12th LC",
        child: Text("12th LC"),
      ),
      const DropdownMenuItem(
        value: "Diploma Marksheet",
        child: Text("Diploma Marksheet"),
      ),
      const DropdownMenuItem(
        value: "Diploma LC",
        child: Text("Diploma LC"),
      ),
      const DropdownMenuItem(
        value: "Allotment Letter",
        child: Text("Allotment Letter"),
      ),
      const DropdownMenuItem(
        value: "Income Certificate",
        child: Text("Income Certificate"),
      ),
      const DropdownMenuItem(
        value: "Caste Certificate",
        child: Text("Caste Certificate"),
      ),
      const DropdownMenuItem(
        value: "Caste Validity",
        child: Text("Caste Validity"),
      ),
      const DropdownMenuItem(
        value: "Non-Creamy Layer",
        child: Text("Non-Creamy Layer"),
      ),
      const DropdownMenuItem(
        value: "EWS Certificate",
        child: Text("EWS Certificate"),
      ),
      const DropdownMenuItem(
        value: "Aadhar Card",
        child: Text("Aadhar Card"),
      ),
      const DropdownMenuItem(
        value: "Pan Card",
        child: Text("Pan Card"),
      ),
      const DropdownMenuItem(
        value: "Bank Passbook",
        child: Text("Bank Passbook"),
      ),
      const DropdownMenuItem(
        value: "Ration Card",
        child: Text("Ration Card"),
      ),
    ];

    return dropDownItems;
  }

  static List<DropdownMenuItem<String>> get socialLinks {
    List<DropdownMenuItem<String>> dropDownItems = [
      const DropdownMenuItem(
        value: "LinkedIn",
        child: Text("LinkedIn"),
      ),
      const DropdownMenuItem(
        value: "Instagram",
        child: Text("Instagram"),
      ),
      const DropdownMenuItem(
        value: "Facebook",
        child: Text("Facebook"),
      ),
      const DropdownMenuItem(
        value: "Portfolio",
        child: Text("Portfolio"),
      ),
      const DropdownMenuItem(
        value: "Hackerearth",
        child: Text("Hackerearth"),
      ),
      const DropdownMenuItem(
        value: "Hackerrank",
        child: Text("Hackerrank"),
      ),
      const DropdownMenuItem(
        value: "Leet Code",
        child: Text("Leet Code"),
      ),
    ];

    return dropDownItems;
  }
}
