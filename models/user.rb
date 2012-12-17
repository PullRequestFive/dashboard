require 'json'

class User < ActiveRecord::Base
  def get_config key
    data = self.load_config

    if data.has_key? key.to_s
      return data[key.to_s]
    elsif data.has_key? key
      return data[key]
    else
      # Default key values
      case key
      when :twitter
        []
      else
        nil
      end
    end
  end

  def load_config
    if self.config
      data = JSON.load(self.config)
    else
      data = {}
    end

    return data
  end

  def set_config key, value
    hash = self.load_config
    hash[key] = value
    self.config = hash.to_json

    return true
  end
end
