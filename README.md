# HeadlessBlog

Just trying out phoenix liveview by building a simple "Headless" blog that exposes an api and uses pow for authentication

#### To Do

- [x] Base Setup
  - [x] Add status to posts
- [x] Authentication
  - [ ] Confirmation Email
  - [ ] Persist Session
- [ ] Improve UI
- [x] Markdown Editor using lv
  - [ ] Show changeset errors
  - [ ] Auto save

#### Maybe

- [ ] Authorization

#### Thanks to

- Heavily inspired by nickdichev's [(markdown-live)](https://github.com/nickdichev/markdown-live)
- this post [Creating A Liveview Form](https://foglitstreet.com/creating-a-liveview-form)

---

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `cd assets && npm install`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: http://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Mailing list: http://groups.google.com/group/phoenix-talk
- Source: https://github.com/phoenixframework/phoenix
