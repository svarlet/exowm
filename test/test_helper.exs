ExUnit.start()

defmodule Exowm.HttpSpy do
  def get!(url, headers, params) do
    send self(), {:get!, url, headers, params}
    %HTTPoison.Response{body: typical_response}
  end

  defp typical_response do
  """
  {
    "coord":{"lon":-0.13,"lat":51.51},
    "weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],
    "base":"stations",
    "main":{"temp":289.38,"pressure":1029,"humidity":55,"temp_min":287.15,"temp_max":292.04},
    "visibility":10000,
    "wind":{"speed":2.6,"deg":40},
    "clouds":{"all":40},
    "dt":1443267001,
    "sys":{"type":1,"id":5093,"message":0.0128,"country":"GB","sunrise":1443246790,"sunset":1443289767},
    "id":2643743,
    "name":"London",
    "cod":200
  }
  """
  end
end
