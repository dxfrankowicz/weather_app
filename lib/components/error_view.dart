import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/generated/l10n.dart';

class ErrorView extends StatelessWidget {
  final String? actionName;
  final VoidCallback? actionFunction;
  final Exception exception;

  const ErrorView(
      {Key? key, this.actionName, this.actionFunction, required this.exception})
      : super(key: key);

  Widget getExceptionImage() {
    if (exception is SocketException)
      return Lottie.asset('assets/lottie/no_internet_connection.json');
    return Lottie.asset('assets/lottie/error.json');
  }

  String getExceptionDesc() {
    if (exception is SocketException)
      return S.current.noInternetConnectionError;
    return S.current.commonError;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: getExceptionImage(),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getExceptionDesc(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            if (actionFunction != null && actionName != null)
              Container(
                width: 80.0.w,
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: actionFunction,
                  child: Text(actionName!.toUpperCase()),
                ),
              )
          ],
        ),
      ),
    ]));
  }
}
