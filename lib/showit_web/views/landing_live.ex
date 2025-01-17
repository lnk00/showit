defmodule ShowitWeb.LandingLive do
  use ShowitWeb, :live_view_no_layout

  def render(assigns) do
    ~H"""
    <div class="h-screen flex items-center justify-center">
      <div class="flex flex-col items-center justify-center gap-12">
        <div class="flex flex-col items-center justify-center gap-2">
          <img src="/images/logo.svg" alt="showit logo" class="h-20 w-20" />
          <h1 class="font-bold text-3xl">showit</h1>
        </div>
        <div class="w-[800px] flex flex-col items-center justify-center gap-4">
          <h2 class="font-bold text-5xl text-center">
            Avoid spending time demonstrating<br />what you've already created.
          </h2>
          <h3 class="font-medium text-4xl text-center opacity-30">
            We do it better, nicer and faster.
          </h3>
        </div>
        <div class="flex flex-col items-center justify-center gap-4">
          <.button class="py-4 px-6 text-xl">showit now</.button>
          <a href="/dashboard" class="text-xl">login</a>
        </div>
      </div>
    </div>

    <img
      src="https://ucarecdn.com/e65ad9ae-1871-469f-a90d-80857bc58f1f/-/scale_crop/300x400/"
      class="absolute top-24 left-96 rounded-2xl ring-2 ring-gray-200 -rotate-12"
    />
    """
  end
end
