defmodule HeadlessBlogWeb.Admin.PostController do
  use HeadlessBlogWeb, :controller

  alias HeadlessBlog.Content
  alias HeadlessBlog.Content.Posts
  alias Phoenix.LiveView

  def index(conn, _params) do
    posts = Content.Posts.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Content.Posts.change_post(%Posts.Post{})

    LiveView.Controller.live_render(conn, HeadlessBlogWeb.EditorView,
      session: %{
        changeset: changeset,
        author: Pow.Plug.current_user(conn)
      }
    )
  end

  def create(conn, %{"post" => post_params}) do
    current_user = Pow.Plug.current_user(conn)

    case Posts.create_post(Map.put_new(post_params, "author_id", current_user.id)) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"slug" => slug}) do
    post = Posts.get_post!(slug)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"slug" => slug}) do
    post = Posts.get_post!(slug)
    changeset = Posts.change_post(post)

    LiveView.Controller.live_render(conn, HeadlessBlogWeb.EditorView,
      session: %{
        changeset: changeset,
        author: post.author,
        post: post
      }
    )
  end

  def update(conn, %{"slug" => slug, "post" => post_params}) do
    post = Posts.get_post!(slug)

    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"slug" => slug}) do
    post = Posts.get_post!(slug)
    {:ok, _post} = Posts.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
