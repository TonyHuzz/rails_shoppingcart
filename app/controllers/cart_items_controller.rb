class CartItemsController < ApplicationController
  before_action :redirect_to_root_if_not_log_in
  before_action :get_cart, except: [:index]
  before_action :get_cart_item, only: [:update, :destroy]


  def index
    @buy_now_items = current_user.buy_now_cart_items
    @buy_next_time_items = current_user.buy_next_time_cart_items
  end

  def create
    product = Product.find_by_id(params[:product_id])

    if !product
      flash[:notice] = "沒有這個商品"
      redirect_to root_path
      return
    end

    CartItem.create(product: product, quantity: 1, cart: @cart )

    if @cart.buy_now?
      flash[:notice] = "加入購物車成功"
    elsif @cart.buy_next_time?
      flash[:notice] = "加入下次購買成功"
    end

    redirect_to product_path(product)
  end

  def update
    # @cart_item
  end

  def destroy
    @cart_item.destory

    redirect_to :index
  end

  private

  def redirect_to_root_if_not_log_in
    if !current_user
      flash[:notice] = "您尚未登入"
      redirect_to root_path
      return
    end
  end

  def get_cart
    @cart = current_user.carts.find_by(cart_type: params[:cart_type])   #params[:cart_type] = (cart_type: :buy_now) or  (cart_type: :buy_next_time)

    if !@cart
      flash[:notice] = "沒有找到目標購物車"
      redirect_to :index
      return
    end
  end

  def get_cart_item
      @cart_item = @cart.cart_items.find_by_id(params[:id])

    if !@cart_item
      flash[:notice] = "沒有找到目標購物車商品"
      redirect_to :index
      return
    end
  end

end
