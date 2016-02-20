namespace :user do
  task :resend_confirmation => :environment do
    users = User.where('confirmation_token IS NOT NULL')
    users.each do |user|
      user.send_confirmation_instructions
    end
  end
end
# Command in terminal
# rake user:resend_confirmation
	
# heroku run rake user:resend_confirmation

# http://bossdash.com/profiles/users/confirmation?confirmation_token=e9gZ9E3s5a3qZSgsUJ_Y