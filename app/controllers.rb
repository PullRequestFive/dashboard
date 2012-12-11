Dashboard.controllers  do
  get :index do
    @twitter_users = ['icco', 'alexbaldwin', 'github']
    if params['twitter']
      @twitter_users = params['twitter'].split(',')[0..2]
    end

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

  get :weather do
    require 'json'
    require 'open-uri'

    location = params.empty? ? "CA/San_francisco" : params["location"]
    url = "http://api.wunderground.com/api/3b784b87b99428fb/conditions/q/#{location}.json"
    weather = "Sunny"
    temp = 60.1
    open(url) do |json|
      hash = JSON.load(json)
      condition = hash["current_observation"]
      weather = condition["weather"]
      temp = condition["temp_f"]
    end

    content_type "application/json"
    return {
      :weather => weather,
      :temp => temp.to_i,
      :char => weatherToChar(weather),
    }.to_json
  end

  get :about do
    render :about
  end
end
