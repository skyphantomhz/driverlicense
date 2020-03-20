import 'package:bloc_provider/bloc_provider.dart';
import 'package:drives_licence/ui/learnpage/tippage/tip_bloc.dart';
import 'package:drives_licence/ui/learnpage/tippage/tip_page.dart';
import 'package:flutter/material.dart';

class TipProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider<TipBloc>(
          creator: (_context, _bag) => TipBloc(),
          child: TipPage(),
        );
  }
}