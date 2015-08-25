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

  @type t :: %CurrentWeather{calculation_time: Integer,
                             city_id: Integer, city_name: "", lon: Integer, lat: Integer,
                             sunrise_utc: Integer, sunset_utc: Integer,
                             visibility: Integer,
                             weather_category: binary, weather_subcategory: binary, weather_icon_url: binary, weather_id: Integer,
                             temperature: float, pressure: Integer, humidity: Integer,
                             wind_speed: float, degree: Integer,
                             last_hour_snow_volume: float, last_hour_rain_volume: float,
                             cloudiness: Integer}



  defmodule Coord do
    defstruct lon: 0, lat: 0
    @type t :: %Coord{lon: float, lat: float}
  end

  defmodule Weather do
    defstruct id: 0, main: "", description: "", icon: ""
    @type t :: %Weather{id: Integer, main: binary, description: binary, icon: binary}
  end

  defmodule Main do
    defstruct temp: 0, pressure: 0, humidity: 0, temp_min: 0, temp_max: 0, sea_level: 0, grnd_level: 0
    @type t :: %Main{temp: float, pressure: Integer, humidity: Integer, temp_min: float, temp_max: float, sea_level: Integer, grnd_level: Integer}
  end

  defmodule Wind do
    defstruct speed: 0, deg: 0
    @type t :: %Wind{speed: float, deg: Integer}
  end

  defmodule Clouds do
    defstruct all: 0
    @type t :: %Clouds{all: Integer}
  end

  defmodule Sys do
    defstruct type: 0, id: 0, message: 0.0, country: "", sunrise: 0, sunset: 0
    @type t :: %Sys{type: Integer, id: Integer, message: float, country: binary, sunrise: Integer, sunset: Integer}
  end

  defmodule Current do
    defstruct coord: nil, weather: [], base: "", main: nil, visibility: 0, wind: nil, clouds: nil, rain: nil, snow: nil, dt: 0, sys: nil, id: 0, name: "", cod: 0
    @type t :: %Current{coord: Coord.t, weather: [Weather.t], base: binary, main: Main.t, visibility: Integer, wind: Wind.t, clouds: Clouds.t, rain: %{}, snow: %{}, dt: Integer, sys: Sys.t, id: Integer, name: binary, cod: Integer}

    require Logger

    def from(value) when is_map(value) do
      IO.puts "About to convert the following data to Current: #{inspect value}"
      value
      |> Enum.reduce([], fn
        {k, v}, acc when k == "coord" ->
          Logger.debug("found coord")
          [{String.to_atom(k), %Coord{lon: v["lon"], lat: v["lat"]}} | acc]
        # {k, v}, acc when k == "weather" -> {String.to_atom(k), %Weather{id: v["id"], main: v["main"], description: v["description"], icon: v["icon"]}}
        {k, v}, acc when k == "main" ->
          Logger.debug("found main")
          [{String.to_atom(k), %Main{temp: v["temp"], pressure: v["pressure"], humidity: v["humidity"], temp_min: v["temp_min"], temp_max: v["temp_max"], sea_level: v["sea_level"], grnd_level: v["grnd_level"]}} | acc]
        {k, v}, acc when k == "wind" -> 
          Logger.debug("found wind")
          [{String.to_atom(k), %Wind{speed: v["speed"], deg: v["deg"]}} | acc]
        {k, v}, acc when k == "clouds" ->
          Logger.debug "found clouds"
          [{String.to_atom(k), %Clouds{all: v["all"]}} | acc]
        {k, v}, acc when k == "sys" ->
          Logger.debug "found sys"
          [{String.to_atom(k), %Sys{type: v["type"], id: v["id"], message: v["message"], country: v["country"], sunrise: v["sunrise"], sunset: v["sunset"]}} | acc]
        {k, v}, acc when k == "weather" and is_list(v) ->
          Logger.debug "found weather, will only keep the first item!"
          w = Enum.at(v, 0)
          [{String.to_atom(k), %Weather{id: w["id"], main: w["main"], description: w["description"]}} | acc]
        {k, v}, acc ->
          Logger.debug "default matcher found #{k}"
          [{String.to_atom(k), v} | acc]
      end)
    end
  end
  
end

