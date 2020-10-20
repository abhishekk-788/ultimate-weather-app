import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_forecast/model/weather_forecast_model.dart';
import 'package:weather_forecast/util/forecast_util.dart';

class Network{
  Future<WeatherForecastModel> getWeatherForecast({String cityName}) async {
    var url = "http://api.openweathermap.org/data/2.5/forecast?q="+cityName+"&appid="+Util.appId;

    final response = await get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      return WeatherForecastModel.fromJson(json.decode(response.body));
    }
    else {
      throw Exception("Request cannot be processed");
    }
  }
}