#In charge of presenting things/strings and getting input from my user

class NewsApp::CLI

  def start
    puts "Welcome to the Latest News App"
    get_news_data
    menu
  end

  def get_news_data
    NewsApp::APIManager.getnews
  end

  def menu
    puts "Type ‘1’ to view list of top stories"
    puts "Type ‘2’ to search for top 3 stories"
    puts "Type ‘exit’ to exit program"
    user_input = gets.chomp
    menu_input(user_input)
  end


    def list_news_articles
      NewsApp::News.all.each.with_index do |p,i|
        puts "#{i+1} #{p}"
      end
    end


  def menu_input(user_input)
    if user_input == "1"
      list_news_articles
      menu
    elsif user_input == "2"
      # Pet.create_pet
      # puts "Pet Created"
      menu
    elsif user_input.downcase == "exit"
      puts "Goodbye!"
    else
      puts "Invalid Response, Please Try Again"
      menu
    end
  end
end



  # def start
  #   introduction
  #   news_options
  # end
  #
  # def news_options
  #   loop do
  #       menu
  #       input = get_user_input
  #       break if input == "exit"
  #       display_article(input)
  #     end
  #   end
  #
  #   def introduction
  #     puts "Welcome to the latest news App!"
  #   end
  #
  #   def menu
  #     display_articles
  #     display instructions
  #
  #   end
  #
  #   def instuctions
  #     puts "Please display "
  #   end
