defmodule Exowm.Options do
  @doc """
  Appends {:units, \"metric\"} to the provided options in order to get results
  expressed in the metric system.
  """
  def in_metric_units(options \\ []), do: Keyword.put(options, :units, "metric")

  @doc """
  Appends {:units, \"imperial\"} to the provided options in order to get results
  expressed in the metric system.
  """
  def in_imperial_units(options \\ []), do: Keyword.put(options, :units, "imperial")

  @doc """
  Appends {:units, \"standard\"} to the provided options in order to get results
  expressed in the metric system.
  """
  def in_standard_units(options \\ []), do: Keyword.put(options, :units, "standard")

  @external_resource langs_file = Path.join(__DIR__, "langs.txt")

  File.stream!(langs_file, [], :line)
  |> Stream.map(&String.strip(&1, ?\n))
  |> Stream.map(&String.strip/1)
  |> Stream.map(&String.split(&1, "=", parts: 2, trim: true))
  |> Enum.each(fn([name, abbrev]) ->
     @doc """
     Appends {:lang, #{abbrev}} to the provided options in order to get results in #{name}.
     """
     def unquote(String.to_atom("in_#{name}"))(options \\ []) do
       Keyword.put(options, :lang, unquote(abbrev))
     end
  end)
end

