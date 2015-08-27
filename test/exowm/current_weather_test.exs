defmodule CurrentWeatherTest do
  use ExUnit.Case

  alias Exowm.CurrentWeather

  test "It has valid default values" do
    default_struct = %CurrentWeather{}
    assert default_struct == %CurrentWeather{
      calculation_time: -1,
      city_id: -1,
      city_name: "",
      country: "",
      lon: 0,
      lat: 0,
      sunrise_utc: -1,
      sunset_utc: -1,
      visibility: -1,
      weather_category: "",
      weather_subcategory: "",
      weather_icon_url: "",
      weather_id: -1,
      temperature: 0,
      pressure: -1,
      humidity: -1,
      temp_min: 0,
      temp_max: 0,
      sea_level: 0,
      grnd_level: 0,
      wind_speed: -1,
      wind_degree: 0,
      last_hour_snow_volume: -1,
      last_hour_rain_volume: -1,
      cloudiness: -1
    }
  end
  
  test "Given an empty map, from/1 returns a default CurrentWeather struct" do
    assert %CurrentWeather{} == CurrentWeather.from %{}
  end

  test "from/1 sets the lon and lat fields when it finds a \"coord\" property in the parameter" do
    expected = %CurrentWeather{lon: 42.42, lat: 43.43}
    result = CurrentWeather.from %{"coord" => %{"lon" => 42.42, "lat" => 43.43}}
    assert expected == result
  end
end
