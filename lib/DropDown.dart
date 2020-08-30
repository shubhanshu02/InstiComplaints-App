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
    CategoryItem(1, "Campus Related"),
    CategoryItem(2, "Gymkhana"),
    CategoryItem(3, "ARYABHATT–I"),
    CategoryItem(4, "ARYABHATT–II"),
    CategoryItem(5, "C.V. Raman"),
    CategoryItem(6, "DHANRAJGIRI"),
    CategoryItem(7, "GANDHI SMRITI\nCHHATRAVAS(OLD)"),
    CategoryItem(8, "GANDHI SMRITI\nCHHATRAVAS(EXTENSION)"),
    CategoryItem(9, "IIT BOYS (SALUJA)"),
    CategoryItem(10, "IIT (BHU) GIRLS HOSTEL – I"),
    CategoryItem(11, "IIT (BHU) GIRLS HOSTEL – II"),
    CategoryItem(12, "LIMBDI"),
    CategoryItem(13, "MORVI"),
    CategoryItem(14, "RAJPUTANA"),
    CategoryItem(15, "S.C. DEY GIRLS"),
    CategoryItem(16, "S.N. BOSE"),
    CategoryItem(17, "S. RAMANUJAN"),
    CategoryItem(18, "VIVEKANAND"),
    CategoryItem(19, "VISHWAKARMA"),
    CategoryItem(20, "VISHWESHVARAIYA"),

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
                  'Categories',
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