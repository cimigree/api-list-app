class ItemsController < ApplicationController
  before_action :item, only: %i[show update destroy]

  def index
    Frequency::ResetPurchased.process()
    render json: Item.where(purchased: false).includes(:category).order(name: :asc)
  end

  def items_all
    render json: Item.all.joins(:category).order(name: :asc)
  end

  def show
    render json: @item
  end

  def create
    store_ids = params[:item][:storeIds]
    @item = Item.create(item_params.except("store_ids"))
    @item.store_ids = store_ids
    if @item.errors.full_messages.empty?
      render json: @item
    else
      not_acceptable(@item)
    end
  end

  def update
    unless @item.purchased
      if params[:item][:purchased]
        date_purchased = Date.today()
        item_params[:date_purchased] = date_purchased
      end
    end
    @item.update_attributes(item_params)
    Frequency::CalcNextPurchaseDate.process(@item.id)
    if @item.errors.full_messages.empty?
      render json: @item
    else
      not_acceptable(@item)
    end
  end

  def destroy
    @item.destroy
    if @item.destroy
      render json: @item
    else
      not_acceptable(@item)
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :brandName,
      :quantity,
      :coupon,
      :note,
      :purchased,
      :frequency,
      :categoryId,
      storeIds: [],
    ).to_unsafe_h.to_snake_keys
  end

  def item
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    record_not_found("Item #{params[:id]} not found")
  end
end


# send json as such: {"item":{"name": "Carolines Yogurt","brandName": "Chobani","quantity": "3","coupon": true,"note": "hint of strawberry","purchased": false,"frequency": "weekly","categoryId": 6,"storeIds": [1]}}
