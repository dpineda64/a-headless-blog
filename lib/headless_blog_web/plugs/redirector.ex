defmodule HeadlessBlogWeb.Plugs.Redirector do
  alias HeadlessBlogWeb.Router.Helpers, as: Routes
  import Phoenix.Controller, only: [redirect: 2]

  def init(opts) do
    opts
  end

  def call(%Plug.Conn{assigns: _assigns} = conn, _opts) do
    redirect(conn, to: Routes.admin_path(conn, :index))
  end
end
