defmodule HeadlessBlog.Content.Posts do
  @moduledoc """
  The Content.Posts context.
  """

  import Ecto.Query, warn: false
  alias HeadlessBlog.Repo

  alias HeadlessBlog.Content.Posts.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts(critiria \\ %{}, opts \\ []) do
    preloads = Keyword.get(opts, :preload, [])

    from(p in Post)
    |> build_query(critiria)
    |> preload(^preloads)
    |> Repo.all()
  end

  # def list_posts(opts \\ []) do

  #   list_posts() |> Repo.preload()
  # end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(slug, opts \\ []) do
    preloads = Keyword.get(opts, :preload, [])

    Repo.get_by!(Post, %{slug: slug})
    |> Repo.preload(preloads)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:author, Map.get(attrs, "author"))
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  defp build_query(query, critiria) do
    critiria
    |> Enum.reduce(query, fn
      {:filter, filters}, query ->
        filter_with(filters, query)

      _, query ->
        query
    end)
  end

  defp filter_with(filters, query) do
    Enum.reduce(filters, query, fn
      {:status, status}, query ->
        query
        |> where([p], p.status == ^status)

      _, query ->
        query
    end)
  end
end
