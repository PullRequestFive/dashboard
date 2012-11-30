# Helper methods defined here can be accessed in any controller or view in the application

Dashboard.helpers do

  # TODO(icco): Finish mapping characters to weather
  def weatherToChar weather
    weather = weather.gsub(/(Light|Heavy)/, "").to_sym

    map = {
      :Drizzle => "6",
      :Rain => "=",
      :Snow => "o",
      :"Snow Grains" => "`",
      :"Ice Crystals" => "`",
      :"Ice Pellets" => "`",
      :Hail => "`",
      :Mist => "`",
      :Fog => "g",
      :"Fog Patches" => "`",
      :Smoke => "`",
      :"Volcanic Ash" => "`",
      :"Widespread Dust" => "`",
      :Sand => "`",
      :Haze => "`",
      :Spray => "`",
      :"Dust Whirls" => "`",
      :Sandstorm => "`",
      :"Low Drifting Snow" => "`",
      :"Low Drifting Widespread Dust" => "`",
      :"Low Drifting Sand" => "`",
      :"Blowing Snow" => "`",
      :"Blowing Widespread Dust" => "`",
      :"Blowing Sand" => "`",
      :"Rain Mist" => "`",
      :"Rain Showers" => "`",
      :"Snow Showers" => "`",
      :"Snow Blowing Snow Mist" => "`",
      :"Ice Pellet Showers" => "`",
      :"Hail Showers" => "`",
      :"Small Hail Showers" => "`",
      :Thunderstorm => "z",
      :"Thunderstorms and Rain" => "`",
      :"Thunderstorms and Snow" => "`",
      :"Thunderstorms and Ice Pellets" => "`",
      :"Thunderstorms with Hail" => "`",
      :"Thunderstorms with Small Hail" => "`",
      :"Freezing Drizzle" => "`",
      :"Freezing Rain" => "`",
      :"Freezing Fog" => "`",
      :"Patches of Fog" => "`",
      :"Shallow Fog" => "`",
      :"Partial Fog" => "`",
      :Overcast => "`",
      :Clear => "v",
      :"Partly Cloudy" => "`",
      :"Mostly Cloudy" => "`",
      :"Scattered Clouds" => "`",
      :"Small Hail" => "`",
      :Squals => "`",
      :"Funnel Cloud" => "(",
      :"Unknown Precipitation" => "`",
      :Unknown => "`",
    }

    return map[weather]
  end
end
