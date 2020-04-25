import 'package:flutter/material.dart';
import 'package:turismo_app/widgets/Stars.dart';

class SmallCard extends StatefulWidget{
  final String title;
  final String subtitle;
  final int clasification;
  final String imgUrl;
  final Function route;
  final bool liked;

  const SmallCard({
    Key key, 
    @required this.title,
    @required this.subtitle,
    @required this.clasification,
    @required this.imgUrl,
    @required this.route,
    this.liked = false
  }): super(key: key);

  @override
  _SmallCardState createState() => _SmallCardState(liked: liked);
}


class _SmallCardState extends State<SmallCard> { 
  bool liked;

  _SmallCardState({this.liked});

  void _changeFavorite() {
    if (liked) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmar'),
            content: Text('Esta acción eliminará los recuerdos añadidos a este lugar.'),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                padding: EdgeInsets.only(right: 20),
                child: Text("Aceptar"),
                onPressed: () {
                  setState(() {
                    liked = !liked;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        liked = !liked;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    
    return (
      GestureDetector(
        onTap: widget.route,
        child: Card(
          margin: EdgeInsets.only(bottom: 15, top: 10, right: 5, left: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          elevation: 5.0,
          child: Container(
            width: Width * 0.8,
            height: Width * 0.4,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget> [
                      ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                        child: Image.network(
                          widget.imgUrl,
                          fit: BoxFit.cover
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.only(bottom: 15, left: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(255, 255, 255, 0.85),
                          ),
                          child: IconButton(
                              icon: Icon(
                                liked ? Icons.favorite : Icons.favorite_border, 
                                color: Colors.teal[300],
                              ), 
                              onPressed: _changeFavorite,
                            ),
                        )
                      )
                    ], 
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: EdgeInsets.only(left: 12, top: 10, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.title, style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text(widget.subtitle, style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey[600],
                        ),),
                        Padding(padding: EdgeInsets.only(top: 65)),
                        Stars(count: 1)
                      ],
                    ),
                  )
                )
              ],
            ),      
          ),
        )
      )
    );
  }
}