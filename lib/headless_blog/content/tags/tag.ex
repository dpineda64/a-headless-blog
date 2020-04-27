defmodule HeadlessBlog.Content.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :description, :string
    field :name, :string
    field :properties, :map
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :slug, :description, :properties])
    |> validate_required([:name, :slug, :description, :properties])
    |> unique_constraint(:slug)
  end
end
