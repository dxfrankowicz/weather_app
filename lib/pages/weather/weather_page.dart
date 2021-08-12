import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/api/di/di.dart';
import 'package:weather_app/api/models/consolidated_weather.dart';
import 'package:weather_app/components/base_scaffold.dart';
import 'package:weather_app/components/error_view.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/pages/weather/weather_store.dart';
import 'package:weather_app/utils/date_utils/my_date_utlls.dart';
import 'package:weather_app/utils/svg/get_svg.dart';
import 'package:sizer/sizer.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherStore weatherStore = getIt<WeatherStore>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    weatherStore.init(44418);
    super.initState();
  }

  String getFormattedTemp({required double temp, int precision = 1}) {
    double formattedTemp =
        weatherStore.tempUnit == TempUnit.C ? temp : ((temp * 1.8) + 32);
    String formattedDegree = getFormattedDegree(weatherStore.tempUnit);
    return "${formattedTemp.toStringAsFixed(precision)}$formattedDegree";
  }

  String getFormattedDegree(TempUnit tempUnit) {
    String formattedDegree =
        "${String.fromCharCode(0x00B0)}${tempUnit == TempUnit.C ? "C" : "F"}";
    return formattedDegree;
  }

  bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  Widget currentDayWeather() {
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: weatherStore.isLoadingWeather
              ? List.generate(
                  5,
                  (index) => Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Color(0xFFEBEBF4),
                          highlightColor: Color(0xFFF4F4F4),
                          child: Container(
                            width: MediaQuery.of(context).size.width /
                                Random().nextInt(4),
                            child: Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      )).toList()
              : [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: AutoSizeText(
                      MyDateUtils.getFullDateWeekdayName(context,
                          weatherStore.getCurrentDayWeather!.applicableDate),
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 50),
                    ),
                  ),
                  isPortrait(context)
                      ? Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              getWeatherStateName(context),
                              Expanded(
                                child: getWeatherIcon(
                                    weatherStateAbbr: weatherStore
                                        .getCurrentDayWeather!
                                        .weatherStateAbbr),
                              ),
                              getTemp(context),
                              Row(
                                children: [getWeatherParamsColumn()],
                              )
                            ],
                          ),
                        )
                      : Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        getWeatherStateName(context),
                                      ],
                                    ),
                                    Expanded(
                                      child: getWeatherIcon(
                                          weatherStateAbbr: weatherStore
                                              .getCurrentDayWeather!
                                              .weatherStateAbbr),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: getTemp(context),
                                      ),
                                      Expanded(
                                        child: getWeatherParamsColumn(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
        ),
      );
    });
  }

  Column getWeatherParamsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getWeatherParam(
            title: S.current.humidity,
            value: weatherStore.getCurrentDayWeather!.humidity,
            unit: "%"),
        getWeatherParam(
            title: S.current.airPressure,
            value: weatherStore.getCurrentDayWeather!.airPressure,
            unit: "hPa"),
        getWeatherParam(
            title: S.current.wind,
            value: weatherStore.getCurrentDayWeather!.windSpeed,
            unit: "km/h"),
      ],
    );
  }

  AutoSizeText getWeatherParam(
      {required String title, double? value, String? unit}) {
    return AutoSizeText("$title: ${value!.toStringAsFixed(1)} $unit",
        maxLines: 1, style: Theme.of(context).textTheme.subtitle1!);
  }

  Row getWeatherStateName(BuildContext context) {
    return Row(
      children: [
        AutoSizeText(
          weatherStore.getCurrentDayWeather!.weatherStateName,
          maxLines: 1,
          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 30),
        ),
      ],
    );
  }

  Container getWeatherIcon({required String weatherStateAbbr}) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(4),
      child: SvgImageFromWeatherStateAbbr(weatherStateAbbr: weatherStateAbbr),
    );
  }

  Row getTemp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
                getFormattedTemp(
                    temp: weatherStore.getCurrentDayWeather!.theTemp),
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget bottomDaysWeatherList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: weatherStore.isLoadingWeather
              ? List.generate(
                  5,
                  (index) => Shimmer.fromColors(
                        baseColor: Color(0xFFEBEBF4),
                        highlightColor: Color(0xFFF4F4F4),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Card(
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ))
              : weatherStore.location!.consolidatedWeather.map((e) {
                  return Observer(builder: (context) {
                    int i =
                        weatherStore.location!.consolidatedWeather.indexOf(e);
                    return InkWell(
                      onTap: () {
                        weatherStore.setIndex(i);
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Card(
                            shadowColor: weatherStore.selectedIndex == i
                                ? Colors.blue
                                : null,
                            elevation: weatherStore.selectedIndex == i ? 2 : 1,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: AutoSizeText(
                                            MyDateUtils.getDateWeekdayName(
                                                context, e.applicableDate),
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: isPortrait(context)
                                          ? Column(
                                              children: [
                                                Expanded(
                                                    child: getWeatherIcon(
                                                        weatherStateAbbr: e
                                                            .weatherStateAbbr)),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: getMinMaxTemp(
                                                            e, context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Expanded(
                                                  child: getWeatherIcon(
                                                      weatherStateAbbr:
                                                          e.weatherStateAbbr),
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: getMinMaxTemp(
                                                        e, context),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    )
                                  ]),
                            ),
                          )),
                    );
                  });
                }).toList()),
    );
  }

  AutoSizeText getMinMaxTemp(ConsolidatedWeather e, BuildContext context) {
    return AutoSizeText(
        "${getFormattedTemp(temp: e.minTemp)}/${getFormattedTemp(temp: e.maxTemp)}",
        maxLines: 1,
        minFontSize: 6,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText2);
  }

  void _onRefresh() async {
    // monitor network fetch
    await weatherStore.fetchWeather();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return WEATHERScaffold.get(context,
        actions: TempUnit.values
            .map((e) => Observer(builder: (context) {
                  return InkWell(
                    onTap: () {
                      weatherStore.setTempUnit(e);
                    },
                    child: Card(
                      color: Colors.white
                          .withOpacity(weatherStore.tempUnit == e ? 0.6 : 0.2),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        child: Text(getFormattedDegree(e)),
                      )),
                    ),
                  );
                }))
            .toList(),
        body: SmartRefresher(
          onRefresh: _onRefresh,
          controller: _refreshController,
          child: Center(
            child: Observer(
              builder: (_) {
                return weatherStore.lastException != null
                    ? ErrorView(
                        exception: weatherStore.lastException!,
                        actionName: S.current.retry,
                        actionFunction: () => weatherStore.retry())
                    : Column(
                        children: [
                          Expanded(
                              flex: !isPortrait(context) ? 4 : 5,
                              child: currentDayWeather()),
                          Expanded(flex: 2, child: bottomDaysWeatherList())
                        ],
                      );
              },
            ),
          ),
        ));
  }
}
