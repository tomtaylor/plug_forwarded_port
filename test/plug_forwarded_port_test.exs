defmodule PlugForwardedPortTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "set the port if the header is present" do
    conn =
      :get
      |> conn("/foo")
      |> Plug.Conn.put_req_header("x-forwarded-port", "1234")
      |> PlugForwardedPort.call(PlugForwardedPort.init([]))

    assert conn.port == 1234
  end

  test "doesn't set the port if the header is not present" do
    conn =
      :get
      |> conn("/foo")
      |> PlugForwardedPort.call(PlugForwardedPort.init([]))

    assert conn.port == 80
  end

  test "doesn't set the port if the header is not a valid integer" do
    conn =
      :get
      |> conn("/foo")
      |> Plug.Conn.put_req_header("x-forwarded-port", "foo")
      |> PlugForwardedPort.call(PlugForwardedPort.init([]))

    assert conn.port == 80
  end

  test "doesn't set the port if the header is a negative integer" do
    conn =
      :get
      |> conn("/foo")
      |> Plug.Conn.put_req_header("x-forwarded-port", "-123")
      |> PlugForwardedPort.call(PlugForwardedPort.init([]))

    assert conn.port == 80
  end

  test "doesn't set the port if the header is an integer > 65535" do
    conn =
      :get
      |> conn("/foo")
      |> Plug.Conn.put_req_header("x-forwarded-port", "65536")
      |> PlugForwardedPort.call(PlugForwardedPort.init([]))

    assert conn.port == 80
  end

  test "doesn't set the port if the header has a trailing string after the integer" do
    conn =
      :get
      |> conn("/foo")
      |> Plug.Conn.put_req_header("x-forwarded-port", "1234 and 5")
      |> PlugForwardedPort.call(PlugForwardedPort.init([]))

    assert conn.port == 80
  end
end
