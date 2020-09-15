import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF181D3D),
        title: Text(
          'About',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.white),
        ),
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: ListView(children: [
          Text('The Why Behind Us?',
              style: Theme.of(context).textTheme.headline6),
          SizedBox(
            height: 10,
          ),
          Text(
            'In this fast-moving world with intensive coursework, students find very less time to share their problems. At almost every university, the students reside in hostels, and most of those hostels have offline complaint registration opening only 2-3 hours a day which some students miss. This is the reason why InstiComplaints is here.',
          ),
          SizedBox(
            height: 20,
          ),
          Text('Team', style: Theme.of(context).textTheme.headline6),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 130,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color(0xff174F74)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset(
                      'assets/person.jpg',
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 200,
                  child: ListView(
                    children: [
                      Text(
                        'We believe technology should be used in favour of mankind wherever possible. As students, we are the future builders and we are responsible for our own competency with the world.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white, fontSize: 9),
                      ),
                      Text(
                        '- James Chadwick, CTO',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white, fontSize: 9),
                        textAlign: TextAlign.right,
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10)
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Legal Licenses', style: Theme.of(context).textTheme.headline6),
          SizedBox(
            height: 10,
          ),
          Text('This project is licensed under the Apache-2.0 License.'),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 170,
                width: 170,
                child: Image.asset(
                  "assets/app_logo.png",
                ),
              ),
              Text('© InstiComplaints 2020',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ],
          ),
        ]), /*
            */
      ),
    );
  }
}
