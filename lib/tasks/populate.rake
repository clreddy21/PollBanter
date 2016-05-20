namespace :create_admin do

  task build: :environment do
            puts "Creating Admin ...."

            admin = Admin.new({:name => "Jay", :email => "admin@pollbanter.com", :is_active => true, 
              :password => "pollpoll1", :password_confirmation => "pollpoll1", slug: "Jay"}).save(:validate => false)
                   
            puts "Admin created Successfully.......................!"
 end
end