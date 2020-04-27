defmodule HeadlessBlog.Repo do
  use Ecto.Repo,
    otp_app: :headless_blog,
    adapter: Ecto.Adapters.Postgres
end
