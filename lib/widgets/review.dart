import 'package:flutter/material.dart';
import '../models/reviewmodel.dart';
import '../models/reviews.dart';
import '../widgets/review.dart';
import '../widgets/info_card.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel reviewItem;
  
  const ReviewWidget({Key key, @required this.reviewItem}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(reviewItem.comment),
              ),
              Row(
                children: List(reviewItem.stars).map((listItem) {
                  return Icon(Icons.star);
                }).toList(),
              )
            ],
          ),
        ),
        Divider(color: Colors.grey,)
      ],
    );
  }
}