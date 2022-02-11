class Admin::CurrenciesController < ApplicationController
  before_action :set_currency, :only => %w[edit update destroy]

  def index
    @categories = Currency.all
  end

  def new
    @currency = Currency.new
  end

  def create
    @currency = Currency.new(currency_params)

    if @currency.save!
      flash[:notice] = "新增幣別 #{ @currency.name }"
      redirect_to admin_currencies_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @currency.update(currency_params)
      flash[:notice] = "更新幣別 #{ @currency.name }"
      redirect_to admin_currencies_path
    else
      render :edit
    end
  end

  def destroy
    @currency.destroy
    flash[:notice] = "移除幣別 #{ @currency.name }"
    redirect_to admin_currencies_path
  end


  private

  def set_currency
    @currency = Currency.find(params[:id])
  end

  def currency_params
    params.require(:currency).permit(:name)
  end
end
