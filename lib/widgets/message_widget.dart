import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {

  final String name;
  final String message;
  final bool first;

  const MessageWidget({
    Key key,
    @required this.message,
    @required this.name,
    this.first=false
  }) : super(key: key);

  Widget _getSelfMessage(context) {
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Flexible(
          child: Container(
            margin: EdgeInsets.only(top: (this.first ? 10 : 3), left: 50),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: (this.first ? Radius.zero : Radius.circular(10))
              ),
              boxShadow: [
                /* BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(1,1)
                ) */
              ]
            ),
            child: Text(this.message),
          )
        ),
        ( this.first ? 
            Container(
              width: 10,
              height: 10,
              margin: EdgeInsets.only(top: (this.first ? 10 : 3)),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(10, 10)),
                boxShadow: [
                  /* BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(1,1)
                  ) */
                ]
              ),
            )
            : SizedBox(height: 10, width: 10)
        )
      ]
    );
  }

  Widget _getMessage(context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ( this.first ? 
            Container(
              width: 10,
              height: 10,
              margin: EdgeInsets.only(top: (this.first ? 10 : 3)),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(10, 10)),
                boxShadow: [
                  /* BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(-1,1)
                  ) */
                ]
              ),
            )
            : SizedBox(height: 10, width: 10)
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(top: (this.first ? 10 : 3), right: 50),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                topLeft: (this.first ? Radius.zero : Radius.circular(10))
              ),
              boxShadow: [
                /* BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(1,1)
                ) */
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ( this.first ? 
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(this.name, 
                      style: Theme.of(context).accentTextTheme.headline1
                    )
                  )
                  : Container(width: 0)
                ),
                Text(this.message),
              ]
            )
          )
        ),
        
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.name != null) 
      return this._getMessage(context);
    
    return this._getSelfMessage(context);
  }
}