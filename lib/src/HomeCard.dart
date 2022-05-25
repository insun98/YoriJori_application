import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Provider/AuthProvider.dart';



class homeCard extends StatefulWidget {
  const homeCard({required this.posts, required this.profile});
  final Profile profile;
  final List<Post> posts;

  @override
  _homeCardState createState() => _homeCardState();
}

class _homeCardState extends State<homeCard> {
  bool _isbooked = false;
  @override
  Widget build(BuildContext context) {
    List<Card> _buildListCards(BuildContext context) {
      List<Post> posts = widget.posts;
      if (posts.isEmpty) {
        return const <Card>[];
      }
      final ThemeData theme = Theme.of(context);
      final NumberFormat formatter = NumberFormat.simpleCurrency(
          locale: Localizations.localeOf(context).toString());
      Profile profile = widget.profile;
      return posts.map((post) {
        print("${post.creator}");
        bool _isFavorited  = false;
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Wrap(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                            profile.photo),
                        backgroundColor: Colors.transparent,
                      ),


                      SizedBox(width: 20,),
                      Text(
                        '${profile.name}',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                  Text(
                    '${post.description}',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
              AspectRatio(
                aspectRatio: 25 / 11,
                child:
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    post.image,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      20, 5, 0, 0),
                  child: Column(
                    // TODO: Align labels to the bottom and center (103)
                    crossAxisAlignment: CrossAxisAlignment
                        .start,
                    // TODO: Change innermost Column (103)
                    children: <Widget>[
                      /*Text(
                                              '$name',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                              maxLines: 1,
                                            ),*/
                      // TODO: Handle overflowing labels (103)
                      Text(
                        '열량: ',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        '가격: ${post.price}',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        '재료: 양파(200g), 파(100g), 돼지고기(300g)',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          FavoriteWidget(post: post),
                          IconButton(
                            icon: const Icon(
                              Icons.chat_outlined,
                              semanticLabel: 'chatting',
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: () {
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList();
    }

    // TODO: implement build
    return Flexible(
      child: GridView.count(
        crossAxisCount: 1,
        padding: const EdgeInsets.all(5),
        childAspectRatio: 1 / 1,
        children: _buildListCards(context),
      ),
    );
  }

}

class FavoriteWidget extends StatefulWidget{


  const FavoriteWidget({required this.post});
  final Post post;
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}
class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;
  bool _isBooked = false;


  @override
  Widget build(BuildContext context) {
    ApplicationState postProvider = Provider.of<ApplicationState>(context);
    return Consumer<ApplicationState>( builder: (context, appState, _) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (widget.post.islike
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border)),
            color: Colors.red,
            onPressed: (){
              setState(() {
                if (widget.post.islike) {
                  widget.post.like -= 1;
                  widget.post.islike = false;
                  postProvider.updateDoc(widget.post.docId, widget.post.like, widget.post.islike);
                } else {
                  widget.post.like += 1;
                  widget.post.islike = true;
                }
              });
            },
          ),
        ),
        Text(
          '${widget.post.like}',
        ),
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isBooked
                ? const Icon(Icons.book)
                : const Icon(Icons.book_outlined)),
            color: Colors.brown,
            onPressed: _togglebook,
          ),
        ),
      ],
    ),
    );
  }
  void _toggleFavorite() {

  }
  void _togglebook() {
    setState(() {
      if (_isBooked) {
        //_favoriteCount -= 1;
        _isBooked = false;
      } else {
        //  _favoriteCount += 1;
        _isBooked = true;
      }
    });
  }
}