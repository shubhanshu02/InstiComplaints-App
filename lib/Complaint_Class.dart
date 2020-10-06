import 'dart:io';
import 'package:flutter/material.dart';

class MailContent {
  String title;
  String category;
  String description;
  List<File> images=[];
  DateTime filingTime;
  String status;
  List<String> upvotes=[];
  String email;

  MailContent(this.title, this.category,this.description,this.images,this.filingTime,this.status,this.upvotes,this.email);
}

List<String> status=[
  'Pending',
  'Passed',
  'In Progress',
  'Rejected',
  'Solved'
  ];



