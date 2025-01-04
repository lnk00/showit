defmodule Showit.Media.Uploader do
  @uploadcare_public_key "a0aefe93da84ada5c40e"

  def upload_image(image_binary) do
    url = "https://upload.uploadcare.com/base/"

    form = [
      {"UPLOADCARE_PUB_KEY", @uploadcare_public_key},
      {"lololo.jpg", image_binary, {"form-data", [{"name", "file"}, {"filename", "lololo.jpg"}]},
       [{"Content-Type", "image/jpeg"}]}
    ]

    res = HTTPoison.post(url, {:multipart, form})

    dbg(res)
  end
end
