defmodule PlugForwardedPort do
  @moduledoc """
  A Plug that parses the X-Forwarded-Port header and sets the port in
  Plug.Conn.
  """
  import Plug.Conn
  alias Plug.Conn

  @behaviour Plug

  @header "x-forwarded-port"

  @spec init(Plug.opts()) :: Plug.opts()
  def init(opts) do
    header = Keyword.get(opts, :header, @header)

    [header: header]
  end

  def call(%Conn{} = conn, header: header) do
    with [str] when is_binary(str) <- get_req_header(conn, header),
         {port, ""} when port >= 1 and port <= 65535 <- Integer.parse(str) do
      %{conn | port: port}
    else
      _ -> conn
    end
  end
end
