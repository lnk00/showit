defmodule Showit.Media.Uploadcare do
  @base_url "https://upload.uploadcare.com"
  @public_key "a0aefe93da84ada5c40e"

  def upload_image(image_binary, image_name) do
    form = [
      {"UPLOADCARE_PUB_KEY", @public_key},
      {image_name, image_binary, {"form-data", [{"name", "file"}, {"filename", image_name}]},
       [{"Content-Type", "image/jpeg"}]}
    ]

    case HTTPoison.post(@base_url <> "/base/", {:multipart, form}) |> handle_response do
      {:ok, %{"file" => file_id}} -> {:ok, file_id}
      {:error, reason} -> {:error, reason}
    end
  end

  def create_group(file_ids) do
    form = [
      {"pub_key", @public_key}
      | file_ids
        |> Enum.with_index()
        |> Enum.map(&{"files[#{elem(&1, 1)}]", elem(&1, 0)})
    ]

    res = HTTPoison.post(@base_url <> "/group/", {:form, form})
    dbg(res)
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, Jason.decode!(body)}
  end

  def handle_response({:error, reason}) do
    {:error, reason}
  end
end
