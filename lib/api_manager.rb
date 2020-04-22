class NewsApp::APIManager
      #Stores API endpoint URL in a constant at the top of the class

      BASE_URL = 'http://newsapi.org/v2/top-headlines?'

      def self.getnews(page,pageSize) #uses the NET::HTTP library to send an HTTP request from our program
          puts "MAING A GET NEWS NETWORK REQUEST!!!!!!!!!!!!!!!"
          url = BASE_URL + "country=us&" + API_KEY  + "&page=#{page}" + "&pageSize=#{pageSize}"
          uri = URI.parse(url)
          response = Net::HTTP.get_response(uri) #NET::HTTP is a Ruby library that allows your program or application to send HTTP requests.
          res = JSON.parse(response.body)
          # binding.pry
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
             NewsApp::News.mass_create_from_api(array)
          end
          return array.length > 0
        end


        def self.get_more_news_info(post)
            post.description
            post.author
            post.content
            post.author
            post.title
            post.populate_data(description: description, content:content, title: title, author:author)
        end

        def self.seach_by_query(user_query_search_input,page,pageSize)

        puts "MAING A QUERY NETWORK REQUEST!!!!!!!!!!!!!!!"
        url = BASE_URL + "q=#{user_query_search_input}&" + API_KEY + "&page=#{page}" + "&pageSize=#{pageSize}"
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)
        res = JSON.parse(response.body)
        posts = res["articles"]

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
          NewsApp::News.second_mass_create_from_api(search_array)
        end
end
