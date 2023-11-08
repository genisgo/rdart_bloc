import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rdart/rviews.dart';

class BlocBuilder<B extends Bloc, S> extends Rview {
  final B bloc;
  final Relement Function(S state) builder;
  final Function(S state)? onBuild;
  BlocBuilder({required this.bloc, required this.builder, this.onBuild});
  late StreamSubscription<dynamic> _streamSubscription;
  Relement _currentview = SizeBox();
  @override
  void initState() {
    //  _currentview = builder.call(event);
    _streamSubscription = bloc.stream.listen((event) {
      _currentview = builder.call(event);
      setState(() {});
    });
    super.initState();
  }

  @override
  void onUpdate(old) {
    onBuild?.call(bloc.state);
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
