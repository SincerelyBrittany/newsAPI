#News is in charge of representing the news

class NewsApp::News

  @@all = []
  @@search_array = []

    def self.all
        @@all
    end

    def self.search_array
        @@search_array
    end

    def self.mass_create_from_api(newsarr, from_search: false)
        newsarr.each do |newshash|
            new(newshash[:title],newshash[:url],newshash[:description],newshash[:content],newshash[:author], from_search: from_search)
        end
    end

    attr_accessor :title, :url, :description, :author, :content

    def initialize(title, url, description,content, author, from_search:)
        @title = title
        @url = url
        @description = nil
        @author,@content= author, content
        if from_search == true
          save_to_search
        else from_search == false
          save
        end
    end

    def to_s
       self.name
   end

   def name
       @title.capitalize
   end

  def save
      @@all << self
  end

  def save_to_search
      @@search_array << self
  end

  def self.destroy_all
      @@search_array = []
  end

  def more?
       !!@description
  end

 def full_details

        <<-DESC
        TITLE: #{title}

        DESCRIPTION: #{description}

        CONTENT: #{content}

        URL TO ARTICLE : #{url}
       DESC

  end

end
