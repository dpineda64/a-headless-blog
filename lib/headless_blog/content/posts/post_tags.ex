defmodule HeadlessBlog.Content.Posts.PostTags do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts_tags" do
    field(:post_id, :id)
    field(:tag_id, :id)

    timestamps()
  end

  @doc false
  def changeset(post_tags, attrs) do
    post_tags
    |> cast(attrs, [])
    |> validate_required([])
  end
end
