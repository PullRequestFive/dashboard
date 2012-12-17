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

  get :user, :with => :username do
    @user = User.find_by_username params[:username]
    if @user
      p @user.get_config(:twitter)
      render :user
    else
      404
    end
  end

  get :edit do
    @user = User.find_by_username session[:username]
    @user = User.find_by_email session[:email] if @user.nil?

    if @user.nil?
      redirect '/login'
    else
      render :edit
    end
  end

  post :edit do
    @user = User.find_by_username session[:username]
    @user = User.find_by_email session[:email] if @user.nil?
    if @user.nil?
      redirect '/login'
    else
      @user.username = params[:username].strip
      @user.email = params[:email].strip
      @user.set_config(:twitter, params[:twitter].strip.split(','))
      @user.save

      redirect "/user/#{@user.username}"
    end
  end


  # Auth shit
  %w(get post).each do |method|
    send(method, "/auth/:provider/callback") do
      p env['omniauth.auth'] # => OmniAuth::AuthHash
      username = env['omniauth.auth'].info.username

      @user = User.find_by_username params[:username]

      if @user
        session['username'] = @user.username
      elsif username
        @user = User.new
        @user.username = username
        @user.save
      elsif env['omniauth.auth'].info.email
        @user = User.new
        @user.email = env['omniauth.auth'].info.email
        @user.save

        session['email'] = @user.email
        redirect "/edit"
      else
        500
      end

      redirect "/user/#{@user.username}"
    end
  end

  get '/auth/failure' do
    flash[:notice] = params[:message] # if using sinatra-flash or rack-flash
    redirect '/'
  end

  get "/login" do
    provider = Padrino.env == :development ? "developer" : "google_oauth2"
    redirect "/auth/#{provider}"
  end

  get "/logout" do
    session = {}
    redirect '/'
  end
end
