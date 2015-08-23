defmodule Exowm.Query do
  use HTTPoison.Base

  @endpoint "http://api.openweathermap.org/data/2.5"

  def weather_in(city, country_code, options \\ []) do
    options_with_city = Keyword.put(options, :q, "#{city},#{country_code}")
    %HTTPoison.Response{body: body} = get!("/weather", [], [params: options_with_city])
    Exowm.Current.from body
  end

  def forecast_in(city, country_code, options \\ []) do
    options_with_city = Keyword.put(options, :q, "#{city},#{country_code}")
    get!("/forecast", [], [params: options_with_city])
  end

  def process_url(url) do
    @endpoint <> url
  end

  def process_response_body(body) do
    body
    |> Poison.Parser.parse!
  end
end
