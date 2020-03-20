import 'package:bloc_provider/bloc_provider.dart';
import 'package:drives_licence/model/ztipcategoty.dart';
import 'package:drives_licence/ui/learnpage/tippage/tip_bloc.dart';
import 'package:flutter/material.dart';

class TipView extends StatefulWidget {
  TipView({Key key}) : super(key: key);

  @override
  _TipViewState createState() => _TipViewState();
}

class _TipViewState extends State<TipView> {
  TipBloc _tipBloc;

  @override
  void initState() {
    _tipBloc = BlocProvider.of<TipBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ZtipCategory>>(
      stream: _tipBloc.getCategories(widget.key.toString()),
      builder: (context, snapshot) {
        final data = snapshot?.data;
        if (data == null) {
          return Container();
        } else {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Container(
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          item.isExpand = !item.isExpand;
                        });
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(item.name),
                        ),
                      ),
                    ),
                    getContentExpand(item.isExpand, item.pk)
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget getContentExpand(bool isExpand, int categoryId) {
    if (isExpand) {
      return Container(
        padding: EdgeInsets.all(8),
        child: Text(
          _tipBloc.getTipsBy(categoryId),
          style: Theme.of(context).textTheme.body1,
        ),
      );
    } else {
      return Container();
    }
  }
}
