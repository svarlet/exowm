defmodule Exowm.CurrentWeather do
  defstruct calculation_time: 0,
            city_id: 0, city_name: "", country: "", lon: 0, lat: 0,
            sunrise_utc: 0, sunset_utc: 0,
            visibility: 0,
            weather_category: "", weather_subcategory: "", weather_icon_url: "", weather_id: 0,
            temperature: 0, pressure: 0, humidity: 0, temp_min: 0, temp_max: 0, sea_level: 0, grnd_level: 0,
            wind_speed: 0, wind_degree: 0,
            last_hour_snow_volume: 0, last_hour_rain_volume: 0,
            cloudiness: 0

  @type t :: %Exowm.CurrentWeather{calculation_time: Integer,
                             city_id: Integer, city_name: binary, lon: Integer, lat: Integer,
                             sunrise_utc: Integer, sunset_utc: Integer,
                             visibility: Integer,
                             weather_category: binary, weather_subcategory: binary, weather_icon_url: binary, weather_id: Integer,
                             temperature: float, pressure: Integer, humidity: Integer,
                             wind_speed: float, wind_degree: Integer,
                             last_hour_snow_volume: float, last_hour_rain_volume: float,
                             cloudiness: Integer}

  require Logger

  def from(value) when is_map(value) do
    value
    |> Enum.reduce(%Exowm.CurrentWeather{}, fn
      {k, v}, acc when k == "coord" ->
        Logger.debug("found coord")
        %Exowm.CurrentWeather{acc | lon: v["lon"], lat: v["lat"]}
      {k, v}, acc when k == "main" ->
        Logger.debug("found main")
        %Exowm.CurrentWeather{acc | temperature: v["temp"], pressure: v["pressure"], humidity: v["humidity"], temp_min: v["temp_min"], temp_max: v["temp_max"], sea_level: v["sea_level"], grnd_level: v["grnd_level"]}
      {k, v}, acc when k == "wind" -> 
        Logger.debug("found wind")
        %Exowm.CurrentWeather{acc | wind_speed: v["speed"], wind_degree: v["deg"]}
      {k, v}, acc when k == "clouds" ->
        Logger.debug "found clouds"
        %Exowm.CurrentWeather{acc | cloudiness: v["all"]}
      {k, v}, acc when k == "sys" ->
        Logger.debug "found sys"
        %Exowm.CurrentWeather{acc | country: v["country"], sunrise_utc: v["sunrise"], sunset_utc: v["sunset"]}
      {k, v}, acc when k == "weather" and is_list(v) ->
        Logger.debug "found weather, will only keep the first item!"
        w = Enum.at(v, 0)
        %Exowm.CurrentWeather{acc | weather_id: w["id"], weather_category: w["main"], weather_subcategory: w["description"], weather_icon_url: w["icon"]}
      {k, v}, acc when k == "id" ->
        Logger.debug "found city id"
        %Exowm.CurrentWeather{acc | city_id: v}
      {k, v}, acc when k == "name" ->
        Logger.debug "found city name"
        %Exowm.CurrentWeather{acc | city_name: v}
      {k, v}, acc when k == "rain" ->
        Logger.debug "found rain data"
        %Exowm.CurrentWeather{acc | last_hour_rain_volume: v["1h"]}
      {k, v}, acc when k == "snow" ->
        Logger.debug "found snow data"
        %Exowm.CurrentWeather{acc | last_hour_snow_volume: v["1h"]}
      {k, v}, acc when k == "dt" ->
        Logger.debug "found calculation time (utc)"
        %Exowm.CurrentWeather{acc | calculation_time: v}
      {k, v}, acc when k == "visibility" ->
        Logger.debug "found visility data"
        %Exowm.CurrentWeather{acc | visility: v}
      {k, v}, acc ->
        Logger.warn "unexpected property: #{k}: #{inspect v}"
        acc
    end)
  end
end

