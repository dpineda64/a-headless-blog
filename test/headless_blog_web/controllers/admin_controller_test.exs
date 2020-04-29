defmodule HeadlessBlogWeb.AdminControllerTest do
  use HeadlessBlogWeb.ConnCase

  test "REDIRECT FROM /admin", %{conn: conn} do
    conn = get(conn, "/admin")

    assert redirected_to(conn) == Routes.pow_session_path(conn, :new, request_path: "/admin")
  end
end
