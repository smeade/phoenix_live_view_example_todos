defmodule DemoWeb.TodoLive.Index do
  use Phoenix.LiveView

  alias Demo.TodoList
  alias DemoWeb.TodoView

  def mount(_session, socket) do
    if connected?(socket), do: Demo.TodoList.subscribe()
    {:ok, fetch(socket)}
  end

  def render(assigns), do: TodoView.render("index.html", assigns)

  defp fetch(socket) do
    assign(socket, todos: TodoList.list_todos())
  end

  def handle_info({TodoList, [:todo | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("delete_todo", id, socket) do
    todo = TodoList.get_todo!(id)
    {:ok, _todo} = TodoList.delete_todo(todo)

    {:noreply, socket}
  end
end
