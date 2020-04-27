defmodule HeadlessBlog.Utils do
  def build_slug(%{changes: %{title: title}} = changeset) do
    generate_slug(changeset, title)
  end

  def build_slug(%{slug: slug}), do: slug

  def build_slug(%Ecto.Changeset{} = changeset), do: changeset

  defp generate_slug(changeset, title) do
    Ecto.Changeset.cast(
      changeset,
      %{slug: "#{Slugger.slugify(title)}"},
      [:slug]
    )
  end
end
