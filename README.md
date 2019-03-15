![](todos_demo.gif)

# Live View Todos Example

I took [Chris McCord's](https://github.com/chrismccord) [LiveView example repo](https://github.com/chrismccord/phoenix_live_view_example), and added a Todos demo. Based loosely on todo mvc, but completely server-side via Live View.

After installing as instructed below, visit [`localhost:4000/todos`](http://localhost:4000/todos) from your browser.

Note that I wrote only the `todo_`-related code. The other examples are all from Chris's [LiveView example repo](https://github.com/chrismccord/phoenix_live_view_example) directly on top of which I stacked the `/todos` demo code.

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

## Scratchpad

  <%= link "Edit", to: Routes.live_path(@socket, TodoLive.Edit, todo) %>
