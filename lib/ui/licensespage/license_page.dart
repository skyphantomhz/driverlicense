import 'package:drives_licence/model/zlicense.dart';
import 'package:drives_licence/ui/global.dart';
import 'package:drives_licence/ui/licensespage/license_bloc.dart';
import 'package:flutter/material.dart';

class LicensesPage extends StatefulWidget {
  LicensesPage({Key key}) : super(key: key);
  @override
  _LicensesPageState createState() => _LicensesPageState();
}

class _LicensesPageState extends State<LicensesPage> {
  LicenseBloc _licenseBloc;

  @override
  void initState() {
    _licenseBloc = LicenseBloc();
    setListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Zlicense>>(
        stream: _licenseBloc.licenses,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Zlicense> data = snapshot.data;
          if (data == null) {
            return Container(
              alignment: Alignment.center,
              child: Text("Empty data"),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                final item = data[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: InkWell(
                    onTap: () {
                      _licenseBloc.saveSelectedLicense(item);
                    },
                    child: ListTile(
                        leading: Container(
                          width: 30,
                          alignment: Alignment.centerLeft,
                          child: Text(item.name,
                              style: Theme.of(context).textTheme.body2),
                        ),
                        title: Text(item.content,
                            style: Theme.of(context).textTheme.body1)),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _licenseBloc.dispose();
    super.dispose();
  }

  void setListener() {
    _licenseBloc.eventState.listen((data) {
      if (data == Event.HOME) {
        Navigator.of(context).pushNamedAndRemoveUntil(RouteName.HOME,  ModalRoute.withName(RouteName.ROOT));
      }
    });
  }
}
