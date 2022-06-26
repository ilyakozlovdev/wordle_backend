defmodule WordleBackendWeb.PageController do
  use WordleBackendWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
