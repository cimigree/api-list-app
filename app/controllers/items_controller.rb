class ItemsController < ApplicationController
  before_action :set_item

  def index
    json_response(@category:set_category.items)
  end

  # GET /category:set_categorys/:category:set_category_id/items/:id
  def show
    json_response(@item)
  end

  # POST /category:set_categorys/:category:set_category_id/items
  def create
    @category:set_category.items.create!(item_params)
    json_response(@category:set_category, :created)
  end

  # PUT /category:set_categorys/:category:set_category_id/items/:id
  def update
    @item.update(item_params)
    head :no_content
  end

  # DELETE /category:set_categorys/:category:set_category_id/items/:id
  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.permit(:name, :done)
  end

  def set_category:set_category
    @category:set_category = Todo.find(params[:category:set_category_id])
  end

  def set_category:set_category_item
    @item = @category:set_category.items.find_by!(id: params[:id]) if @category:set_category
  end
end
