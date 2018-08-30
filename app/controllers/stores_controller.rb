class StoresController < ApplicationController
  before_action :store, only: %i[show all_items update destroy]

  def index
    render json: Store.all.order(name: :asc)
  end

  def show
    store_with_items = @store.items.select{|i| i.purchased == false }
    if store_with_items.length == 0
      render json: @store.items
    else
      render json: store_with_items
    end
  end

  def all_items
    render json: @store.items
  end

  def create
    @store = Store.create(store_params)
    if @store.errors.full_messages.empty?
      render json: @store
    else
      not_acceptable(@store)
    end
  end

  def update
    @store.update_attributes(store_params)
    if @store.errors.full_messages.empty?
      render json: @store
    else
      not_acceptable(@store)
    end
  end

  def destroy
    @store.destroy
    if @store.destroy
      render json: @store
    else
      not_acceptable(@store)
    end
  end

  private

  def store_params
    params.require(:store).permit(
      :name
    ).to_unsafe_h.to_snake_keys
  end

  def store
    @store = Store.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    record_not_found("Store #{params[:id]} not found")
  end
end

