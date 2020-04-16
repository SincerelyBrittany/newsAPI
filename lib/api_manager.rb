
#API mananger is in charge of going across the internet and getting data
#about the news
#
# class NewsApp::APIManager
#
#   BASE_URL = 'http://newsapi.org/v2/top-headlines?'\
#         'country=us&'\
#
#
#
#   def self.getnews
#     url = BASE_URL + API_KEY
#     res = HTTParty.get(url)
#     NewsApp::News.mass_create_from_api(res["articles"])
#
#     # res = open(url)
#     # response_body = res.read
#     # puts response_body
#       end
#
#   def self.get_more_news_info(x)
#
#         url = x.url
#         res = HTTParty.get(url)
#         binding.pry
#
#   end
#
# end


require 'open-uri' #URI library which helps Ruby to handle URIs.
require 'net/http'
require 'HTTParty'
require 'json'

class APIManager
  #Stores API endpoint URL in a constant at the top of the class
  BASE_URL = 'http://newsapi.org/v2/top-headlines?'\
        'country=us&'\

  

  def self.getnews #uses the NET::HTTP library to send an HTTP request from our program
    url = BASE_URL + API_KEY
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri) #NET::HTTP is a Ruby library that allows your program or application to send HTTP requests.
    res = JSON.parse(response.body)
    puts res
    # res = open(url)
    # response_body = res.read
    # puts response_body
    end

  # def self.get_more_news_info(x)
  #
  #       url = x.url
  #       res = HTTParty.get(url)
  #       binding.pry
  #
  # end

end


programs = APIManager.getnews
puts programs
