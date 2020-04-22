class NewsApp::APIManager
      #Stores API endpoint URL in a constant at the top of the class

      BASE_URL = 'http://newsapi.org/v2/top-headlines?'

      def self.getnews(page,pageSize) #uses the NET::HTTP library to send an HTTP request from our program
          # url = BASE_URL + "country=us&" + API_KEY
          url = BASE_URL + "country=us&" + API_KEY  + "&page=#{page}" + "&pageSize=#{pageSize}"
          uri = URI.parse(url)
          response = Net::HTTP.get_response(uri) #NET::HTTP is a Ruby library that allows your program or application to send HTTP requests.
          res = JSON.parse(response.body)
          posts = res["articles"] #articles is an array

          # page = 1
          # per_page = posts.count
          # total = res["totalResults"]
          # last_page = (total.to_f / per_page.to_f).round
          #
          # while page <= last_page
          #   pagination_url = "#{url}" + "&page=#{page}"
          #   uri_pagination = URI.parse(pagination_url)
          #   response_pagination = Net::HTTP.get_response(uri_pagination)
          #   res_pagination = JSON.parse(response_pagination.body)
          #   posts_pagination = res_pagination["articles"]
          #
          #   puts pagination_url
          #   puts "Page: #{page}"
          #   puts ''

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
          NewsApp::News.mass_create_from_api(array)
        end


        def self.get_more_news_info(post)
            post.description
            post.author
            post.content
            post.author
            post.title
            post.populate_data(description: description, content:content, author:author,title: title, author:author)
        end

        def self.seach_by_query(user_query_search_input,page,pageSize)
        url = BASE_URL + "q=#{user_query_search_input}&" + API_KEY + "&page=#{page}" + "&pageSize=#{pageSize}"
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)
        res = JSON.parse(response.body)
        posts = res["articles"]

        # page = 1
        # per_page = posts.count
        # total = res["totalResults"]
        # last_page = (total.to_f / per_page.to_f).round
        #
        # while page <= last_page
        #   pagination_url = "#{url}" + "&page=#{page}"
        #   uri_pagination = URI.parse(pagination_url)
        #   response_pagination = Net::HTTP.get_response(uri_pagination)
        #   res_pagination = JSON.parse(response_pagination.body)
        #   posts_pagination = res_pagination["articles"]
        #
        #   puts pagination_url
        #   puts "Page: #{page}"
        #   puts ''

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
