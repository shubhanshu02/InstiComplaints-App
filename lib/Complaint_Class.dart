class MailContent {
  String title;
  String category;
  String description;
  List<String> images = [];
  DateTime filingTime;
  String status;
  List<String> upvotes = [];
  String uid;
  String email;

  MailContent(
      {this.title,
      this.category,
      this.description,
      this.images,
      this.filingTime,
      this.status,
      this.upvotes,
      this.uid,
      this.email});
}

List<String> status = [
  'Pending',
  'Passed',
  'In Progress',
  'Rejected',
  'Solved'
];

/*List<MailContent> complaints = [
  MailContent(
      title: 'industry standard dummy',
      category: 'GYMKHANA',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'pending',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'cycle missing',
      category: 'PROCTOR OFFICE',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'approved',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'unknown printer took a galley',
      category: 'ADMINISTRATION',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'accepted',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'Fan not working',
      category: 'GENERAL',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'completed',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'unknown printer took a galley',
      category: 'ARYABHATT–I',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'pending',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'Fan not working',
      category: 'C.V. Raman',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'completed',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'unknown printer took a galley',
      category: 'DHANRAJGIRI',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'approved',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'cycle missing',
      category: 'GANDHI SMRITI\nCHHATRAVAS(OLD)',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'pending',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'cycle missing',
      category: 'IIT BOYS (SALUJA)',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'accepted',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'industry standard dummy',
      category: 'LIMBDI',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'completed',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'Fan not working',
      category: 'RAJPUTANA',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'pending',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'cycle missing',
      category: 'S.C. DEY GIRLS',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'pending',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'industry standard dummy',
      category: 'S.N. BOSE',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'accepted',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'Fan not working',
      category: 'S. RAMANUJAN',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'accepted',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
  MailContent(
      title: 'industry standard dummy',
      category: 'VISHWAKARMA',
      description:
          'Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged',
      images: [],
      filingTime: DateTime.now(),
      status: 'pending',
      upvotes: [],
      email: 'abhishek.civil.19@itbhu.ac.in'),
];*/
