String getWeatherImages(String weatherDescription)
{
  switch(weatherDescription) {
    case "clear sky":
        return "images/background_clear.jpg";
        break;
    case "light rain":
        return "images/background_lightrain.jpg";
        break;
    case "moderate rain":
        return "images/background_moderaterain.jpg";
        break;
    case "few clouds":
        return "images/background_lightcloud.png";
        break;
    case "overcast clouds":
        return "images/background_overcastcloud.jpg";
        break;
    case "scattered clouds":
        return "images/background_brokencloud.jpg";
        break;
    case "broken clouds":
        return "images/background_brokencloud.jpg";
        break;
    case "broken clouds":
        return "images/background_snow.jpg";
        break;
    default:
        return "images/background_day.jpg";
        break;
  }
}
