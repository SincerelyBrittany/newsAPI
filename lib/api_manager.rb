class NewsApp::APIManager
      #Stores API endpoint URL in a constant at the top of the class
      BASE_URL = 'http://newsapi.org/v2/top-headlines?'\
        'country=us&'\

      ARRAY = []
      def self.getnews #uses the NET::HTTP library to send an HTTP request from our program
          # articles_array = []
          url = BASE_URL + API_KEY
          uri = URI.parse(url)
          response = Net::HTTP.get_response(uri) #NET::HTTP is a Ruby library that allows your program or application to send HTTP requests.
          res = JSON.parse(response.body)
          posts = res["articles"] #articles is an array
          # binding.pry

          posts.each do |post|
            new_hash = {
              title: post["title"],
              url: post["url"],
              author: post["author"],
              description: post["description"],
              content: post["content"]
            }
            ARRAY << new_hash
            end
            NewsApp::News.mass_create_from_api(ARRAY)
        end


        def self.get_more_news_info(x)
            ARRAY.each do |x|
              if x == x
                NewsApp::News.populate_data(x)
                NewsApp::News.full_details
              end
            end
        end

end


# NewsApp::News.populate_data(description: description)




#_________________________________________________

#
# class NewsApp::APIManager
#       #Stores API endpoint URL in a constant at the top of the class
#       BASE_URL = 'http://newsapi.org/v2/top-headlines?'\
#         'country=us&'\
#
#       def self.getnews #uses the NET::HTTP library to send an HTTP request from our program
#           articles_array = []
#           url = BASE_URL + API_KEY
#           uri = URI.parse(url)
#           response = Net::HTTP.get_response(uri) #NET::HTTP is a Ruby library that allows your program or application to send HTTP requests.
#           res = JSON.parse(response.body)
#           posts = res["articles"] #articles is an array
#           # binding.pry
#
#           posts.each do |post|
#             new_hash = {
#               title: post["title"],
#               url: post["url"],
#               author: post["author"],
#               description: post["description"],
#               content: post["content"]
#
#             }
#             articles_array << new_hash
#             end
#             NewsApp::News.mass_create_from_api(articles_array)
#         end
#
#         end
#
#

 #end of class

#   articles_array << new_hash
#   end #End of each do
# #   NewsApp::News.mass_create_from_api(articles_array)
# end #End of getnews
# NewsApp::APIManager.getnews







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
