#News is in charge of representing the news

class NewsApp::News

  @@all = []

    def self.all
        @@all
    end

    def self.mass_create_from_api(newsarr)
        newsarr.each do |newshash|
            new(newshash[:title],newshash[:url])
        end
    end

    attr_accessor :title, :url, :description, :author, :content


    def initialize(title, url)
        @title = title
        @url = url
        @description = description
        @author,@content= nil,nil
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

  def more?
       !!@description
  end

  def populate_data(description:, content:, author:)
     self.description = description
     self.content = content
     self.author = author
 end

 def full_details
        puts "Article title : #{title}  url: #{name}"
        puts "description : #{description}"
        puts "content: #{content}"
  end

end
