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

userphoto1 = URI.open('https://images.pexels.com/photos/2078265/pexels-photo-2078265.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user1 = User.create!(first_name: 'John', last_name: 'Knight', email: 'john@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '130 Liverpool Road, London', username: 'jknight')
user1.photo.attach(io: userphoto1, filename: 'user1.png',content_type: 'image/png')

userphoto2 = URI.open('https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-733872.jpg&fm=jpg')
user2 = User.create!(first_name: 'Jane', last_name: 'Smith', email: 'jane@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '166 Putney High Street, London', username: 'jsmith')
user2.photo.attach(io: userphoto2, filename: 'user2.png',content_type: 'image/png')

user3 = User.create!(first_name: 'Nicolas', last_name: 'Schmitt', email: 'nicolas@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '66 Pembroke Road, London', username: 'nschmitt')

user4 = User.create!(first_name: 'Will', last_name: 'Handling', email: 'will@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '26 George Street, London', username: 'whandling')

user5 = User.create!(first_name: 'Ines', last_name: 'Rivera', email: 'ines@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '9142 Mill Road, London', username: 'irivera')

user6 = User.create!(first_name: 'Lesley', last_name: 'Lopez', email: 'lesley@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '171 Queen Street, London', username: 'llopez')

user7 = User.create!(first_name: 'Lloyd', last_name: 'Key', email: 'lloyd@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '641 Victoria Road, London', username: 'lkey')

user8 = User.create!(first_name: 'Mitch', last_name: 'Jones', email: 'mitch@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '52 The Grove, London', username: 'mjones')

user9 = User.create!(first_name: 'Savannah', last_name: 'Walters', email: 'savannah@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '69 Grange Road, London', username: 'swalters')

user10 = User.create!(first_name: 'Chloe', last_name: 'Thornton', email: 'chloe@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '84 Chester Road, London', username: 'cthornton')

friendship1 = Friendship.create!(user: user1, friend: user2)
friendship2 = Friendship.create!(user: user3, friend: user1)
friendship3 = Friendship.create!(user: user3, friend: user6)
friendship4 = Friendship.create!(user: user5, friend: user10)
friendship5 = Friendship.create!(user: user9, friend: user8)
friendship6 = Friendship.create!(user: user6, friend: user2)
friendship7 = Friendship.create!(user: user10, friend: user7)
friendship8 = Friendship.create!(user: user5, friend: user4)
friendship9 = Friendship.create!(user: user4, friend: user9)
friendship10 = Friendship.create!(user: user8, friend: user7)
