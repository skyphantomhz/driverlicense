import 'package:drives_licence/model/zsigncategory.dart';
import 'package:drives_licence/ui/signpage/sign_bloc.dart';
import 'package:flutter/material.dart';

class SignPage extends StatefulWidget {
  SignPage({Key key}) : super(key: key);

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  SignBloc _signBloc;

  @override
  void initState() {
    _signBloc = SignBloc();
    super.initState();
  }

  @override
  void dispose() {
    _signBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ZsignCategory>>(
      stream: _signBloc.signCategories,
      builder: (context, snapshot) {
        final data = snapshot?.data;
        if (data == null) {
          return Container();
        } else {
          List<Widget> _tabPages = data
              .map((item) => Container(
                    child: ListView.builder(
                        itemCount: item.signs.length,
                        itemBuilder: (context, index) {
                          final sign = item.signs[index];
                          return Card(
                            child: Container(
                              child: ListTile(
                                leading: buildImage(sign.image),
                                title: Text(
                                  sign.name,
                                  style: Theme.of(context).textTheme.body2,
                                ),
                                subtitle: Text(
                                  sign.desc,
                                  style: Theme.of(context).textTheme.body1,
                                ),
                              ),
                            ),
                            //     child: Column(children: <Widget>[
                            //   Expanded(child:),
                            //   Container(
                            //     padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                            //     child: Text(sign.name))
                            // ])
                          );
                        }),
                  ))
              .toList();
          List<Tab> _tabs = data
              .map((type) => Tab(
                    text: type.name,
                  ))
              .toList();
          return DefaultTabController(
            length: data.length,
            child: Scaffold(
                appBar: AppBar(
                    leading: BackButton(),
                    title: Text("Biển Báo Giao Thông"),
                    bottom: TabBar(tabs: _tabs, isScrollable: true)),
                body: SafeArea(
                  child: TabBarView(
                    children: _tabPages,
                  ),
                )),
          );
        }
      },
    );
  }

  Widget buildImage(String sign) {
    if (sign?.isEmpty ?? true) {
      return Container();
    } else {
      final fileNameConverted = sign.replaceFirst("png", "webp");
      return Container(
        child: Image.asset(
          "assets/imageapp/$fileNameConverted",
          width: 50,
          height: 50,
        ),
      );
    }
  }
}
