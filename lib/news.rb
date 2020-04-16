#News is in charge of representing the news

class NewsApp::News

  @@all = []

    def self.all
        @@all
    end

    def self.mass_create_from_api(newsarr)
        newsarr.each do |newshash|
            new(newshash["title"])
        end
    end

    attr_accessor :title, :description


    def initialize(title)
        @title = title
        @description= nil
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

  def populate_data(height: , weight: , description: , types:, id:)
    self.description = description
  end

end




#   attr_accessor :title, :author, :description, :source_name, :url
#
#   def self.mass_create_from_api(newsarray)
#     newsarray.each do |article|
#       # new(article["author"],article["title"])
#       new(article["title"],article["source"]["name"])
#     end
#   end
#
#
#   @@all = []
#
#   def self.all
#     @@all
#   end
#
#   def initialize(title, url)
#     @source_name, @description, @author = nil, nil, nil
#     @url = url
#     @title = title
#     # @description
#     save
#
#   def need_more_news?
#     !!@description
#   end
#
#   end
#
#   # def to_s
#   #     self.name
#   # end
#   #
#   # def name
#   #     @name.capitalize
#   # end
#
#   def to_s
#     #what if the author is nil
#     # puts author
#     if title.nil? || title.empty?
#       return "No Title"
#     end
#     title.capitalize
#       # author.capitalize
#     # if !valid?(author)
#     #   puts "ummm that doesnt make sense"
#     #   return
#     # end
#     # return author.capitalize
#   end
#
#   # def valid?(i)
#   #   if author.nil? || author.empty?
#   #   # i.to_i.between?(1, newsApp::News.all.length)
#   # end
#
#   def save
#     @@all << self
#   end
#
# end
