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
    count = @products.count

    @last_page = ( count / LIMIT_PRODUCTS_NUMBER)
    if ( count % LIMIT_PRODUCTS_NUMBER )
      @last_page = @last_page += 1
    end

    #設定新的@products 代表說陣列中第幾個位置要呈現多少筆資料 > ary[1, 2, 3]  ary(0,2) = 1, 2 代表說從第0個開始顯示2個資料
    @products = @products.offset( (@page - 1) * LIMIT_PRODUCTS_NUMBER).limit(LIMIT_PRODUCTS_NUMBER)
  end


  def new
    @product = Product.new  #產生一個空的資料欄  跟 Product.create不同

    @note = flash[:note]
  end

  def create
    product = Product.create(product_permit)
    flash[:note] = product.id
    redirect_to action: :new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    product = Product.find(params[:id])
    product.update(product_permit)

    redirect_to action: :edit
  end

  #允許新增產品時直接抓 new.html 裡面的值當作資料
  def product_permit
    params.require(:product).permit([:name, :description, :image_url, :price])  #return params.permit([:name, :description, :image_url, :price]) return可寫可不寫
  end

end
