defmodule HeadlessBlog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :slug, :string
      add :content, :string
      add :images, {:array, :string}
      add :properties, :map
      add :author_id, references(:users, on_delete: :nothing)

      timestamps(default: fragment("NOW()"))
    end

    create unique_index(:posts, [:slug])
    create index(:posts, [:author_id])
  end
end
