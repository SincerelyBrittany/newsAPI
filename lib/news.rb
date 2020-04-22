#News is in charge of representing the news

class NewsApp::News

  @@all = []

    def self.all
        @@all
    end

    def self.mass_create_from_api(newsarr)
        newsarr.each do |newshash|
            new(newshash[:title],newshash[:url],newshash[:description],newshash[:content],newshash[:author])
        end
    end

    attr_accessor :title, :url, :description, :author, :content


    def initialize(title, url, description,content, author)
        @title = title
        @url = url
        @description = nil
        @author,@content= author, content
        save
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

  def self.destroy_all
      @@all = []
  end

  def more?
       !!@description
  end

  def populate_data(title:, author:, description:, content:)
     self.title = title
     self.description = description
     self.content = content
     self.author = author
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
