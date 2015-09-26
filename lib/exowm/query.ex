defmodule Exowm.Query do
  @moduledoc """
  This module provides functions to query the [OpenWeatherMap "Current"
  API](http://openweathermap.org/current)

  """

  @url "http://api.openweathermap.org/data/2.5"

  @doc """
  The weather_in function requests the current weather for a location specified
  by a city name and its country code.

  It takes an optional third parameter to specify request parameters such as
  the lang or the units system. It is recommended to build this list of
  parameters with the Exowm.Options module.

  ## Example
      iex> opts = Exowm.Options.in_french |> Exowm.Options.in_metric_units
      [units: "metric", lang: "fr"]
      iex> Exowm.Query.weather_in "london", "uk", opts
      %Exowm.CurrentWeather{calculation_time: 1443268529, city_id: 2643743,
      city_name: "London", cloudiness: 40, country: "GB", grnd_level: nil,
      humidity: 51, last_hour_rain_volume: -1, last_hour_snow_volume: -1, lat: 51.51,
      lon: -0.13, pressure: 1029, sea_level: nil, sunrise_utc: 1443246791,
      sunset_utc: 1443289766, temp_max: 18.33, temp_min: 14, temperature: 16.08,
      visibility: 10000, weather_category: "Clouds", weather_icon_url: "03d",
      weather_id: 802, weather_subcategory: "partiellement ensoleillé",
      wind_degree: 20, wind_speed: 3.1}
  """
  @spec weather_in(binary, binary, [{atom, binary}]) :: Exowm.CurrentWeather.t
  def weather_in(city, country_code, options \\ [], http_module \\ HTTPoison) do
    params = build_request_params(options, city, country_code)
    url_for("/weather")
    |> http_module.get!([], [params: params])
    |> Map.get(:body)
    |> Poison.Parser.parse!
    |> Exowm.CurrentWeather.parse
  end

  defp build_request_params(options, city, country_code) do
    options
    |> enforce_json
    |> specify_location(city, country_code)
  end

  defp enforce_json(options) do
    Keyword.put(options, :mode, "json")
  end

  defp specify_location(options, city, country_code) do
    Keyword.put(options, :q, "#{city},#{country_code}")
  end

  @doc false
  def url_for(endpoint) do
    @url <> endpoint
  end
end
