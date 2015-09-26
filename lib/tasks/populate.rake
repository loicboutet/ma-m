task populate: :environment do
  Shop.clear_index!

  data = JSON.parse(File.read("#{Rails.root}/lib/assets/populate.json"))
  data.each do |shop|
    phone_data = shop['phone']
    index = phone_data.index('Tél.')
    phone = String.new
    if not index.nil?
      index += 7
      phone = phone_data[index..index+14]
      phone = phone.gsub('.', '')
      next if phone[0..1] != '02'
    else
      next
    end

    next if not Shop.where(title: shop['title']).empty?

    address = shop['address'].chomp
    address.each_char.with_index do |char, i|
      if (char =~ /[[:digit:]]/) == 0
        address = address[i..-1]
        break
      end
    end
    address.gsub!('CEDEX', '')
    coordinates = Geocoder.coordinates(address)

    if coordinates.nil?
      puts "sleep 5secondes -- address #{address}"
      sleep 5
      coordinates = Geocoder.coordinates(address)
    end

    next if coordinates.nil?

    Shop.create(
                  title: shop['title'].chomp,
                  phone: phone.chomp,
                  address: shop['address'].chomp,
                  job: shop['job'].chomp,
                  email: 'wild_code_school@gmail.com',
                  site: 'wild_code_school.com',
                  facebook: 'wild.code.school',
                  twitter: 'wild.code.school',
                  lat: coordinates.first,
                  lng: coordinates.last,
               )
  end

  user1 = User.new({:email => "user1@toto.com", :password => "tototata", :password_confirmation => "tototata" })
  user1.skip_confirmation!
  user1.save!
  user2 = User.new({:email => "user2@toto.com", :password => "tototata", :password_confirmation => "tototata" })
  user2.skip_confirmation!
  user2.save!
  user3 = User.new({:email => "user3@toto.com", :password => "tototata", :password_confirmation => "tototata" })
  user3.skip_confirmation!
  user3.save!

  shop = Shop.first
  rating1 = Rating.create(shop: shop, like: true, stars: 9, user: user1, quality: 1, service: 2, price: 3)
  rating2 = Rating.create(shop: shop, like: true, stars: 7, user: user2, quality: 4, service: 5, price: 6)
  rating3 = Rating.create(shop: shop, like: false, stars: 3, user: user3, quality: 7, service: 8, price: 9)
  comment1 = Comment.create(shop: shop, comment: 'Coucou trop bien', user: user1)
  comment2 = Comment.create(shop: shop, comment: "J'aime les chats", user: user2)
  comment3 = Comment.create(shop: shop, comment: 'Pas assez de chats !', user: user3)

  File.open("#{Rails.root}/app/assets/images/shop_1_profile_image.jpg") do |f|
    shop.profile_image = f
    shop.save!
  end
end
