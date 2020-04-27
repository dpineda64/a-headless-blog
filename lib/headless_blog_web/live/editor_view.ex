defmodule HeadlessBlogWeb.EditorView do
  use Phoenix.LiveView, layout: {HeadlessBlogWeb.LayoutView, "admin.html"}
  alias HeadlessBlogWeb.Admin.PostView
  alias HeadlessBlog.Content.Posts
  alias HeadlessBlogWeb.Router.Helpers, as: Routes

  def render(assigns) do
    PostView.render("new.html", assigns)
  end

  def mount(session, socket) do
    content = get_content(session)
    action = get_action(session)
    content_md = Earmark.as_html!(content)

    value = %{
      changeset: session.changeset,
      preview: content_md,
      author: session.author_id,
      action: action,
      post: get_post(session),
      errors: []
    }

    {:ok, assign(socket, value)}
  end

  def handle_event("render", %{"post" => %{"content" => content}}, socket) do
    content_md =
      case Earmark.as_html(content) do
        {:ok, html, _} -> html
        {:error, html, _} -> html
      end

    assigns = %{
      preview: content_md
    }

    {:noreply, assign(socket, assigns)}
  end

  def handle_event(
        "submit",
        %{"post" => post},
        %{assigns: %{author: author, action: action, post: prev_post}} = socket
      ) do
    post
    |> Map.put_new("author_id", author)
    |> create_or_update(action, prev_post)
    |> case do
      {:ok, post} ->
        {:stop,
         socket
         |> put_flash(:info, "Post Created")
         |> redirect(to: Routes.post_path(socket, :edit, post))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp get_content(%{changeset: %{data: %{content: content}}}) when not is_nil(content),
    do: content

  defp get_content(_), do: ""

  defp get_action(%{post: _post}), do: :edit
  defp get_action(_), do: :insert

  defp get_post(%{post: post}) when not is_nil(post), do: post
  defp get_post(_), do: nil

  defp create_or_update(params, :edit, post), do: Posts.update_post(post, params)

  defp create_or_update(params, _action, _post), do: Posts.create_post(params)
end
