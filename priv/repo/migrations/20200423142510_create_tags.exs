defmodule HeadlessBlog.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string
      add :slug, :string
      add :description, :string
      add :properties, :map

      timestamps(default: fragment("NOW()"))
    end

    create unique_index(:tags, [:slug])
  end
end
