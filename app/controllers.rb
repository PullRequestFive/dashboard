Dashboard.controllers  do
  get :index do
    render :index
  end

  get :picture do
    require 'rss'
    require 'open-uri'

    url = 'http://feeds.nationalgeographic.com/ng/photography/photo-of-the-day/'
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      big_img = feed.items.first.enclosure.url.sub("360x270", "1600x1200")

      redirect big_img
    end
  end
end
