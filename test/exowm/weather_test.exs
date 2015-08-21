defmodule Exowm.WeatherTest do
  use ExUnit.Case

  test "in_json appends {:mode, \"json\"} to the provided options" do
    assert [mode: "json"] == Exowm.Weather.in_json([])
    assert [key: "value", mode: "json"] == Exowm.Weather.in_json([key: "value"])
  end

  test "in_xml appends {:mode, \"xml\" to the provided options}" do
    assert [mode: "xml"] == Exowm.Weather.in_xml([])
    assert [key: "value", mode: "xml"] == Exowm.Weather.in_xml([key: "value"])
  end

  test "in_html appends {:mode, \"html\"} to the provided options" do
    assert [mode: "html"] == Exowm.Weather.in_html([])
    assert [key: "value", mode: "html"] == Exowm.Weather.in_html([key: "value"])
  end

  test "in_french appends {:lang, \"french\"} to the provided options" do
    assert [lang: "fr"] == Exowm.Weather.in_french([])
    assert [key: "value", lang: "fr"] == Exowm.Weather.in_french([key: "value"])
  end
end
