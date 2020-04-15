require_relative "./newsApp/version"
# require 'open-uri'
require 'HTTParty'

require_relative "./cli"
require_relative "./api_manager"
require_relative "./news"

module NewsApp
  class Error < StandardError; end
  # Your code goes here...
end
