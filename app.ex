defmodule App do
  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Router, options: [port: 4000]}
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

defmodule Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/api" do
    send_resp(conn, 200, '{"message": "Hello from Elixir"}')
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end