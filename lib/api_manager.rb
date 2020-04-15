
#API mananger is in charge of going across the internet and getting data
#about the news

class NewsApp::APIManager

  BASE_URL = 'http://newsapi.org/v2/top-headlines?'\
        'country=us&'\

    API_KEY = 'apiKey=9a4690dd6f4541548698fc4eff7209ab'

  def self.getnews
    url = BASE_URL + API_KEY
    res = HTTParty.get(url)
    NewsApp::News.mass_create_from_api(res["articles"])

    # req = open(url)
    # response_body = req.read
    # puts response_body
  end

end
