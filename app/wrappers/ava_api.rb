require "uri"
require "net/http"

class AvaApi
  def self.fetch_records(symbol)
    url = URI("https://alpha-vantage.p.rapidapi.com/query?function=GLOBAL_QUOTE&symbol=#{symbol}&datatype=json")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = ENV["API_KEY"]
    request["x-rapidapi-host"] = "alpha-vantage.p.rapidapi.com"

    response = http.request(request)
    JSON.parse(response.body)
  end

  def self.search(keyword)
    url = URI("https://alpha-vantage.p.rapidapi.com/query?datatype=json&keywords=#{keyword}&function=SYMBOL_SEARCH")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = ENV["API_KEY"]
    request["x-rapidapi-host"] = "alpha-vantage.p.rapidapi.com"

    response = http.request(request)
    JSON.parse(response.body)
  end

  def self.get_price(symbol)
    data = self.fetch_records(symbol)
    data["Global Quote"]["05. price"]
  end
end
