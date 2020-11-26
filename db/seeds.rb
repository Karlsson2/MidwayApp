# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning database..."
MidwayParticipant.destroy_all
Midway.destroy_all
Friendship.destroy_all
User.destroy_all


puts "Creating users..."

userphoto1 = URI.open('https://images.pexels.com/photos/1484794/pexels-photo-1484794.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500')
user1 = User.create!(first_name: 'John', last_name: 'Knight', email: 'john@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '130 Liverpool Road, London', username: 'jknight')
user1.photo.attach(io: userphoto1, filename: 'user1.png',content_type: 'image/png')

userphoto2 = URI.open('https://images.pexels.com/photos/1389994/pexels-photo-1389994.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user2 = User.create!(first_name: 'Jane', last_name: 'Smith', email: 'jane@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '166 Putney High Street, London', username: 'jsmith')
user2.photo.attach(io: userphoto2, filename: 'user2.png',content_type: 'image/png')

userphoto3 = URI.open('https://images.pexels.com/photos/2078265/pexels-photo-2078265.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user3 = User.create!(first_name: 'Nicolas', last_name: 'Schmitt', email: 'nicolas@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '66 Pembroke Road, London', username: 'nschmitt')
user3.photo.attach(io: userphoto3, filename: 'user3.png',content_type: 'image/png')

userphoto4 = URI.open('https://images.pexels.com/photos/1071812/pexels-photo-1071812.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user4 = User.create!(first_name: 'Will', last_name: 'Handling', email: 'will@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '26 George Street, London', username: 'whandling')
user4.photo.attach(io: userphoto4, filename: 'user4.png',content_type: 'image/png')

userphoto5 = URI.open('https://images.pexels.com/photos/937453/pexels-photo-937453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user5 = User.create!(first_name: 'Ines', last_name: 'Rivera', email: 'ines@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '9142 Mill Road, London', username: 'irivera')
user5.photo.attach(io: userphoto5, filename: 'user5.png',content_type: 'image/png')

userphoto6 = URI.open('https://images.pexels.com/photos/1771383/pexels-photo-1771383.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user6 = User.create!(first_name: 'Lesley', last_name: 'Lopez', email: 'lesley@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '171 Queen Street, London', username: 'llopez')
user6.photo.attach(io: userphoto6, filename: 'user6.png',content_type: 'image/png')

userphoto7 = URI.open('https://images.pexels.com/photos/3970083/pexels-photo-3970083.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user7 = User.create!(first_name: 'Lloyd', last_name: 'Key', email: 'lloyd@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '641 Victoria Road, London', username: 'lkey')
user7.photo.attach(io: userphoto7, filename: 'user7.png',content_type: 'image/png')

userphoto8 = URI.open('https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260')
user8 = User.create!(first_name: 'Mitch', last_name: 'Jones', email: 'mitch@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '52 The Grove, London', username: 'mjones')
user8.photo.attach(io: userphoto8, filename: 'user8.png',content_type: 'image/png')

userphoto9 = URI.open('https://images.pexels.com/photos/2709388/pexels-photo-2709388.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user9 = User.create!(first_name: 'Savannah', last_name: 'Walters', email: 'savannah@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '69 Grange Road, London', username: 'swalters')
user9.photo.attach(io: userphoto9, filename: 'user9.png',content_type: 'image/png')

userphoto10 = URI.open('https://images.pexels.com/photos/1133742/pexels-photo-1133742.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500')
user10 = User.create!(first_name: 'Chloe', last_name: 'Thornton', email: 'chloe@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '84 Chester Road, London', username: 'cthornton')
user10.photo.attach(io: userphoto10, filename: 'user10.png',content_type: 'image/png')

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



30.times do
  users = [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10]
  mcreator = users.sample
  m = Midway.create!( midpoint: "51.509865,-0.118092", venue: "5acb4fe9851de554affcffb5" , user: mcreator)
  MidwayParticipant.create!( midway:m ,user:mcreator )
  users.delete(mcreator)
  3.times do
    u = users.sample
    MidwayParticipant.create!( midway: m, user: u )
    users.delete(u)
  end
end
