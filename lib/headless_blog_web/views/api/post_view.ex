defmodule HeadlessBlogWeb.Api.PostView do
  use HeadlessBlogWeb, :view

  def render("index.json", %{posts: posts}) do
    Enum.map(posts, &posts_json/1)
  end

  def render("show.json", %{post: post}) do
    posts_json(post)
  end

  defp posts_json(post) do
    %{
      title: post.title,
      slug: post.slug,
      content: post.content,
      author: %{
        username: post.author.username
      }
    }
  end
end
