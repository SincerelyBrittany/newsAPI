#News is in charge of representing the news

class NewsApp::News

  attr_accessor :title, :author

  @@all = []

  def self.all
    @@all
  end

  def self.mass_create_from_api(newsarray)
    newsarray.each do |article|
      # new(article["author"],article["title"])
      new(article["author"])
    end
  end

  def initialize(author)
    # @source_name
    @author = author
    # @title = title
    # @description
    save

  end

  def save
    @@all << self
  end

end
