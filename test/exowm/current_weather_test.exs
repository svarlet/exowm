defmodule CurrentWeatherTest do
  use ExUnit.Case

  alias Exowm.CurrentWeather

  defp to_map(property_chain, value) do
    property_chain
    |> String.split(".")
    |> Enum.reverse
    |> Enum.reduce(value, fn (key, acc) -> Map.put(%{}, key, acc) end)
    |> inject_dummy_weather_data
  end

  defp inject_dummy_weather_data(a_map) do
    Map.put(a_map, "weather", [%{"id" => 0, "main" => "", "description" => "", "icon" => ""}])
  end

  %{"coord.lon" => "lon",
    "coord.lat" => "lat",
    "main.temp" => "temperature",
    "main.pressure" => "pressure",
    "main.humidity" => "humidity",
    "main.temp_min" => "temp_min",
    "main.temp_max" => "temp_max",
    "main.sea_level" => "sea_level",
    "main.grnd_level" => "grnd_level",
    "wind.speed" => "wind_speed",
    "wind.deg" => "wind_degree",
    "clouds.all" => "cloudiness",
    "sys.country" => "country",
    "sys.sunrise" => "sunrise_utc",
    "sys.sunset" => "sunset_utc",
    "id" => "city_id",
    "name" => "city_name",
    "rain.1h" => "last_hour_rain_volume",
    "snow.1h" => "last_hour_snow_volume",
    "dt" => "calculation_time",
    "visibility" => "visibility"}
  |> Enum.each fn({input_key, output_key}) ->
    test "parse/1 maps `#{input_key}` to `#{output_key}`" do
      result = to_map(unquote(input_key), 42) |> CurrentWeather.parse
      assert 42 == Map.fetch!(result, String.to_atom unquote(output_key))
    end
  end

  test "CurrentWeather's struct has valid default values" do
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

  test "parse/1 sets the weather attributes when it finds a list containing them under a `weather` key in the input param" do
    input = %{"weather" =>
      [%{
        "id" => 42,
        "main" => 43,
        "description" => 44,
        "icon" => 45
      }]
    }
    result = CurrentWeather.parse input
    assert result.weather_id == 42
    assert result.weather_category == 43
    assert result.weather_subcategory == 44
    assert result.weather_icon_url == 45
  end
end

