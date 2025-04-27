class StocksController < ApplicationController
  before_action :authenticate_user!
  def index
    @stocks = current_user.stocks
  end

  def show
    # mock data for stock
    file_path = Rails.root.join("lib", "assets", "data.json")
    data = JSON.parse(File.read(file_path))

    # real data fetch for stock
    # data = AvaApi.fetch_records(@stock.code)

    @stock = current_user.stocks.find(params[:id])
    @price = data["Global Quote"]["05. price"]
  end

  def search
    # mock data fetch for stocks
    file_path = Rails.root.join("lib", "assets", "stocks.json")
    response = JSON.parse(File.read(file_path))

    # api search for query keyword
    # response = AvaApi.search(params[:query])

    @results = response["bestMatches"].map { |e| { symbol: e["1. symbol"], name: e["2. name"] } }
  end

  def create
    @stock = current_user.stocks.new(stock_params)
    @stock.save
    redirect_to root_path
  end

  private

  def stock_params
    params.permit(:name, :code, :quantity)
  end
end
