// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonWithLoader<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  final BlocWidgetSelector<S, bool> selector;
  final B bloc;
  final VoidCallback onPressed;
  final String label;

  const ButtonWithLoader({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.selector,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, S, bool>(
      bloc: bloc,
      selector: selector,
      builder: (context, showLoading) {
        return ElevatedButton(
          onPressed: showLoading ? null : onPressed,
          style: !showLoading
              ? ElevatedButton.styleFrom()
              : ElevatedButton.styleFrom(
                  shape: CircleBorder(), onSurface: Colors.blue),
          child: Visibility(
            visible: showLoading,
            replacement: Text(label),
            child: Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
