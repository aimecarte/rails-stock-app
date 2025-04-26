class StocksController < ApplicationController
  before_action :authenticate_user!
  def index
    # if params[:symbol]
    # file_path = Rails.root.join("lib", "assets", "data.json")
    # data = JSON.parse(File.read(file_path))
    # response = AvaApi.fetch_records(params[:symbol])
    # @symbol = data["Global Quote"]["01. symbol"]
    # @stock_price = data["Global Quote"]["05. price"]

    @stocks = current_user.stocks
    # end
  end

  def search
    # response = AvaApi.search(params[:query])
    file_path = Rails.root.join("lib", "assets", "stocks.json")
    response = JSON.parse(File.read(file_path))
    @results = response["bestMatches"].map { |e| { symbol: e["1. symbol"], name: e["2. name"] } }
  end

  def create
    @stock = current_user.stocks.new(stock_params)
    binding.b
    @stock.save
    redirect_to root_path
  end

  private

  def stock_params
    params.permit(:name, :code, :quantity)
  end
end
