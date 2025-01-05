defmodule Showit.Media.Uploader do
  @uploadcare_public_key "a0aefe93da84ada5c40e"

  def upload_image(image_binary, image_name) do
    url = "https://upload.uploadcare.com/base/"

    form = [
      {"UPLOADCARE_PUB_KEY", @uploadcare_public_key},
      {image_name, image_binary, {"form-data", [{"name", "file"}, {"filename", image_name}]},
       [{"Content-Type", "image/jpeg"}]}
    ]

    res = HTTPoison.post(url, {:multipart, form})

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
end
