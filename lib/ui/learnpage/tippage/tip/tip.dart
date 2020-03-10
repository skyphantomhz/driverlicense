import 'package:drives_licence/model/ztipcategoty.dart';
import 'package:flutter/material.dart';

class TipView extends StatefulWidget {
  TipView({Key key, this.category}) : super(key: key);
  final Stream<List<ZtipCategory>> category;

  @override
  _TipViewState createState() => _TipViewState();
}

class _TipViewState extends State<TipView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ZtipCategory>>(
      stream: widget.category,
      builder: (context, snapshot) {
        final data = snapshot?.data;
        if (data == null) {
          return Container(
            color: Colors.pink,
          );
        } else {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
            final item = data[index];
            return Card(child: ListTile(title: Text(item.name),),);
          });
        }
      },
    );
  }
}
