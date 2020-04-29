defmodule HeadlessBlog.Factory do
  use ExMachina.Ecto, repo: HeadlessBlog.Repo

  def user_factory(attrs \\ %{}) do
    user = %HeadlessBlog.Accounts.Users.User{
      email: sequence(:email, &"email-#{&1}@test.com"),
      username: "TestUser"
    }

    merge_attributes(user, attrs)
  end

  def post_factory(attrs \\ %{}) do
    author = build(:user)
    title = sequence(:title, &"A nice Post! (Part #{&1})")

    post = %HeadlessBlog.Content.Posts.Post{
      content: "some text content",
      images: [],
      title: title,
      author: author,
      status: "draft",
      slug: Slugger.slugify(title)
    }

    merge_attributes(post, attrs)
  end
end
