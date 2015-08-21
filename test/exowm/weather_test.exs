defmodule Exowm.WeatherTest do
  use ExUnit.Case

  defp appends?(module, func, kv) do
    assert [kv] == apply(module, func, [nil]), "it appends to a new list when the options are nil"
    assert [kv] == apply(module, func, [ [] ]), "it appends once to an empty list"
    assert ([key: "value"] ++ [kv]) == apply(module, func, [[{:key, "value"}]]), "it appends once to a non nil/not empty list"
  end

  test "appends json/html/xml modes to the provided options" do
    appends? Exowm.Weather, :in_json, {:mode, "json"}
    appends? Exowm.Weather, :in_xml, {:mode, "xml"}
    appends? Exowm.Weather, :in_html, {:mode, "html"}
  end

  test "appends langs to the provided options" do
    appends? Exowm.Weather, :in_bulgarian, {:lang, "bg"}
    appends? Exowm.Weather, :in_catalan, {:lang, "ca"}
    appends? Exowm.Weather, :in_chinese_simplified, {:lang, "zh"}
    appends? Exowm.Weather, :in_chinese_traditional, {:lang, "zh_tw"}
    appends? Exowm.Weather, :in_croatian, {:lang, "hr"}
    appends? Exowm.Weather, :in_dutch, {:lang, "nl"}
    appends? Exowm.Weather, :in_english, {:lang, "en"}
    appends? Exowm.Weather, :in_finnish, {:lang, "fi"}
    appends? Exowm.Weather, :in_french, {:lang, "fr"}
    appends? Exowm.Weather, :in_german, {:lang, "de"}
    appends? Exowm.Weather, :in_italian, {:lang, "it"}
    appends? Exowm.Weather, :in_polish, {:lang, "pl"}
    appends? Exowm.Weather, :in_portuguese, {:lang, "pt"}
    appends? Exowm.Weather, :in_romanian, {:lang, "ro"}
    appends? Exowm.Weather, :in_russian, {:lang, "ru"}
    appends? Exowm.Weather, :in_spanish, {:lang, "es"}
    appends? Exowm.Weather, :in_swedish, {:lang, "sv"}
    appends? Exowm.Weather, :in_turkish, {:lang, "tr"}
    appends? Exowm.Weather, :in_ukrainian, {:lang, "uk"}
  end
end
