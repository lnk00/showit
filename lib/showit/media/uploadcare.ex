defmodule Showit.Media.Uploadcare do
  @base_url "https://upload.uploadcare.com"
  @public_key "a0aefe93da84ada5c40e"

  def upload_image(image_binary, image_name) do
    form = [
      {"UPLOADCARE_PUB_KEY", @public_key},
      {image_name, image_binary, {"form-data", [{"name", "file"}, {"filename", image_name}]},
       [{"Content-Type", "image/jpeg"}]}
    ]

    res = HTTPoison.post(@base_url <> "/base/", {:multipart, form})

    case res do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, %{"file" => file_id}} -> file_id
          _ -> {:error, "Failed to get file ID from response"}
        end

      {:error, reason} ->
        {:error, "Upload failed: #{inspect(reason)}"}
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
end
