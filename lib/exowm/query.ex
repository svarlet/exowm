defmodule Exowm.Query do
  use HTTPoison.Base

  @url "http://api.openweathermap.org/data/2.5"

  def weather_in(city, country_code, options \\ [], http_module \\ HTTPoison) do
    params = options
             |> enforce_json
             |> specify_location(city, country_code)
    %HTTPoison.Response{body: body} = http_module.get!("/weather", [], [params: params])
    Exowm.CurrentWeather.from body
  end

  defp enforce_json(options) do
    Keyword.put(options, :mode, "json")
  end

  defp specify_location(options, city, country_code) do
    Keyword.put(options, :q, "#{city},#{country_code}")
  end

  def url_of(endpoint) do
    @url <> endpoint
  end

  def process_response_body(body) do
    body
    |> Poison.Parser.parse!
  end
end
