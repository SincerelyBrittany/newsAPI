class NewsApp::APIManager
      #Stores API endpoint URL in a constant at the top of the class

      BASE_URL = 'http://newsapi.org/v2/top-headlines?'

      ARRAY = []
      def self.getnews #uses the NET::HTTP library to send an HTTP request from our program
          # url = BASE_URL + API_KEY
          url = BASE_URL + "country=us&" + API_KEY

          uri = URI.parse(url)
          response = Net::HTTP.get_response(uri) #NET::HTTP is a Ruby library that allows your program or application to send HTTP requests.
          res = JSON.parse(response.body)
          posts = res["articles"] #articles is an array

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


        def self.get_more_news_info(index,post)
            try = ARRAY[index]
            description = try[:description]
            author = try[:author]
            content = try[:content]
            post.populate_data(description: description, content:content, author:author)
        end

        def self.seach_by_query(user_query_search_input)
        #https://newsapi.org/v2/top-headlines?q=corona&apiKey=9a4690dd6f4541548698fc4eff7209ab
        url = BASE_URL + "q=#{user_query_search_input}&" + API_KEY
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)
        res = JSON.parse(response.body)
        posts = res["articles"]
        puts posts
        end


end
