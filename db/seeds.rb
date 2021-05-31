# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(
  name: "admin",
  email: "benabcd5779@gmail.com",
  password: "123456",
  phone: "0955123456",
  address: "台中市豐原區",
  is_admin: true,
)

categories = [
  {
    "name": "3C",
    "description": "something",
    "subcategories": [
       "電腦",
       "手機",
       "家電",
       "相機"
    ]
  },
  {
    "name": "美食",
    "description": "something",
    "subcategories": [
       "飲品",
       "零食",
       "泡麵",
       "麵包",
    ]
  }
]


categories.each do |c_data|
  category = Category.create(name: c_data[:name], description: c_data[:description])
  c_data[:subcategories].each do |s_data_name|
    subcategory = Subcategory.create(name: s_data_name, category: category)
  end
end


subcategory = Subcategory.all[4]
PRODUCTS_COUNT = 5

(1..PRODUCTS_COUNT).each do |index|
   product = {
     name: "柳橙汁",
     description: "好喝柳橙汁",
     price: 1000,
     subcategory: subcategory
   }

   Product.create(product)
end