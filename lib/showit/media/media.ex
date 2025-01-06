defmodule Showit.Media do
  alias Showit.Media.Uploadcare

  def process_and_upload(%{path: path}, entry) do
    path |> File.read!() |> Uploadcare.upload_image(entry.client_name)
  end

  def create_image_group(file_ids) do
    Uploadcare.create_group(file_ids)
  end
end
