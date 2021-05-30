class OrdersController < ApplicationController
  before_action :redirect_to_root_if_not_log_in
  before_action :get_order, only: [:show, :update, :destroy]
  # before_action :verify_auth


  def index
    # 顯示一個使用者(User)底下的所有訂單
  end

  def show
    # 顯示一個訂單
  end

  def create
    # 建立一個訂單，狀態是還沒付款

    @order = Order.not_paid.create(
      user: current_user,
      # user_name: current_user.name,
      # user_address: current_user.address,
      # user_phone: current_user.phone
    )

    current_user.buy_now_cart_items.each do |cart_item|

      begin
        OrderItem.create(
          order: @order,
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product_price
        )
      rescue
        @order.order_items.destroy_all
        @order.destroy

        flash[:notice] = "訂單建立失敗"
        redirect_to root_path
        return
      end

    end

    current_user.buy_now_cart_items.destroy_all

    flash[:notice] = "建立訂單成功"
    redirect_to payments_path
    return
  end

  def update
    # 更新一個訂單，狀態是已付款
  end

  def destroy
    # 訂單不會被刪除，所以是更新一個訂單，狀態是已取消
  end

  private

  def redirect_to_root_if_not_log_in
    if !current_user
      flash[:notice] = "您尚未登入"
      redirect_to root_path
      return
    end
  end

  def get_order
    @order = Order.find_by_id(params[:id])
    if !@order
      flash[:notice] = "沒有這個訂單"
      redirect_to root_path
      return
    end
  end

  # def verify_auth
  #   if @order
  #     unless  current_user.is_admin? || ( current_user == @order.user)
  #       flash[:notice] = "你沒有權限"
  #       redirect_to root_path
  #       return
  #     end
  #   end
  # end
end
