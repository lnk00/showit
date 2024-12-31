defmodule ShowitWeb.LandingController do
  use ShowitWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
