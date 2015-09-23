defmodule Exowm.Query do
  use HTTPoison.Base

  @url "http://api.openweathermap.org/data/2.5"

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

  def url_for(endpoint) do
    @url <> endpoint
  end
end
