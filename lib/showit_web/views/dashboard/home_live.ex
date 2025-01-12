defmodule ShowitWeb.Dashboard.HomeLive do
  alias Showit.Project
  use ShowitWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mx-auto w-[800px]">
      <.async_result :let={projects} assign={@projects}>
        <:loading>Loading organization...</:loading>
        <:failed :let={_failure}>there was an error loading the organization</:failed>

        <div class="w-96 h-48 bg-gray-50 border border-gray-100 rounded-xl p-4">
          <span>
            {projects.name}
          </span>
        </div>
      </.async_result>
      <.link patch={~p"/dashboard/create"}>
        <.button>
          create project
        </.button>
      </.link>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    user = socket.assigns.current_user

    {:ok,
     socket
     |> assign_async(:projects, fn ->
       {:ok, %{projects: Project.by_user(user)}}
     end)}
  end
end
