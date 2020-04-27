defmodule HeadlessBlogWeb.AdminController do
  use HeadlessBlogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
