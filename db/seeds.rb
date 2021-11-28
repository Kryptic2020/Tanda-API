# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 if User.count == 0
  User.create(username:"user1",email:"test@gmail.com",password:"123456",password_confirmation:"123456")
  User.create(username:"user2",email:"test2@gmail.com",password:"123456",password_confirmation:"123456")
end
