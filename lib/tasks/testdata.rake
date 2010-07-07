namespace :testdata do
  task :generate => :environment do
    puts "Creating users"
    failed = 0
    100.times do |i|
      u=User.new
      u.name = Faker::Internet.user_name
      u.email = Faker::Internet.email
      u.confirmed = true
      u.openid_url = "http://#{Faker::Internet.domain_name}"
      failed += 1 unless u.save
    end 
    puts "Finished! (#{failed} failed)"
    
    users = User.all
    #users[rand(users.length)]
    
    puts "Creating tags"
    30.times do |i|
      str = Faker::Lorem.words(1)[0].downcase
      if str.length > 3
        puts "Creating #{str}"
        Tag.create(
          :name => str,
          :description => Faker::Lorem.paragraph()
        )
      end
    end
    puts "Finished!"
    
    tags = Tag.all
    
    rand_tag = Proc.new do
      r = []
      rand(6).times do
        r << tags[rand(tags.length)]
      end
      r.uniq
    end
    
    puts "Creating literatures"
    200.times do |i|
      puts "#{i} created" if i.to_i % 100 == 0
      o = Literature.new
      mature = !(rand(3) == 1)
      o.send(:attributes=, {
        :user_id => users[rand(users.length)].id,
        :title => Faker::Lorem.sentence(rand(7)+1),
        :artists_note => Faker::Lorem.sentences(rand(5)+1).join(" "),
        :summary => Faker::Lorem.sentence(rand(8)+10),
        #this is slow as hell, Faker::Lorem.paragraphs requires hundreds of kbs of random data and 
        #it's drawing it from /dev/random instead of /dev/urandom
        #*facepalm*
        :contents => Faker::Lorem.paragraphs(rand(300)+ 1).join("\n\n"),
        :mature => mature,
        :mature_sex => mature ? (rand(2) == 1) : false,
        :mature_violence => mature ? (rand(2) == 1) : false,
        :tags => rand_tag.call(),
      }, false)
      o.save!
    end
    puts "Finished!"
  end
end
  