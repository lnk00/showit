defmodule ShowitWeb.DashboardLive do
  alias Showit.Media
  use ShowitWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mx-auto w-[800px]">
      <form id="upload-form" phx-submit="save" phx-change="validate">
        <div class="w-full flex items-center justify-center gap-4">
          <div class="w-96 h-96 bg-gray-50 rounded-xl flex flex-col items-center gap-2 p-2">
            <div
              :for={entry <- @uploads.files.entries}
              class="w-full h-12 bg-white rounded flex items-center p-2 border gap-2"
            >
              <.live_img_preview entry={entry} class="w-8 h-8 rounded object-cover shrink-0" />
              <span class="text-sm opacity-70 truncate">
                {entry.client_name}
              </span>
              <button
                type="button"
                phx-click="cancel-upload"
                phx-value-ref={entry.ref}
                class="ml-auto"
              >
                <.icon name="hero-trash" class="h-4 w-4 opacity-30 shrink-0 hover:opacity-100" />
              </button>
            </div>
          </div>
          <div
            phx-drop-target={@uploads.files.ref}
            phx-click={JS.dispatch("click", to: "##{@uploads.files.ref}")}
            class="flex items-center justify-center w-full h-96 rounded-xl border-dashed border-2 bg-gray-50/30 hover:bg-gray-50 cursor-pointer"
          >
            <div class="flex flex-col items-center justify-center gap-4">
              <div class="rounded-full bg-gray-100 h-16 w-16 flex items-center justify-center">
                <.icon name="hero-arrow-up-tray-solid" class="h-5 w-5" />
              </div>
              <label class="">
                <.live_file_input upload={@uploads.files} class="hidden" />
                Drop your project files here
              </label>
            </div>
          </div>
        </div>
        <.input
          name="desc"
          type="textarea"
          value={@desc}
          placeholder="Describe your project in few lines"
        />
        <.button type="submit" class="w-full mt-4">showit</.button>
      </form>

      <div class="mt-8 flex items-center justify-center gap-2"></div>
    </div>
    """
  end

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

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :files, ref)}
  end

  def handle_event("save", %{"desc" => _desc}, socket) do
    uploaded_files = consume_uploaded_entries(socket, :files, &Media.process_and_upload/2)
    group = Media.create_image_group(uploaded_files)

    dbg(group)

    {:noreply,
     socket
     |> update(:uploaded_files, &(&1 ++ uploaded_files))
     |> put_flash(:info, "Files uploaded successfully: #{Enum.join(uploaded_files, ", ")}")}
  end
end
