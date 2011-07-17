namespace :retain do
  desc "Make a user an admin"
  task :promote, [:user_name] => :environment do |t, args|
    user = User.find_by_name(args.user_name)
    if user
      user.update_attribute('is_admin', true)
      puts "User #{args.user_name} is now an admin"
    else
      puts "User #{args.user_name} not found"
    end
  end

  desc "Removes a user from the admin list"
  task :demote, [:user_name] => :environment do |t, args|
    user = User.find_by_name(args.user_name)
    if user
      user.update_attribute('is_admin', false)
      puts "User #{args.user_name} is no longer an admin"
    else
      puts "User #{args.user_name} not found"
    end
  end
  
  desc "Removes a user from the admin list"
  task :admins => :environment do |t, args|
    User.find_each do |user|
      puts "#{user.name} #{"(admin)" if user.is_admin}"
    end
  end
  

end