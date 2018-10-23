# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.destroy_all

Reply.destroy_all

Friendship.destroy_all

Collect.destroy_all

User.destroy_all

User.create(email: "admin@example.com", password: "12345678", role: "Admin")
puts "Default Admin have created"

Category.destroy_all

category_list = [
  { name: "文創" },
  { name: "商業" },
  { name: "運動" },
  { name: "心理" },
  { name: "科技" }
]

category_list.each do |category|
  Category.create(name: category[:name])
end

puts "Category created!"



