import 'package:flutter/material.dart';

  buildListItem(String commentText) {
  return Card(
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: null,
                  ),
                  IconButton(
                    icon: Icon(Icons.bookmark),
                    onPressed: null,
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: null,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2.0, left: 50.0),
                child: Text(
                  'اسم المستخدم',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(80.0),
                    border: Border.all(width: 2.0)),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey,
          width: double.infinity,
          height: 200.0,
          child: Image.asset('assets/images/ahmed.jpg'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Text(
                  commentText,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.visible,
                  maxLines: 4,
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}


// Image picker..
