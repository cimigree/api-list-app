class StoresController < ApplicationController
  before_action :store, only: %i[show update destroy]

  def index
    render json: Store.all.order(name: :asc)
  end

  def show
    render json: @store
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
    if @candidate.destroy
      render json: @candidate
    else
      not_acceptable(@candidate)
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

