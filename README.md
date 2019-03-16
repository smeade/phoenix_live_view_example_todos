![](todos_demo.gif)

# Live View Todos Example

[Chris McCord's](https://github.com/chrismccord) [LiveView example repo](https://github.com/chrismccord/phoenix_live_view_example) with a Todos demo (based on the Users CRUD demo) added. I created the todos demo in order to discover and learn about LiveView and to take it for a test drive. The demo is based loosely on todo mvc, but completely server-side via LiveView.

After installing as instructed below, visit [`localhost:4000/todos`](http://localhost:4000/todos) from your browser.

# Attributions
  * The other examples are all Chris McCord's. I copied his Users CRUD example as a starting place for the `/todos` demo and wrote the `todo_`-related code on top of that. If I were to do it over, I would have forked that repo to make this history explicit.
  * css from [TodoMVC](https://github.com/tastejs/todomvc).

# Demo

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
