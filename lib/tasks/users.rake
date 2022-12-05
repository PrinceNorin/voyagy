require 'io/console'

namespace :users do
  desc 'Create test user'
  task create: :environment do
    print 'Name: '
    name = gets.chomp

    print 'Email: '
    email = gets.chomp

    print 'Password: '
    password = STDIN.noecho(&:gets).chomp

    print "\nConfirm password: "
    confirm_password = STDIN.noecho(&:gets).chomp

    if password == confirm_password
      User.create!(name: name, email: email, password: password)
      puts "\nUser created!"
    else
      puts "\nPassword and confirm password does not match"
    end
  end
end
