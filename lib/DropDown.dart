import 'package:flutter/material.dart';

class CategoryItem{
  int value;
  String categoryName;
  CategoryItem(this.value, this.categoryName);
}

CategoryItem selectedItem;

class DropDownMenu extends StatefulWidget {
  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {

  List<CategoryItem> _dropdownItems = [
    CategoryItem(1, "CAMPUS RELATED"),
    CategoryItem(2, "GYMKHANA"),
    CategoryItem(3, "PROCTOR OFFICE"),
    CategoryItem(4, "ADMINISTRATION"),
    CategoryItem(5, "GENERAL"),
    CategoryItem(6, "ARYABHATT–I"),
    CategoryItem(7, "ARYABHATT–II"),
    CategoryItem(8, "C.V. Raman"),
    CategoryItem(9, "DHANRAJGIRI"),
    CategoryItem(10, "GANDHI SMRITI\nCHHATRAVAS(OLD)"),
    CategoryItem(11, "GANDHI SMRITI\nCHHATRAVAS(EXTENSION)"),
    CategoryItem(12, "IIT BOYS (SALUJA)"),
    CategoryItem(13, "IIT (BHU) GIRLS HOSTEL – I"),
    CategoryItem(14, "IIT (BHU) GIRLS HOSTEL – II"),
    CategoryItem(15, "LIMBDI"),
    CategoryItem(16, "MORVI"),
    CategoryItem(17, "RAJPUTANA"),
    CategoryItem(18, "S.C. DEY GIRLS"),
    CategoryItem(19, "S.N. BOSE"),
    CategoryItem(20, "S. RAMANUJAN"),
    CategoryItem(21, "VIVEKANAND"),
    CategoryItem(22, "VISHWAKARMA"),
    CategoryItem(23, "VISHWESHVARAIYA"),

  ];

  List<DropdownMenuItem<CategoryItem>> _dropdownMenuItems;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    //selectedItem = _dropdownMenuItems[0].value;

  }

  List<DropdownMenuItem<CategoryItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<CategoryItem>> items = List();
    for (CategoryItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.categoryName),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 0.65*MediaQuery.of(context).size.width,
      height: 75.0,
      padding: EdgeInsets.all(10.0),
        child: Center(
          child: DropdownButton<CategoryItem>(
              hint: Container(
                padding: EdgeInsets.symmetric(horizontal: 11),
                child: Text(
                  'Category',
                  style: TextStyle(
                    color: Color.fromRGBO(24, 51,98, 1),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              isExpanded: true,
              elevation: 10,
              value: selectedItem,
              items: _dropdownMenuItems,
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                });
              }),
        ),
    );
  }
}