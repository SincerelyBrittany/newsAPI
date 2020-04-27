class NewsApp::APIManager
      #Stores API endpoint URL in a constant at the top of the class

      BASE_URL = 'http://newsapi.org/v2/'

      def self.getnews(page,pageSize) #uses the NET::HTTP library to send an HTTP request from our program
          url = BASE_URL + "top-headlines?country=us&" + API_KEY  + "&page=#{page}" + "&pageSize=#{pageSize}"
          uri = URI.parse(url)
          response = Net::HTTP.get_response(uri) #NET::HTTP is a Ruby library that allows your program or application to send HTTP requests.
          res = JSON.parse(response.body)
          posts = res["articles"] #articles is an array

          array =[]
          posts.each do |post|
            new_hash = {
              title: post["title"],
              url: post["url"],
              author: post["author"],
              description: post["description"],
              content: post["content"]
            }
            array << new_hash
          end
          if array.length > 0
             NewsApp::News.mass_create_from_api(array, from_search: false)
          end
          return array.length > 0
        end

        def self.seach_by_query(user_query_search_input,page,pageSize)

        url = BASE_URL + "everything?qInTitle=#{user_query_search_input}&sortBy=popularity&language=en&" + API_KEY + "&page=#{page}" + "&pageSize=#{pageSize}"
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)
        res = JSON.parse(response.body)
        posts = res["articles"]

        return false if posts == nil

        search_array = []
        posts.each do |post|
          hash = {
            title: post["title"],
            url: post["url"],
            author: post["author"],
            description: post["description"],
            content: post["content"]
          }
          search_array << hash
          end
          if search_array.length > 0
          NewsApp::News.mass_create_from_api(search_array, from_search: true)
          end
          return search_array.length > 0
        end
end
