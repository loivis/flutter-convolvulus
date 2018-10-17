import 'package:convvls/data/book.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  final Book book;

  BookPage(this.book);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.book.title),
    );
  }
}
