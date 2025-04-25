class StocksController < ApplicationController
  def index
    if params[:symbol]
      response = AvaApi.fetch_records(params[:symbol])
      @symbol = response["Global Quote"]["01. symbol"]
      @stock_price = response["Global Quote"]["05. price"]
    end
  end

  def search
    response = AvaApi.search(params[:query])
    @results = response["bestMatches"].map { |e| { symbol: e["1. symbol"], name: e["2. name"] } }
  end

  def create; end
end
