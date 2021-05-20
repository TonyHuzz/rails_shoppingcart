class HomeController < ApplicationController

  #PRODUCTS_COUNT = 商品總數
  #LIMIT_PRODUCTS_NUMBER = 每頁要呈現的商品數量
  PRODUCTS_COUNT = 100
  LIMIT_PRODUCTS_NUMBER = 20


  def index
    @ad = {
      title: "大型廣告",
      des: "這是廣告",
      action_title: "閱讀更多"
    }

    #如果沒有點選第幾頁，網址為127.0.0.1:3000的話，他會顯示成最後一頁而不是第一頁，所以要設定判斷說是不是在第一頁
    if params[:page]
      @page = params[:page].to_i
    else
      @page = 1
    end

    #設定第一頁為1，最後一頁為商品總數/每頁要呈現的數量
    @first_page = 1
    @last_page = ( PRODUCTS_COUNT / LIMIT_PRODUCTS_NUMBER)


    @products = []

    (1..PRODUCTS_COUNT).each do |index|
      product ={
        id: index,
        name: "柳橙汁#{index}",
        des: "好喝柳橙汁",
        image_url: "https://images.pexels.com/photos/96974/pexels-photo-96974.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      }

      @products << product
    end

    #設定新的@products 代表說陣列中第幾個位置要呈現多少筆資料 > ary[1, 2, 3]  ary(0,2) = 1, 2 代表說從第0個開始顯示2個資料
    @products = @products[ (@page - 1) * LIMIT_PRODUCTS_NUMBER, LIMIT_PRODUCTS_NUMBER]
  end

end
