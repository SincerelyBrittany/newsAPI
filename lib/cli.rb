#In charge of presenting things/strings and getting input from my user
#
class NewsApp::CLI

  def initialize
       @page = 1
       @count = 1
       @pageSize = 20
       @user_query_search_input = nil
       @from_search = nil
  end

  def start
    introduction
    get_news_data
    main_menu
  end

  def introduction
    puts "\n\n\n\n\n\n"
    puts "--------------------------------------------------------------------------------------------------------"
    puts "----------------------------------- Welcome To The News App!--------------------------------------------"
    puts "--------------------------------------------------------------------------------------------------------"
    sleep(2)
    puts "\n"
  end

  def main_menu
    puts "Type ‘1’ to view the Top U.S. Stories"
    puts "Type ‘2’ to Search for a story in the U.S."
    puts "Type ‘exit’ to exit program"
    puts "Type 'credits' for credits"
    user_input = gets.strip.downcase
    menu_input(user_input)
  end


  def menu_input(user_input)
    if user_input == "1"
      @from_search = false
      news_options_loop
    elsif user_input == "2"
      @from_search = true
      get_query_input
      query_selection
      news_options_loop
    elsif user_input == "exit" #MUST GET TO WORK
      puts "Thank you come again!"
      return
    else
      puts "Invalid Response, Please Try Again"
      main_menu
    end
  end

  def instuctions
    puts
    puts "----- Type 'next' see more and 'prev' to return to previous page ------"
    puts
    puts "------ Pick a number to view more information on an article -----------"
    puts
    puts "---------------- Type 'return' to return to main menu -----------------"
    puts
    puts "------------------------ Type 'exit' to exit --------------------------"
  end

  def get_news_data
      if !NewsApp::APIManager.getnews(@page,@pageSize)
        puts "There is no page #{@page} -- returning to page #{@page - 1}"
        sleep(1)
        @page -= 1
      end
  end

  def get_query_input
    puts "Please type what you would like to search"
    @user_query_search_input = gets.chomp.downcase
  end

  def query_selection
      if !NewsApp::APIManager.seach_by_query(@user_query_search_input, @page, @pageSize)
        puts "There is no page #{@page} -- returning to page #{@page - 1}"
        sleep(1)
        @page -= 1
      end
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
                NewsApp::News.destroy_all
                @page = 1
                @count = 1
                @from_search = nil
                main_menu
                return
            when "next"
                if @from_search == false
                  @page += 1
                  start, stop = get_page_range
                  if NewsApp::News.all.length <= start
                      get_news_data
                  end
                else @from_search == true
                  @page += 1
                  start, stop = get_page_range
                  if NewsApp::News.search_array.length <= start
                      @count += 1
                      query_selection
                  end
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
      if @from_search == false
      start, stop = get_page_range
      a = NewsApp::News.all[start...stop][i]
      puts a.full_details
      puts
      puts 'Press any key to go back'
      gets
    else @from_search == true
      start, stop = get_page_range
      b = NewsApp::News.search_array[start...stop][i]
      puts b.full_details
      puts
      puts 'Press any key to go back'
      gets
    end
  end

  def get_article_choice
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
      if @from_search == false
      i.to_i.between?(1, NewsApp::News.all.length)
      else @from_search == true
      i.to_i.between?(1, NewsApp::News.search_array.length)
      end
    end

    def second_menu
      display_articles
      instuctions
    end

    def get_page_range

      [(@page - 1) * @pageSize, @page * @pageSize]

    end

    def display_articles
        if @from_search == true
        start, stop = get_page_range
        puts "\n\nPAGE #{@page} of your search for #{@user_query_search_input.capitalize}"
          NewsApp::News.search_array[start...stop].each.with_index do |p,i|
            puts "#{i+1}. #{p}"
          end
        else @from_search == false
          start, stop = get_page_range
          puts "\n\nPAGE #{@page}"
          NewsApp::News.all[start...stop].each.with_index do |p,i|
          puts "#{i+1}. #{p}"
          end
      end
    end

end
