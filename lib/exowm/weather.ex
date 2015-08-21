defmodule Exowm.Weather do
  use HTTPoison.Base

  @endpoint "http://api.openweathermap.org/data/2.5/weather"

  @spec by_city_and_country_code(binary, binary, [{atom, any}]) :: {:ok, HTTPoison.Response.t} | {:error, HTTPoison.Error.t}
  def by_city_and_country_code(city, country_code, options \\ []) do
    get!(@endpoint, [], options ++ [ :q, "#{city},#{country_code}" ])
  end

  @spec in_json([{atom, any}]) :: [{atom, any}]
  def in_json(options \\ []) do
    options ++ [{:mode, "json"}]
  end

  @spec in_xml([{atom, any}]) :: [{atom, any}]
  def in_xml(options \\ []) do
    options ++ [{:mode, "xml"}]
  end

  @spec in_html([{atom, any}]) :: [{atom, any}]
  def in_html(options \\ []) do
    options ++ [{:mode, "html"}]
  end

  @external_resource langs_file = Path.join(__DIR__, "langs.txt")

  for line <- File.stream!(langs_file, [], :line) do
    [name, abbrev] = line
                     |> String.strip(?\n)
                     |> String.split("=", parts: 2, trim: true)
    def unquote(String.to_atom("in_" <> name))(options \\ []) do
      options ++ [{:lang, unquote(abbrev)}]
    end
  end
end
