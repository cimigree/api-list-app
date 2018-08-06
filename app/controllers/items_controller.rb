class ItemsController < ApplicationController
  before_action :item, only: %i[show update destroy]

  def index
    render json: Item.all.order(category: :asc)
  end

  def show
    render json: @item
  end

  def create
    @item = Item.create(item_params)
    if @item.errors.full_messages.empty?
      render json: @item
    else
      not_acceptable(@item)
    end
  end

  def update
    @item.update_attributes(item_params)
    if @item.errors.full_messages.empty?
      render json: @item
    else
      not_acceptable(@item)
    end
  end

  def destroy
    @item.destroy
    if @candidate.destroy
      render json: @candidate
    else
      not_acceptable(@candidate)
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :brand_name,
      :quantity,
      :coupon,
      :note,
      :purchased,
      :frequency,
      :stores,
      :categoryId
    ).to_unsafe_h.to_snake_keys
  end

  def item
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    record_not_found("Item #{params[:id]} not found")
  end
end
