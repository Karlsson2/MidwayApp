# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning database..."
Friendship.destroy_all
User.destroy_all


puts "Creating users..."
user1 = User.create!(first_name: 'John', last_name: 'Doe', email: 'john@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: 'Liverpool Street, London', username: 'jdoe')
user2 = User.create!(first_name: 'Jane', last_name: 'Smith', email: 'jane@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: 'Putney High Street, London', username: 'jsmith')
user3 = User.create!(first_name: 'Sean', last_name: 'Schmitt', email: 'sean@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: 'Pembroke Road, London', username: 'sschmitt')
user4 = User.create!(first_name: 'Will', last_name: 'Handling', email: 'will@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: 'Pembroke Road, London', username: 'whandling')


friendship1 = Friendship.create!(user: user1, friend: user2)
friendship2 = Friendship.create!(user: user3, friend: user1)
