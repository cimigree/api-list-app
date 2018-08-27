class CategoriesController < ApplicationController
  before_action :category, only: %i[show update destroy]

  def index
    render json: Category.all.order(name: :asc)
  end

  def show
    render json: @category
  end

  def create
    @category = Category.create(category_params)
    if @category.errors.full_messages.empty?
      render json: @category
    else
      not_acceptable(@category)
    end
  end

  def update
    @category.update_attributes(category_params)
    if @category.errors.full_messages.empty?
      render json: @category
    else
      not_acceptable(@category)
    end
  end

  def destroy
    @category.destroy
    if @category.destroy
      render json: @category
    else
      not_acceptable(@category)
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    ).to_unsafe_h.to_snake_keys
  end

  def category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    record_not_found("Category #{params[:id]} not found")
  end
end

