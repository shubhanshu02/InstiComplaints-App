import 'package:flutter/material.dart';

class Category {
  String name;
  IconData iconName;
  String text;

  Category({this.name, this.iconName, this.text});
}

List<Category> categories = [
  Category(name: 'Room no.', iconName: Icons.person_pin, text: 'C-304'),
  Category(
      name: 'Hostel Name',
      iconName: Icons.location_on,
      text: 'Ramanujan Hostel'),
];

class CardCategory extends StatefulWidget {
  @override
  _CardCategoryState createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {
  Future<void> editList1(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Row(
                children: [
                  Text('Edit '),
                  Text(categories[0].name),
                ],
              ),
              content: TextField(
                controller: customController,
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      categories[0].text = customController.text.toString();
                    });
                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Save'),
                )
              ]);
        });
  }

  Future<void> editList2(BuildContext context) {
    String hostelname;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Row(
                children: [
                  Text('Edit '),
                  Text(categories[1].name),
                ],
              ),
              content: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.black.withOpacity(0.3)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Container(
                      padding: EdgeInsets.symmetric(horizontal: 11),
                      child: Text(
                        'Hostel',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 16),
                      ),
                    ),
                    value: hostelname,
                    onChanged: (String newValue) {
                      setState(() {
                        hostelname = newValue;
                      });
                    },
                    isExpanded: true,
                    style: Theme.of(context).textTheme.bodyText1,
                    items: <String>[
                      'C.V. Raman',
                      'Morvi',
                      'Dhanrajgiri',
                      'Rajputana',
                      'Limbdi',
                      'Vivekanand',
                      'Vishwakarma',
                      'Vishweshvaraiya',
                      'Aryabhatt-I',
                      'Aryabhatt-II',
                      'S.N. Bose',
                      'Ramanujan',
                      'Gandhi Smriti Chhatravas (OLD)',
                      'Gandhi Smriti Chhatravas (Extension)',
                      'IIT (BHU) Girls’ Hostel',
                      'S.C. Dey Girls',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 11),
                          child: Text(
                            value,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 16),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              //TODO: the text showing at first in dropdownmenu doesn't change after choosing hostel name
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      categories[1].text = hostelname;
                    });
                    Navigator.of(context).pop();
                  },
                  elevation: 5.0,
                  child: Text('Save'),
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(categories[0].name,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontFamily: 'Roboto',
                        )),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Icon(categories[0].iconName),
                        SizedBox(width: 5.0),
                        Text(categories[0].text,
                            style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            )),
                      ],
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {
                      editList1(context);
                    },
                    icon: Icon(Icons.edit, color: Colors.red)),
              ],
            ),
          ),
        ),
        Card(
          elevation: 5.0,
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(categories[1].name,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontFamily: 'Roboto',
                        )),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Icon(categories[1].iconName),
                        SizedBox(width: 5.0),
                        Text(categories[1].text,
                            style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            )),
                      ],
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {
                      editList2(context);
                    },
                    icon: Icon(Icons.edit, color: Colors.red)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
