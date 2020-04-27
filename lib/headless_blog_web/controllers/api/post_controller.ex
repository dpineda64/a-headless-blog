defmodule HeadlessBlogWeb.Api.PostController do
  use HeadlessBlogWeb, :controller

  alias HeadlessBlog.Content.Posts

  def index(conn, _params) do
    posts = Posts.list_posts(preload: true)
    render(conn, "index.json", posts: posts)
  end

  def show(conn, %{"slug" => slug}) do
    post = Posts.get_post!(slug, preload: true)
    render(conn, "show.json", post: post)
  end
end
