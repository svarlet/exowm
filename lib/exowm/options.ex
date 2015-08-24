defmodule Exowm.Options do
  def in_json(options \\ []), do: Keyword.put(options, :mode, "json")

  def in_xml(options \\ []), do: Keyword.put(options, :mode, "xml")

  def in_html(options \\ []), do: Keyword.put(options, :mode, "html")


  def in_metric_units(options \\ []), do: Keyword.put(options, :units, "metric")
  
  def in_imperial_units(options \\ []), do: Keyword.put(options, :units, "imperial")

  def in_standard_units(options \\ []), do: Keyword.put(options, :units, "standard")


  @external_resource langs_file = Path.join(__DIR__, "langs.txt")

  File.stream!(langs_file, [], :line)
  |> Stream.map(&String.strip(&1, ?\n))
  |> Stream.map(&String.strip/1)
  |> Stream.map(&String.split(&1, "=", parts: 2, trim: true))
  |> Enum.each(fn([name, abbrev]) ->
                 @doc """
                   to_#{name} will add {:lang, #{abbrev}} to the provided Keyword.
                 """
                 def unquote(String.to_atom("in_#{name}"))(options \\ []) do
                   Keyword.put(options, :lang, unquote(abbrev))
                 end
               end)
end

