# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning database..."
Venue.destroy_all
MidwayParticipant.destroy_all
Midway.destroy_all
Friendship.destroy_all
User.destroy_all


puts "Creating users..."

userphoto1 = URI.open('https://images.pexels.com/photos/1484794/pexels-photo-1484794.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500')
user1 = User.create!(first_name: 'John', last_name: 'Knight', email: 'john@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '12 Duncan Terrace, N1 8BZ, London UK', username: 'jknight')
user1.photo.attach(io: userphoto1, filename: 'user1.png',content_type: 'image/png')

userphoto2 = URI.open('https://images.pexels.com/photos/1389994/pexels-photo-1389994.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user2 = User.create!(first_name: 'Jane', last_name: 'Smith', email: 'jane@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '166 Putney High Street, SW15 1RS, London UK', username: 'jsmith')
user2.photo.attach(io: userphoto2, filename: 'user2.png',content_type: 'image/png')

userphoto3 = URI.open('https://images.pexels.com/photos/2078265/pexels-photo-2078265.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user3 = User.create!(first_name: 'Nick', last_name: 'Schmitt', email: 'nicolas@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '66 Pembroke Road, London UK', username: 'nschmitt')
user3.photo.attach(io: userphoto3, filename: 'user3.png',content_type: 'image/png')

userphoto4 = URI.open('https://images.pexels.com/photos/1071812/pexels-photo-1071812.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user4 = User.create!(first_name: 'Will', last_name: 'Handling', email: 'will@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '26 George Street, London UK', username: 'whandling')
user4.photo.attach(io: userphoto4, filename: 'user4.png',content_type: 'image/png')

userphoto5 = URI.open('https://images.pexels.com/photos/937453/pexels-photo-937453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user5 = User.create!(first_name: 'Alice', last_name: 'Rivera', email: 'alice@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '27 Niton St, SW6 6NH, London UK', username: 'arivera')
user5.photo.attach(io: userphoto5, filename: 'user5.png',content_type: 'image/png')

userphoto6 = URI.open('https://images.pexels.com/photos/1771383/pexels-photo-1771383.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user6 = User.create!(first_name: 'Jana', last_name: 'Lopez', email: 'juan@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '171 Queen Street, London UK', username: 'jlopez')
user6.photo.attach(io: userphoto6, filename: 'user6.png',content_type: 'image/png')

userphoto7 = URI.open('https://images.pexels.com/photos/3970083/pexels-photo-3970083.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user7 = User.create!(first_name: 'Lloyd', last_name: 'Key', email: 'lloyd@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '84 Angell Rd, SW9 7HP, London UK', username: 'lkey')
user7.photo.attach(io: userphoto7, filename: 'user7.png',content_type: 'image/png')

userphoto8 = URI.open('https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260')
user8 = User.create!(first_name: 'Mitch', last_name: 'Jones', email: 'mitch@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '52 The Grove, London UK', username: 'mjones')
user8.photo.attach(io: userphoto8, filename: 'user8.png',content_type: 'image/png')

userphoto9 = URI.open('https://images.pexels.com/photos/2709388/pexels-photo-2709388.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940')
user9 = User.create!(first_name: 'Sarah', last_name: 'Walters', email: 'sarah@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '73 Greatdown Rd, W7 1JR, London UK', username: 'swalters')
user9.photo.attach(io: userphoto9, filename: 'user9.png',content_type: 'image/png')

userphoto10 = URI.open('https://images.pexels.com/photos/1212984/pexels-photo-1212984.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260')
user10 = User.create!(first_name: 'Harry', last_name: 'Williams', email: 'harry@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '13 Narbonne Ave, SW4 9JR', username: 'hwilliams')
user10.photo.attach(io: userphoto10, filename: 'user10.png',content_type: 'image/png')

userphoto11 = URI.open('https://images.pexels.com/photos/936119/pexels-photo-936119.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500')
user11 = User.create!(first_name: 'Jean', last_name: 'Blanc', email: 'jean@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '34 Litchfield Avenue, SM4 5QS London UK', username: 'jblanc')
user11.photo.attach(io: userphoto11, filename: 'user11.png',content_type: 'image/png')

userphoto12 = URI.open('https://images.pexels.com/photos/1042140/pexels-photo-1042140.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500')
user12 = User.create!(first_name: 'Rahul', last_name: 'Shah', email: 'rahul@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '84 Ockendon Road, N1 3NW, London UK', username: 'dpatel')
user12.photo.attach(io: userphoto12, filename: 'user12.png',content_type: 'image/png')

userphoto13 = URI.open('https://images.pexels.com/photos/2701660/pexels-photo-2701660.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500')
user13 = User.create!(first_name: 'Kat', last_name: 'Randall', email: 'kat@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '34 Finsen Rd, SE5 9AX, London UK', username: 'krandall')
user13.photo.attach(io: userphoto13, filename: 'user13.png',content_type: 'image/png')

userphoto14 = URI.open('https://images.pexels.com/photos/3680316/pexels-photo-3680316.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500')
user14 = User.create!(first_name: 'Joy', last_name: 'Brown', email: 'joy@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '30 Barrington Rd, SW9 7JE, London UK', username: 'jbrown')
user14.photo.attach(io: userphoto14, filename: 'user14.png',content_type: 'image/png')

userphoto15 = URI.open('https://images.pexels.com/photos/5225308/pexels-photo-5225308.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500')
user15 = User.create!(first_name: 'Sam', last_name: 'Park', email: 'sam@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '6 Hayles St, SE11 4SS, London UK', username: 'spark')
user15.photo.attach(io: userphoto15, filename: 'user15.png',content_type: 'image/png')

userphoto16 = URI.open('https://images.pexels.com/photos/3747147/pexels-photo-3747147.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500')
user16 = User.create!(first_name: 'Will', last_name: 'Peters', email: 'willp@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '106 Cloudesley Rd, N1 0EB, London UK', username: 'wpeters')
user16.photo.attach(io: userphoto16, filename: 'user16.png',content_type: 'image/png')

userphoto17 = URI.open('https://images.pexels.com/photos/1462630/pexels-photo-1462630.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500')
user17 = User.create!(first_name: 'Niamh', last_name: 'Cox', email: 'niamh@gmail.com', password: 'topsecret', password_confirmation: 'topsecret', location: '4 Laurel Rd, SW13 0EE', username: 'ncox')
user17.photo.attach(io: userphoto17, filename: 'user17.png',content_type: 'image/png')

friendship1 = Friendship.create!(user: user1, friend: user2)
friendship2 = Friendship.create!(user: user3, friend: user1)
friendship3 = Friendship.create!(user: user3, friend: user6)
friendship4 = Friendship.create!(user: user5, friend: user10)
friendship5 = Friendship.create!(user: user9, friend: user8)
friendship6 = Friendship.create!(user: user6, friend: user2)
friendship7 = Friendship.create!(user: user10, friend: user7, confirmed: true)
friendship8 = Friendship.create!(user: user5, friend: user4)
friendship9 = Friendship.create!(user: user4, friend: user9)
friendship10 = Friendship.create!(user: user8, friend: user7)
friendship11 = Friendship.create!(user: user10, friend: user9, confirmed: true)
friendship12 = Friendship.create!(user: user10, friend: user3, confirmed: true)
friendship12 = Friendship.create!(user: user10, friend: user1, confirmed: true)
friendship12 = Friendship.create!(user: user10, friend: user2, confirmed: true)
friendship13 = Friendship.create!(user: user10, friend: user6, confirmed: true)

venue1 = Venue.create!(name: "Spring", address: "Lancaster Pl, London WC2R 1LA", photo_url: "https://lh5.googleusercontent.com/p/AF1QipPHXnPGDClY5RY8PXXq4xpOSN6hBPqPo6jR97wB=w203-h152-k-no", lat:"51.509865",lng:"-0.118092")
venue2 = Venue.create!(name: "The Golden Chippy", address: "62 Greenwich High Rd, Greenwich, London SE10 8LF", photo_url: "https://static.standard.co.uk/s3fs-public/thumbnails/image/2016/11/21/14/thegoldenchippy.jpg?w968")
venue3 = Venue.create!(name: "The Dog and Fox", address: "24 High Street Wimbledon", photo_url: "https://static.designmynight.com/uploads/2016/04/Dog-Fox-5-optimised.jpg")
venue4 = Venue.create!(name: "Nandos", address: "1-5 Bond St, Ealing, London W5 5AP", photo_url: "https://media-cdn.tripadvisor.com/media/photo-s/0f/ff/4e/c0/nando-s-ealing-chicken.jpg")
venues = []
venues.push(venue1)
venues.push(venue2)
venues.push(venue3)
venues.push(venue4)

dates = ["Thu, 01 Dec 2020 12:44:00 UTC +00:00", "Wed, 25 Nov 2020 09:35:00 UTC +00:00", "Mon 23 Nov 2020 15:45:00 UTC +00:00", "Thu, 15 Oct 2020 18:10:00 UTC +00:00"]

i = 0
4.times do
  creators = [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10]
  mcreator = user10
  # users wil be an array of the users friends
  users = []


  friends_array = mcreator.friends

  friends_array.each do |friend|
    # Since user can be under either friend or user ID, check which id is holding the creators ID
    if friend.user_id == mcreator.id
      users << User.find(friend.friend_id)
    else
      users << User.find(friend.user_id)
    end
  end

  m = Midway.new( midpoint: "51.509865,-0.118092", user: mcreator)

  m.venue = venues[i]
  m.future_datetime = dates.sample
  m.save!
  i +=1
  MidwayParticipant.create!( midway:m ,user:mcreator )

  candidate_users = []
  users.each do |user|
    candidate_users.push(user) unless user.id == 7 || user.id == 5
  end
  selected_users = candidate_users.sample(rand(1..4))

  selected_users.each do |user|
    MidwayParticipant.create!( midway: m, user: user )
  end

end
