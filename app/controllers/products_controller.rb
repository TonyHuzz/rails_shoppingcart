class ProductsController < ApplicationController
  before_action :redirect_to_root_if_not_log_in,except: [:index, :show, :products]
  before_action :prepare_index, only: [:index, :products]
  before_action :get_products, only: [:index, :products]
  before_action :create_pagination, only: [:index, :products]

  #LIMITED_PRODUCTS_NUMBER = 每頁要呈現的商品數量
  LIMITED_PRODUCTS_NUMBER = 20

  def index
  end

  def show
    @product = Product.find_by_id(params[:id])
  end


  def new
    @product = Product.new  #產生一個空的資料欄  跟 Product.create不同

  end

  def create
    image = params[:product][:image]
    if image
      image_url = save_file(image)
    end

    product = Product.create(product_permit.merge({image_url: image_url}))

    flash[:notice] = "建立成功"
    redirect_to action: :new
  end

  def edit
    @product = Product.find_by_id(params[:id])
    if @product.blank?
      redirect_to action: :index
      return
    end
  end

  def update
    product = Product.find(params[:id])

    image = params[:product][:image]
    if image
      image_url = save_file(image)
      product.update(product_permit.merge({image_url: image_url}))
    else
      product.update(product_permit)
    end

    flash[:notice] = "更新成功"
    redirect_to action: :edit
    return
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to action: :index
    return
  end

  def redirect_to_root_if_not_log_in
    if !current_user
      flash[:notice] = "您尚未登入"
      redirect_to root_path
      return
    end
  end

  #允許新增產品時直接抓 new.html 裡面的值當作資料
  def product_permit
    params.require(:product).permit([:name, :description, :price, :subcategory_id])  #return params.permit([:name, :description, :image_url, :price]) return可寫可不寫
  end

  def save_file(newFile)
    dir_url = Rails.root.join('public', 'uploads/products')  #圖片路徑位置

    FileUtils.mkdir_p(dir_url) unless File.directory?(dir_url)  #如果沒有該路徑，用mkdir_p 建立路徑， 如果路徑存在則不須建立

    file_url = dir_url + newFile.original_filename  #file_url = 路徑/檔案名稱

    File.open(file_url, 'w+b') do |file|    #開啟檔案或寫入檔案
      file.write(newFile.read)
    end

    return "/uploads/products/" + newFile.original_filename
  end

  def prepare_index
    create_ad
    get_current_page
    get_all_categories
  end

  def create_ad
    @ad = {
      title: "大型廣告",
      description: "這是廣告",
      action_title: "閱讀更多"
    }
  end

  def get_current_page
    #如果沒有點選第幾頁，網址為127.0.0.1:3000的話，他會顯示成最後一頁而不是第一頁，所以要設定判斷說是不是在第一頁
    if params[:page]
      @page = params[:page].to_i
    else
      @page = 1
    end
  end

  def get_all_categories
    @categories = Category.all
  end

  def get_products
    @products = Product.all
  end

  def create_pagination
    #設定第一頁為1，最後一頁為商品總數/每頁要呈現的數量
    @first_page = 1
    count = @products.count


    @last_page = ( count / LIMITED_PRODUCTS_NUMBER)
    if ( count % LIMITED_PRODUCTS_NUMBER > 0 )
      @last_page += 1
    else if( count = 0)
      @last_page = 1
         end
    end

    #設定新的@products 代表說陣列中第幾個位置要呈現多少筆資料 > ary[1, 2, 3]  ary(0,2) = 1, 2 代表說從第0個開始顯示2個資料
    @products = @products.offset( (@page - 1) * LIMITED_PRODUCTS_NUMBER).limit(LIMITED_PRODUCTS_NUMBER)
  end

end
