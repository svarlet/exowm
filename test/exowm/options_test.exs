defmodule Exowm.OptionsTest do
  use ExUnit.Case

  defp added?(module, func, kv) do
    assert [kv] == apply(module, func, [ [] ])
    expected = Keyword.merge [key: "value"], [kv]
    actual = apply(module, func, [[{:key, "value"}]])
    assert expected == actual
  end

  test "supports standard, imperial and metric units" do
    added? Exowm.Options, :in_metric_units, {:units, "metric"}
    added? Exowm.Options, :in_imperial_units, {:units, "imperial"}
    added? Exowm.Options, :in_standard_units, {:units, "standard"}
  end

  test "supports multiple langs" do
    added? Exowm.Options, :in_bulgarian, {:lang, "bg"}
    added? Exowm.Options, :in_catalan, {:lang, "ca"}
    added? Exowm.Options, :in_chinese_simplified, {:lang, "zh"}
    added? Exowm.Options, :in_chinese_traditional, {:lang, "zh_tw"}
    added? Exowm.Options, :in_croatian, {:lang, "hr"}
    added? Exowm.Options, :in_dutch, {:lang, "nl"}
    added? Exowm.Options, :in_english, {:lang, "en"}
    added? Exowm.Options, :in_finnish, {:lang, "fi"}
    added? Exowm.Options, :in_french, {:lang, "fr"}
    added? Exowm.Options, :in_german, {:lang, "de"}
    added? Exowm.Options, :in_italian, {:lang, "it"}
    added? Exowm.Options, :in_polish, {:lang, "pl"}
    added? Exowm.Options, :in_portuguese, {:lang, "pt"}
    added? Exowm.Options, :in_romanian, {:lang, "ro"}
    added? Exowm.Options, :in_russian, {:lang, "ru"}
    added? Exowm.Options, :in_spanish, {:lang, "es"}
    added? Exowm.Options, :in_swedish, {:lang, "sv"}
    added? Exowm.Options, :in_turkish, {:lang, "tr"}
    added? Exowm.Options, :in_ukrainian, {:lang, "uk"}
  end
end

