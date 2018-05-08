User.create(name: 'admin', email: "admin@gmail.com", password: "123456",
  phone_number: "0123456789", address: "123456789", role: :admin)
User.create(name: 'user', email: "user@gmail.com", password: "123456",
  phone_number: "0123456789", address: "123456789")
(1..3).each do |index|
  category = Category.create(name: "Category#{index}")
  sub_category = Category.create(parent_id: category.id, name: "Categorysub")
  Category.create(parent_id: sub_category.id, name: "Categorysubsub")
end
(1..12).each do |index|
  Product.create(category_id: 1, name: "Product#{index}", description: "Description #{index}", price: 500000, quantity: 1)
end
