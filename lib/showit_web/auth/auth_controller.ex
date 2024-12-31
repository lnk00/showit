defmodule ShowitWeb.AuthController do
  use ShowitWeb, :controller

  def register(conn, _params) do
    render(conn, "register.html", layout: false)
  end

  def login(conn, _params) do
    render(conn, "login.html", layout: false)
  end
end
