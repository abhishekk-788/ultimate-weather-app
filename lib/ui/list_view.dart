
import 'package:flutter/material.dart';
import 'package:weather_forecast/model/weather_forecast_model.dart';

Widget listView(AsyncSnapshot<WeatherForecastModel> snapshot, BuildContext context) {
  var forecast = snapshot.data.list;

  return Column(
    children: [
      Expanded(
        child: ListView.builder(
            itemCount: 8,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
            return getWeatherHourlyDetails(forecast[index], context);
          }),
      ),
    ],
  );
}

Widget getWeatherHourlyDetails(Lists forecastList, BuildContext context) {
  var time = forecastList.dtTxt;
  var temperature = forecastList.main.temp;
  var details = forecastList.weather[0].description;

  return Card(
    child: Container(
      height: 40,
    ),
  );
}

