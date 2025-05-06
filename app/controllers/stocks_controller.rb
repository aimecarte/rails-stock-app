class StocksController < ApplicationController
  before_action :authenticate_user!
  def index
    @stocks = current_user.stocks
  end

  def show
    # mock data for stock
    # file_path = Rails.root.join("lib", "assets", "data.json")
    # data = JSON.parse(File.read(file_path))

    @stock = current_user.stocks.find(params[:id])

    # real data fetch for stock
    data = AvaApi.fetch_records(@stock.code)

    @price = data["Global Quote"]["05. price"]
  end

  def search
    # mock data fetch for stocks
    file_path = Rails.root.join("lib", "assets", "stocks.json")
    response = JSON.parse(File.read(file_path))

    # api search for query keyword
    # response = AvaApi.search(params[:query])

    @results = response["bestMatches"].map { |e| { symbol: e["1. symbol"], name: e["2. name"] } }

    @user_stocks = []
    @stocks = []

    user_stock_symbols = current_user.stocks.pluck(:code)

    @results.each do |stock|
      if user_stock_symbols.include?(stock[:symbol])
        existing_stock = current_user.stocks.find_by(code: stock[:symbol])
        @user_stocks << existing_stock if existing_stock
      else
        @stocks << stock
      end
    end
  end

  def new
    @stock = current_user.stocks.new(
      name: params[:name],
      code: params[:code]
    )
  end

  def create
    @stock = current_user.stocks.new(stock_params)
    @stock.save
    # mock data for stock
    file_path = Rails.root.join("lib", "assets", "data.json")
    data = JSON.parse(File.read(file_path))
    @price = data["Global Quote"]["05. price"]

    # real data fetch for stock
    # @price = AvaApi.get_price(@stock.code)
    quantity = params[:stock][:quantity].to_i

    current_user.transactions.create!(
      transaction_type: "Buy",
      code: @stock.code,
      quantity: quantity,
      current_price: @price,
      total: quantity.to_i * @price.to_f
    )
    redirect_to root_path
  end

  def buy
    @stock = current_user.stocks.find(params[:id])
    @stock.quantity += params[:quantity].to_i
    @stock.save

    # mock data for stock
    file_path = Rails.root.join("lib", "assets", "data.json")
    data = JSON.parse(File.read(file_path))
    @price = data["Global Quote"]["05. price"]

    # real data fetch for stock
    # @price = AvaApi.get_price(@stock.code)

    current_user.transactions.create!(
      transaction_type: "Buy",
      code: @stock.code,
      quantity: params[:quantity],
      current_price: @price,
      total: params[:quantity].to_i * @price.to_f
    )
    redirect_to root_path
  end

  def sell
    @stock = current_user.stocks.find(params[:id])
    @stock.quantity -= params[:quantity].to_f
    @stock.save

    # mock data for stock
    file_path = Rails.root.join("lib", "assets", "data.json")
    data = JSON.parse(File.read(file_path))
    @price = data["Global Quote"]["05. price"]

    # real data fetch for stock
    # @price = AvaApi.get_price(@stock.code)

    current_user.transactions.create!(
      transaction_type: "Sell",
      code: @stock.code,
      quantity: params[:quantity],
      current_price: @price,
      total: params[:quantity].to_i * @price.to_f
    )
    redirect_to root_path
  end

  private

  def stock_params
    params.require(:stock).permit(:name, :code, :quantity)
  end
end
