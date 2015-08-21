defmodule Exowm.Weather do
  use HTTPoison.Base

  @endpoint "http://api.openweathermap.org/data/2.5/weather"

  @spec by_city_and_country_code(binary, binary, [{atom, any}]) :: {:ok, HTTPoison.Response.t} | {:error, HTTPoison.Error.t}
  def by_city_and_country_code(city, country_code, options \\ []) do
    get(@endpoint, [], options ++ [ :q, "#{city},#{country_code}" ])
  end



  defp append_to(nil, key_value) do
    [key_value]
  end

  defp append_to(options, nil) do
    options
  end

  defp append_to(options, key_value) do
    options ++ [key_value]
  end

  @spec in_json([{atom, any}]) :: {atom, any}
  def in_json(options \\ []), do: append_to(options, {:mode, "json"})

  @spec in_xml([{atom, any}]) :: {atom, any}
  def in_xml(options \\ []), do: append_to(options, {:mode, "xml"})

  @spec in_html([{atom, any}]) :: {atom, any}
  def in_html(options \\ []), do: append_to(options, {:mode, "html"})



  @external_resource langs_file = Path.join(__DIR__, "langs.txt")

  File.stream!(langs_file, [], :line)
  |> Stream.map(&String.strip(&1, ?\n))
  |> Stream.map(&String.strip/1)
  |> Stream.map(&String.split(&1, "=", parts: 2, trim: true))
  |> Enum.each(fn([name, abbrev]) -> def unquote(String.to_atom("in_" <> name))(options \\ []), do: append_to(options, {:lang, unquote(abbrev)}) end)
end
