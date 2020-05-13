defmodule HeadlessBlogWeb.PageControllerTest do
  use HeadlessBlogWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")

    assert redirected_to(conn) == Routes.admin_path(conn, :index)
  end
end
