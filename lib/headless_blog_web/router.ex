defmodule HeadlessBlogWeb.Router do
  use HeadlessBlogWeb, :router
  use Pow.Phoenix.Router

  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.LiveView.Flash
  end

  pipeline :admin do
    plug :put_layout, {HeadlessBlogWeb.LayoutView, :admin}

    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through([:browser])

    get("/", HeadlessBlogWeb.Plugs.Redirector, to: "")

    if !!System.get_env("ALLOW_SIGNUPS") do
      pow_routes()
    else
      pow_session_routes()
    end

    pow_extension_routes()
  end

  scope "/", Pow.Phoenix, as: "pow" do
    pipe_through [:browser, :admin]
  end

  scope "/admin", HeadlessBlogWeb do
    pipe_through([:browser, :admin])
    get "/", AdminController, :index

    resources("/posts", Admin.PostController, param: "slug")
  end

  scope "/api", HeadlessBlogWeb do
    pipe_through :api
    resources("/posts", Api.PostController, only: [:index, :show], param: "slug")
  end
end
