class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    @record_delivery = RecordDelivery.new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
  end

  def create
    @record_delivery = RecordDelivery.new(record_params)
    @item = Item.find(params[:item_id])
    if @record_delivery.valid?
      @record_delivery.save
      redirect_to root_path
    else
      render 'orders/index', status: :unprocessable_entity
    end
  end

  private

  def record_params
    params.require(:record_delivery).permit(:postal_code, :prefecture_id, :city, :address, :building,
                                            :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.sell_price,
      card: record_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    return unless current_user.id == @item.user.id || @item.order.present?

    redirect_to root_path
  end
end
