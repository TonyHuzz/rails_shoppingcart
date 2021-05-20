class ProductsController < ApplicationController

  #LIMIT_PRODUCTS_NUMBER = 每頁要呈現的商品數量
  LIMIT_PRODUCTS_NUMBER = 20

  def index
    @ad = {
      title: "大型廣告",
      description: "這是廣告",
      action_title: "閱讀更多"
    }

    #如果沒有點選第幾頁，網址為127.0.0.1:3000的話，他會顯示成最後一頁而不是第一頁，所以要設定判斷說是不是在第一頁
    if params[:page]
      @page = params[:page].to_i
    else
      @page = 1
    end

    @products = Product.all

    #設定第一頁為1，最後一頁為商品總數/每頁要呈現的數量
    @first_page = 1
    @last_page = ( @products.count / LIMIT_PRODUCTS_NUMBER)

    #設定新的@products 代表說陣列中第幾個位置要呈現多少筆資料 > ary[1, 2, 3]  ary(0,2) = 1, 2 代表說從第0個開始顯示2個資料
    @products = @products.offset( (@page - 1) * LIMIT_PRODUCTS_NUMBER).limit(LIMIT_PRODUCTS_NUMBER)

  end

end
