ExUnit.start()

defmodule Exowm.HttpSpy do
  def get!(url, headers, params) do
    send self(), {:get!, url, headers, params}
    %HTTPoison.Response{body: %{}}
  end
end
