#In charge of presenting things/strings and getting input from my user

class NewsApp::CLI


  def initialize
       @page = 1
       @pageSize = 5
   end

  def start
    introduction
    get_news_data
    main_menu
  end

  def introduction
    puts "\n\n\n\n\n\n"
    puts "The TOP US News Stories"
    sleep(2)
    puts "\n"
  end

  def main_menu
    puts "Type ‘1’ to view the Top U.S. Stories"
    puts "Type ‘2’ to Search for a story"
    puts "Type ‘exit’ to exit program"
    user_input = gets.strip.downcase
    menu_input(user_input)

  end

  def menu_input(user_input)
    if user_input == "1"
      news_options_loop
    elsif user_input == "2"
      puts "This is option 2"
      query_selection
    elsif user_input == "exit" #MUST GET TO WORK
      puts "Thank you come again!"
      return
      else
      puts "Invalid Response, Please Try Again"
      main_menu
    end
  end

  def instuctions
    puts "Pick a number to select more information on an article"
    puts
    puts "Type 'return' to return to main menu"
    puts
    puts "Type 'exit' to exit"
  end

  def get_news_data
      NewsApp::APIManager.getnews(@page, @pageSize)
  end

  def news_options_loop
    loop do
            second_menu
            input = get_article_choice
            case input
            when "exit"
                break
            when "invalid"
                next
            when "return" # if return make input == user_input
                main_menu
                return
            when "next"
                @page += 1
                _, stop = get_page_range
                if NewsApp::News.all.length < stop
                    get_news_data
                end
            when "prev"
                if @page <= 1
                    puts "You cannot get that page, you are alredy on page 1!"
                else
                    @page -= 1
                end
            else
                display_article(input)
            end
        end
      end

    def display_article(i)
      a = NewsApp::News.all[i]
      b = i- 1
      NewsApp::APIManager.get_more_news_info(i, a) if !a.more? #located in NewsApp.rb
      puts a.full_details
      puts 'Press any key to go back'
      gets
    end

    def get_article_choice ## MUST ADD RETURN TO MAIN MENU
      input = gets.strip.downcase
      commands = ["exit","return","next", "prev"]
      return input.downcase if commands.include?(input.downcase)
      if !valid?(input)
        puts "Invalid Response, Please Try Again"
        sleep(3)
        return "invalid"
      end
        return input.to_i - 1
    end

    def valid?(i)
      i.to_i.between?(1, NewsApp::News.all.length)
    end

    def second_menu
      display_articles
      instuctions
    end

    def query_selection
      puts "Please type what you would like to search"
      user_query_search_input = gets.chomp.downcase
      NewsApp::APIManager.seach_by_query(user_query_search_input)
    end

    def display_articles
      start, stop = get_page_range
        puts "\n\nPAGE #{@page}"
        NewsApp::News.all[start...stop].each.with_index do |p,i|
        # NewsApp::News.all.each.with_index do |p,i|
        puts "#{i+1}. #{p}"
      end
    end

    def get_page_range
      [(@page - 1) * @pageSize, @page * @pageSize]
    end

end
