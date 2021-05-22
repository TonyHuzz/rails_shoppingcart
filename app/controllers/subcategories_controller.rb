class SubcategoriesController < ApplicationController
  before_action :get_category, only: [:products]
  before_action :get_subcategory, only: [:products]

  #LIMIT_PRODUCTS_NUMBER = 每頁要呈現的商品數量
  LIMIT_PRODUCTS_NUMBER = 20

  def products
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

    @categories = Category.all

    @products = @subcategory.products

    #設定第一頁為1，最後一頁為商品總數/每頁要呈現的數量
    @first_page = 1
    count = @products.count

    @last_page = ( count / LIMIT_PRODUCTS_NUMBER)
    if ( count % LIMIT_PRODUCTS_NUMBER )
      @last_page = @last_page += 1
    end

    #設定新的@products 代表說陣列中第幾個位置要呈現多少筆資料 > ary[1, 2, 3]  ary(0,2) = 1, 2 代表說從第0個開始顯示2個資料
    @products = @products.offset( (@page - 1) * LIMIT_PRODUCTS_NUMBER).limit(LIMIT_PRODUCTS_NUMBER)
  end

  def get_category
    @category = Category.find_by_id(params[:category_id])
  end

  def get_subcategory
    @subcategory = Subcategory.find_by_id(params[:subcategory_id])
    if(@subcategory.category != @category)                        #防止從網址輸入不相符的類別ID
      redirect_to products_category_path(@category)
    end
  end
end
