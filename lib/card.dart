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
  Widget categoryCard(category, context) {
    Future<void> editList(BuildContext context) {
      TextEditingController customController = TextEditingController();
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Row(
                  children: [
                    Text('Edit '),
                    Text(category.name),
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
                        category.text = customController.text.toString();
                      });
                      Navigator.of(context).pop();
                    },
                    elevation: 5.0,
                    child: Text('Save'),
                  )
                ]);
          });
    }

    return Card(
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
                Text(category.name,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Roboto',
                    )),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Icon(category.iconName),
                    SizedBox(width: 5.0),
                    Text(category.text,
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
                  editList(context);
                },
                icon: Icon(Icons.edit, color: Colors.red)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: categories.map((category) {
        return categoryCard(category, context);
      }).toList(),
    );
  }
}
