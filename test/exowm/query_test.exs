defmodule Exowm.QueryTest do
  use ExUnit.Case

  test "weather_in does not specify any headers" do
    Exowm.Query.weather_in("london", "uk", [], Exowm.HttpSpy)
    assert_received {:get!, _, headers, _}
    assert [] == headers
  end

  Test "weather_in sends a request to the right url" do
    Exowm.Query.weather_in("london", "uk", [], Exowm.HttpSpy)
    assert_received {:get!, url, _, _}
    assert url == Exowm.Query.api_url <> "/weather"
  end

  test "weather_in injects the city and the country_code into the provided params" do
    Exowm.Query.weather_in("london", "uk", [], Exowm.HttpSpy)
    assert_received {:get!, _, _, params: params}
    assert {:q, "london,uk"} == List.keyfind(params, :q, 0)
  end
end
