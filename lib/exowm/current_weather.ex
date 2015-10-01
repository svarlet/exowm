defmodule Exowm.CurrentWeather do
  require Logger

  @moduledoc """
  This module defines a data structure and implements a parser to represent the
  values returned by the API.
  """

  defstruct calculation_time: -1,
            city_id: -1, city_name: "", country: "", lon: 0, lat: 0,
            sunrise_utc: -1, sunset_utc: -1,
            visibility: -1,
            weather_category: "", weather_subcategory: "", weather_icon_url: "", weather_id: -1,
            temperature: 0, pressure: -1, humidity: -1, temp_min: 0, temp_max: 0, sea_level: 0, grnd_level: 0,
            wind_speed: -1, wind_degree: 0,
            last_hour_snow_volume: -1, last_hour_rain_volume: -1,
            cloudiness: -1

  @type t :: %Exowm.CurrentWeather{calculation_time: Integer,
                             city_id: Integer, city_name: binary, country: binary, lon: float, lat: float,
                             sunrise_utc: Integer, sunset_utc: Integer,
                             visibility: Integer,
                             weather_category: binary, weather_subcategory: binary, weather_icon_url: binary, weather_id: Integer,
                             temperature: float, pressure: Integer, humidity: Integer, temp_min: Integer, temp_max: Integer, sea_level: Integer, grnd_level: Integer,
                             wind_speed: float, wind_degree: Integer,
                             last_hour_snow_volume: float, last_hour_rain_volume: float,
                             cloudiness: Integer}

  @spec read_latlon(t, Map) :: t
  defp read_latlon(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | lon: from["coord"]["lon"], lat: from["coord"]["lat"]}
  end

  @spec read_temperature(t, Map) :: t
  defp read_temperature(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | temperature: from["main"]["temp"]}
  end

  @spec read_pressure(t, Map) :: t
  defp read_pressure(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | pressure: from["main"]["pressure"]}
  end

  @spec read_humidity(t, Map) :: t
  defp read_humidity(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | humidity: from["main"]["humidity"]}
  end

  @spec read_temp_min(t, Map) :: t
  defp read_temp_min(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | temp_min: from["main"]["temp_min"]}
  end

  @spec read_temp_max(t, Map) :: t
  defp read_temp_max(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | temp_max: from["main"]["temp_max"]}
  end

  @spec read_sea_level(t, Map) :: t
  defp read_sea_level(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | sea_level: from["main"]["sea_level"]}
  end

  @spec read_grnd_level(t, Map) :: t
  defp read_grnd_level(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | grnd_level: from["main"]["grnd_level"]}
  end

  @spec read_wind(t, Map) :: t
  defp read_wind(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | wind_speed: from["wind"]["speed"], wind_degree: from["wind"]["deg"]}
  end

  @spec read_cloudiness(t, Map) :: t
  defp read_cloudiness(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | cloudiness: from["clouds"]["all"]}
  end

  @spec read_country(t, Map) :: t
  defp read_country(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | country: from["sys"]["country"]}
  end

  @spec read_sunrise_and_sunset(t, Map) :: t
  defp read_sunrise_and_sunset(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | sunrise_utc: from["sys"]["sunrise"], sunset_utc: from["sys"]["sunset"]}
  end

  @spec read_weather(t, Map) :: t
  defp read_weather(current_weather, from) do
    weather = Enum.at(from["weather"], 0)
    %Exowm.CurrentWeather{current_weather |
                          weather_id: weather["id"],
                          weather_category: weather["main"],
                          weather_subcategory: weather["description"],
                          weather_icon_url: weather["icon"]}
  end

  @spec read_city(t, Map) :: t
  defp read_city(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | city_id: from["id"], city_name: from["name"]}
  end

  @spec read_rain(t, Map) :: t
  defp read_rain(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | last_hour_rain_volume: from["rain"]["1h"]}
  end

  @spec read_snow(t, Map) :: t
  defp read_snow(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | last_hour_snow_volume: from["snow"]["1h"]}
  end

  @spec read_time(t, Map) :: t
  defp read_time(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | calculation_time: from["dt"]}
  end

  @spec read_visibility(t, Map) :: t
  defp read_visibility(current_weather, from) do
    %Exowm.CurrentWeather{current_weather | visibility: from["visibility"]}
  end

  @doc """
  This function transforms a map into a CurrentWeather struct.

  The provided map should be decoded from the JSON returned by the API.
  """
  @spec parse(Map) :: t
  def parse(data) do
    %Exowm.CurrentWeather{}
    |> read_latlon(data)
    |> read_temperature(data)
    |> read_pressure(data)
    |> read_humidity(data)
    |> read_temp_min(data)
    |> read_temp_max(data)
    |> read_sea_level(data)
    |> read_grnd_level(data)
    |> read_wind(data)
    |> read_cloudiness(data)
    |> read_country(data)
    |> read_sunrise_and_sunset(data)
    |> read_weather(data)
    |> read_city(data)
    |> read_rain(data)
    |> read_snow(data)
    |> read_time(data)
    |> read_visibility(data)
  end
end
