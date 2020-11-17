import 'package:flutter/material.dart';

List<List<String>> aboutPage = [
  [
    'Siddhant Jain',
    "Words don't matter unless your work says what you do",
    'assets/jainsid2305.png'
  ],
  [
    "Shubhanshu Saxena",
    "Communicating your problems is the key to improvement",
    'assets/shubhanshu02.jfif'
  ],
  [
    'Kenny Patel',
    "We have been working on this application with all our determination",
    'assets/kenny-08.jfif',
  ],
  [
    'Diya Agrawal',
    "We produce a many bugs daily in our code, so does our infrastructure. The need is to improve both simultaneously.",
    'assets/diya31ag.png'
  ]
];

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
          Center(
              child: SizedBox(
                  height: 130.0,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: PageController(viewportFraction: 1),
                    //pageSnapping: ,
                    children: aboutPage
                        .map<Widget>((lst) => Container(
                              height: 130,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: Color(0xff174F74)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: Image.asset(
                                        lst[2],
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width - 200,
                                    child: ListView(
                                      children: [
                                        Text(
                                          lst[1],
                                          //'We believe technology should be used in favour of mankind wherever possible. As students, we are the future builders and we are responsible for our own competency with the world.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 9),
                                        ),
                                        Text(
                                          '- ' + lst[0],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 9),
                                          textAlign: TextAlign.right,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10)
                                ],
                              ),
                            ))
                        .toList(),
                  ))),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              'Slide to know about other developers ->',
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
