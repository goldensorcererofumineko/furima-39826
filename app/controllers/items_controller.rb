class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update]
  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    
  end

  def edit
    unless @item.user_id == current_user.id
      redirect_to action: :index
    end
  end

  def update
    if  @item.update(item_params)
    redirect_to item_path(@item.id)
    else
    render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.user == current_user  
    tem.destroy
    redirect_to root_path
    else
    redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name,:item_price,:image,:item_info,:item_category_id,:item_sales_status_id,:item_shipping_fee_status_id,:item_scheduled_delivery_id,:prefecture_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
