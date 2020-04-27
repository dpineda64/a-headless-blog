defmodule HeadlessBlogWeb.Helpers.LinkHelper do
  alias Phoenix.Controller

  def active_class(conn, path, classes, activeClass \\ "active") do
    # clasess = Keyword.get(opts, :class, "")
    if path == Controller.current_path(conn) do
      classes <> " " <> activeClass
    else
      classes
    end
  end
end
