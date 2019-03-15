defmodule DemoWeb.TodoLive.New do
  use Phoenix.LiveView

  alias DemoWeb.TodoLive
  alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.TodoList
  alias Demo.TodoList.Todo

  def mount(_session, socket) do
    {:ok,
     assign(socket, %{
       count: 0,
       changeset: TodoList.change_todo(%Todo{})
     })}
  end

  def render(assigns), do: DemoWeb.TodoView.render("new.html", assigns)

  def handle_event("validate", %{"todo" => params}, socket) do
    changeset =
      %Todo{}
      |> Demo.TodoList.change_user(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"todo" => todo_params}, socket) do
    case TodoList.create_todo(todo_params) do
      {:ok, todo} ->
        {:stop,
         socket
         |> put_flash(:info, "todo created")
         |> redirect(to: Routes.live_path(socket, TodoLive.Index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
