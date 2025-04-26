class StocksController < ApplicationController
  def index
      # if params[:symbol]
      file_path = Rails.root.join("lib", "assets", "data.json")
      data = JSON.parse(File.read(file_path))
      # response = AvaApi.fetch_records(params[:symbol])
      @symbol = data["Global Quote"]["01. symbol"]
      @stock_price = data["Global Quote"]["05. price"]
    # end
  end

  def search
    response = AvaApi.search(params[:query])
    @results = response["bestMatches"].map { |e| { symbol: e["1. symbol"], name: e["2. name"] } }
  end

  def create
  end
end
