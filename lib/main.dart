import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_forecast/model/weather_forecast_model.dart';
import 'package:weather_forecast/ui/bottom_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_forecast/util/convert_images.dart';
import 'package:weather_forecast/util/forecast_util.dart';

import 'network/network.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  runApp(WeatherForecast());
}

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {

  Future<WeatherForecastModel> forecast;
  String _cityName = "Kolkata";

  @override
  void initState() {
    super.initState();
    forecast = getWeather(_cityName);
  }


  /* Retrieving PODO data */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: FutureBuilder<WeatherForecastModel>(
            future: forecast,
            builder: (BuildContext context, AsyncSnapshot<WeatherForecastModel> snapshot) {
              if (snapshot.hasData) {
                return screenView(context, snapshot);
              }
              else {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            }
          ),
        ),
      ),
    );
  }


  Widget screenView(BuildContext context, AsyncSnapshot<WeatherForecastModel> snapshot) {

    var city = snapshot.data.city.name;
    var country = snapshot.data.city.country;
    var forecastList = snapshot.data.list;
    var date = DateTime.fromMicrosecondsSinceEpoch(forecastList[0].dt * 1000000);
    var currentTemperature = (forecastList[0].main.temp - 273.15).toStringAsFixed(0);
    var details = (forecastList[0].weather[0].description);
    var rain = (forecastList[0].clouds.all);
    var humidity = (forecastList[0].main.humidity);
    var windSpeed = (forecastList[0].wind.speed).toStringAsFixed(2);

    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);


    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getWeatherImages(details)),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [

          citySearchScreen(context),

          SizedBox(height: 65),

          /* Location */
          Text(
            '$city, $country',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            )
          ),

          /*Current Date Time */
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              "${Util.getFormattedDate(date)}",
              style: TextStyle(
                color:Colors.white54,
              )
            ),
          ),

          SizedBox(height: 15),

          /* Current Temperature in Celcius */
          Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '$currentTemperature°C',
                style: TextStyle(
                  fontSize: 90,
                  fontWeight: FontWeight.w700,
                  color: Colors.yellowAccent,
                ),
              )),

          /* Current Weather Description */
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              capitalize(details),
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),

          /* Rain Humidity and Wind Speed Icons  */
          Center(
            child: Container(
              width: 150,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  SvgPicture.asset(
                      'images/temperature.svg',
                      height: 30,
                      width: 30,
                      color: Colors.white70
                  ),
                  SvgPicture.asset(
                      'images/rain.svg',
                      height: 30,
                      width: 30,
                      color: Colors.white70
                  ),
                  SvgPicture.asset(
                      'images/Wind.svg',
                      height: 30,
                      width: 30,
                      color: Colors.white70
                  ),
                ]
              ),
            ),
          ),

          SizedBox(height: 5),

          /* Rain Humidity and Wind Speed Values  */
          Center(
            child: Container(
              width: 170,
              height: 20,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Text('  $humidity%     $rain%      $windSpeed',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )
                    ),
                  ]
              ),
            ),
          ),

          SizedBox(height: 50),

          /* BottomView where data of different Timeline are shown */
          bottomView(snapshot, context),
        ],
      ),
    );
  }

  Widget citySearchScreen(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height / 5,

      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.transparent),
        color: new Color.fromRGBO(0, 0, 0, 0.25),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 75,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50),
            child: textFieldView(),
          ),
        ],
      ),
    );
  }

  Widget textFieldView() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Enter City Name',
          hintStyle: TextStyle(height: 1.5),
          prefixIcon: Icon(
            Icons.search,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        onSubmitted: (value) {
          setState(() {
            _cityName = value;
            forecast = getWeather(_cityName);
          });
        },
      ),
    );
  }

  Future<WeatherForecastModel> getWeather(String cityName) {
    return Network().getWeatherForecast(cityName: _cityName);
  }
}
