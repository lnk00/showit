defmodule ShowitWeb.DashboardLive do
  use ShowitWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:uploaded_files, [])
     |> allow_upload(:files, accept: ~w(.jpg .jpeg), max_entries: 3)}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("save", _params, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :files, fn p, entry ->
        file_name = entry.client_name
        file = {p, entry}
        dbg(file)
        dbg(Path.basename(p.path))
        {:ok, file_name}
      end)

    {:noreply,
     socket
     |> update(:uploaded_files, &(&1 ++ uploaded_files))
     |> put_flash(:info, "Files uploaded successfully: #{Enum.join(uploaded_files, ", ")}")}
  end
end
