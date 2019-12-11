# PlugForwardedPort

Plug for parsing the `X-Forwarded-Port` header and setting the `Plug.Conn` port from it.

I use this on Heroku to set the port correctly, so `Plug.Conn.request_url/1` generates the URL correctly.

## Installation

```elixir
def deps do
  [
    {:plug_forwarded_port, "~> 0.1.0"},
  ]
end
```
