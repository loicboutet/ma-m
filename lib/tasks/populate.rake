task populate: :environment do
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

    Shop.create(
                  title: shop['title'].chomp,
                  phone: phone.chomp,
                  address: shop['address'].chomp,
                  job: shop['job'].chomp,
               )
  end

  if User.count == 0
    u = User.new({:email => "toto@toto.com", :password => "tototata", :password_confirmation => "tototata" })
    u.skip_confirmation!
    u.save!
  end
end
