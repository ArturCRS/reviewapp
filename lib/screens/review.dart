import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:reviewapp/models/reviewmodel.dart';
import 'package:reviewapp/models/reviews.dart';
import 'package:reviewapp/widgets/review.dart';
import '../widgets/info_card.dart';

class Review extends StatefulWidget {
  @override
  ReviewState createState() {
    return new ReviewState();
  }
}

class ReviewState extends State<Review> {
  final Reviews _reviewsStore = Reviews();
  final List<int> _starts = [1,2,3,4,5];
  final TextEditingController _commentController = TextEditingController();
  int _selectStars;

  @override
  void initState() {
    _selectStars = null;
    _reviewsStore.initReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Review App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: screenWidth * 0.6,
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      hintText: "Write a Review",
                      labelText: "Write a review"
                    ),
                  ),
                ),
                Container(
                  child: DropdownButton(
                    hint: Text("Stars"),
                    elevation: 0,
                    value: _selectStars,
                    items: _starts.map((star) {
                      return DropdownMenuItem<int>(
                        child: Text(star.toString()),
                        value: star,
                      );
                    }).toList(),
                    onChanged: (item) {
                      setState(() {
                        _selectStars = item;
                      });
                    },
                  ),
                ),
                Container(
                  child: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: Icon(Icons.done),
                        onPressed: () {
                          if (_selectStars == null) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("You can't add a review without star"),
                              duration: Duration(milliseconds: 500),
                            ));
                          } else if (_commentController.text.isEmpty) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Review comment cannot be empty"),
                              duration: Duration(milliseconds: 500),
                            ));
                          } else {
                            _reviewsStore.addReview(ReviewModel(
                              comment: _commentController.text,
                              stars: _selectStars
                            ));
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 12.0,),
            Observer(
              builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InfoCard(
                        infoValue: _reviewsStore.numbreOfReviews.toString(),
                        infoLabel: 'reviews',
                        cardColor: Colors.green,
                        iconData: Icons.comment
                    ),
                    InfoCard(
                        infoValue: _reviewsStore.averageStars.toStringAsFixed(2),
                        infoLabel: 'average stars',
                        cardColor: Colors.lightBlue,
                        iconData: Icons.star,
                        key: Key('avgStar')
                    )
                  ],
                );
              },
            ),
            SizedBox(height: 24.0,),
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.comment),
                  SizedBox(width: 10.0,),
                  Text("Reviews", style: TextStyle(fontSize: 18))
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Observer(
                  builder: (_) => _reviewsStore.reviews.isNotEmpty ? ListView(
                    children: _reviewsStore.reviews.reversed.map((reviewItem) {
                      return ReviewWidget(
                        reviewItem: reviewItem,
                      );
                    }).toList(),
                  ) : Text("No reviews yet")
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
