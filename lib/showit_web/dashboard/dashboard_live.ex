defmodule ShowitWeb.DashboardLive do
  alias Showit.Media
  use ShowitWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:uploaded_files, [])
     |> assign(:desc, "")
     |> allow_upload(:files, accept: ~w(.jpg .jpeg), max_entries: 3)}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("save", %{"desc" => desc}, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :files, fn %{path: path}, entry ->
        file = %{path: path, name: entry.client_name}
        id = file |> Media.process_and_upload()
        {:ok, id}
      end)

    dbg(desc)
    dbg(uploaded_files)

    {:noreply,
     socket
     |> update(:uploaded_files, &(&1 ++ uploaded_files))
     |> put_flash(:info, "Files uploaded successfully: #{Enum.join(uploaded_files, ", ")}")}
  end
end
