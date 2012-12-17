class User < ActiveRecord::Base
  def config
    return @config || {}
  end
end
