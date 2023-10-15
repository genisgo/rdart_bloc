import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rdart/rviews.dart';

class BlocBuilder<B extends Bloc, S> extends Rview {
  final B bloc;
  final Relement Function(S state) builder;
  BlocBuilder({required this.bloc, required this.builder});
  late StreamSubscription<dynamic> _streamSubscription;
  Relement _currentview = SizeBox();
  @override
  void initState() {
    _streamSubscription = bloc.stream.listen((event) {
      _currentview = builder.call(event);
      setState(() {});
    });
    super.initState();
  }

  @override
  Relement build() {
    return _currentview;
  }

  @override
  Future ondispose() {
    _streamSubscription.cancel();
    return super.ondispose();
  }
}
