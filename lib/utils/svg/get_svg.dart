import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class SvgImageFromWeatherStateAbbr extends StatelessWidget {
  final String weatherStateAbbr;

  const SvgImageFromWeatherStateAbbr({Key? key, required this.weatherStateAbbr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/$weatherStateAbbr.svg",
        semanticsLabel: weatherStateAbbr);
  }
}
