defmodule HeadlessBlog.Content.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :slug}

  alias HeadlessBlog.Accounts.Users.User

  alias HeadlessBlog.Content.{
    Tags.Tag,
    Posts.PostTags
  }

  @required_fields ~w(title content status)a
  @optional_fields ~w(images properties)a

  schema "posts" do
    field(:content, :string)
    field(:images, {:array, :string})
    field(:title, :string)
    field(:properties, :map)
    field(:slug, :string)
    field(:status, :string, default: "draft")

    belongs_to(:author, User)
    many_to_many(:tags, Tag, join_through: PostTags)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> HeadlessBlog.Utils.build_slug()
    |> validate_required(@required_fields)
    |> unique_constraint(:slug)
  end
end
