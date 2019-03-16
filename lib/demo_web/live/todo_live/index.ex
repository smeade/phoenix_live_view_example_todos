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
    assign(socket, %{
      count: Enum.count(TodoList.list_active_todos()),
      todos: TodoList.list_todos(),
      changeset: TodoList.change_todo(%Demo.TodoList.Todo{})
    })
  end

  def handle_info({TodoList, [:todo | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("save", %{"todo" => todo_params}, socket) do
    case TodoList.create_todo(todo_params) do
      {:ok, _todo} ->
        {:noreply, fetch(socket)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, fetch(socket)}
    end
  end

  def handle_event("delete_todo", id, socket) do
    todo = TodoList.get_todo!(id)
    {:ok, _todo} = TodoList.delete_todo(todo)

    {:noreply, socket}
  end

  def handle_event("toggle_complete_todo", id, socket) do
    todo = TodoList.get_todo!(id)
    {:ok, _todo} = TodoList.toggle_complete_todo(todo)

    {:noreply, socket}
  end
end
