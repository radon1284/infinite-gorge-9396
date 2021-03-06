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

# http://bossdash.com/profiles/users/confirmation?confirmation_token=1zMFzZbs3tEnU17umg9o