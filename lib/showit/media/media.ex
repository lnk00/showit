defmodule Showit.Media do
  alias Showit.Media.Uploader

  def process_and_upload(file_path) do
    file_path |> File.read!() |> Uploader.upload_image()
  end
end
