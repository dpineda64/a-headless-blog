defmodule HeadlessBlog.Repo.Migrations.AddStatusToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add(:status, :string, null: false, default: "draft")
    end
  end
end
