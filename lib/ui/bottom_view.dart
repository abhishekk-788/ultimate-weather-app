import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_forecast/model/weather_forecast_model.dart';
import 'package:weather_forecast/ui/weather_icon.dart';
import 'package:weather_forecast/util/forecast_util.dart';

Widget bottomView(AsyncSnapshot<WeatherForecastModel> snapshot, BuildContext context) {
  var forecast = snapshot.data.list;

  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
    child: Row(
      children:[
        for(int index = 0; index < 40; index++)
        getWeatherHourlyDetails(forecast[index], context),
      ]
    ),
  );
}

Widget getWeatherHourlyDetails(Lists forecastList, BuildContext context) {
  var time = (forecastList.dtTxt).substring(11);
  var temperature = (forecastList.main.temp - 273.15).toStringAsFixed(0);
  var details = forecastList.weather[0].description;
  var date = (DateTime.fromMicrosecondsSinceEpoch(forecastList.dt * 1000000));
  String exactDate = Util.getFormattedDate(date);
  String exactDay = exactDate.substring(0,3);
  exactDate = exactDate.substring(5,11);


  return Padding(
    padding: const EdgeInsets.only(left: 16.0),
    child: Container(
      height: 150,
      width: 80,
      decoration: BoxDecoration(
        color: Color.fromRGBO(205, 212, 228, 0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Text(
              '$exactDay',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
            )
          ),
          SizedBox(height: 10),
          Text(
              '$exactDate',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              )
          ),
          SizedBox(height: 2),
          Text(
              '$time',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white60,
                fontWeight: FontWeight.w400,
              )
          ),
          SizedBox(height: 10),
          SvgPicture.asset(
            weatherIcon(details),
            height: 30,
            width: 30,
          ),
          SizedBox(height: 5),
          Text(
              '$temperature°C',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
          ),
        ],
      )
    ),
  );
}