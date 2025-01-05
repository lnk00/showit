defmodule Showit.Media do
  alias Showit.Media.Uploader

  def process_and_upload(file) do
    file.path |> File.read!() |> Uploader.upload_image(file.name)
  end
end
