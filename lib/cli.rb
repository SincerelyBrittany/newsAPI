#In charge of presenting things/strings and getting input from my user

class NewsApp::CLI

  def start
    introduction
    get_news_data
    news_options_loop
  end

  def introduction
    puts "\n\n\n\n\n\n"
    puts "Welcome to the latest news App!"
    sleep(2)
    puts "\n"
  end

  def instuctions
    puts "Please choose an article by number or type exit"
  end

  def get_news_data
      NewsApp::APIManager.getnews
  end

  def news_options_loop
    loop do
      menu
      input = get_article_choice
      break if input == "exit"
      next if input == "invalid"
      display_article(input)
  end
end

    def display_article(i)
      a = NewsApp::News.all[i]
      NewsApp::APIManager.get_more_news_info(a) if !a.more? #located in NewsApp.rb
      puts "Title: #{a.title}"
      puts "URL: #{a.url}"
      puts "press any key to continue"
      gets
    end

    def get_article_choice
      input = gets.strip.downcase
      return input if input == "exit"
      # return input.downcase if commands.include?(input.downcase)
      if !valid?(input)
        puts "umm... that doesn't make sense"
        return "invalid"
      end
      return input.to_i - 1
    end

    def valid?(i)
      i.to_i.between?(1, NewsApp::News.all.length)
    end

    def menu
      display_articles
      instuctions
    end

    def display_articles
      # start, stop = get_page_range
      #  puts "\n\nPAGE #{@page}"
      # NewsApp::News.all[start...stop].each.with_index do |p,i|
        NewsApp::News.all.each.with_index do |p,i|
      puts "#{i+1}. #{p}"
    end
  end

    # def get_page_range
    #     [(@page - 1) * @limit, @page * @limit]
    # end
end


    #
    #     break if input == "exit"
    #     next if input == "invalid"
    #     display_article(input)
    #   end
    # end
    #
    # def display_article(i)
    #   a = NewsApp::news.all[i]
    #   puts a
    #   puts a.article
    #   puts a.title
    #   puts "press any key to continue"
    #   gets
    # end
    #
    # def get_article_choice
    #   input = gets.strip_downcase
    #   return input if input == exit
    #   if !valid?(input)
    #     puts "ummm that doesnt make sense"
    #     return invalid
    #   end
    #   return input.to_i -1
    # end
    #
    # def valid?(i)
    #   i.to_i.between?(1, newsApp::News.all.length)
    # end
    #
    # def menu
    #   display_articles
    #   instuctions
    # end
    #
    # def display_articles
    #   NewsApp::News.all.each.with_index do |p,i|
    #   puts "#{i+1}. #{p}"
    # end
    # end
    #
    #
    # def news_options_loop
    #   loop do
    #       menu
    #       input = get_article_choice
    #       case input
    #       when "exit"
    #         break
    #       when "invalid"
    #         puts "this is invalid"
    #           # @page +=1
    #           # _, stop = get_page_range
    #           if newsApp::news.all.length < stop
    #               get_news_data
    #           end
    #       # when "prev"
    #       #     if @page <= 1
    #       #       puts "You can not get to that page, you are already on page 1"
    #       #     else
    #       #       @page -= 1
    #       #     end
    #       else
    #         display_article(input)
    #         binding.pry
    #       end
    #     end
    #   end
