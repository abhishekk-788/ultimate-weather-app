String weatherIcon(String description){
  switch(description)
  {
    case "clear sky":
        return "images/c.svg";
        break;
    case "light rain":
        return "images/lr.svg";
        break;
    case "moderate rain":
        return "images/hr.svg";
        break;
    case "few clouds":
        return "images/lc.svg";
        break;
    case "overcast clouds":
        return "images/hc.svg";
        break;
    case "scattered clouds":
        return "images/hc.svg";
        break;
    case "broken clouds":
        return "images/sl.svg";
        break;
    default:
        return "images/c.svg";
        break;
  }
}