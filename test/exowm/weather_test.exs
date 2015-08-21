defmodule Exowm.WeatherTest do
  use ExUnit.Case

  defp appends?(module, func, kv) do
    assert [kv] == apply(module, func, [nil]), "it appends to a new list when the options are nil"
    assert [kv] == apply(module, func, [ [] ]), "it appends once to an empty list"
    assert ([key: "value"] ++ [kv]) == apply(module, func, [[{:key, "value"}]]), "it appends once to a non nil/not empty list"
  end

  test "in_json appends {:mode, \"json\"} to the provided options" do
    appends? Exowm.Weather, :in_json, {:mode, "json"}
  end

  test "in_xml appends {:mode, \"xml\" to the provided options}" do
    appends? Exowm.Weather, :in_xml, {:mode, "xml"}
  end

  test "in_html appends {:mode, \"html\"} to the provided options" do
    appends? Exowm.Weather, :in_html, {:mode, "html"}
  end

  test "in_french appends {:lang, \"french\"} to the provided options" do
    appends? Exowm.Weather, :in_french, {:lang, "fr"}
  end
end
