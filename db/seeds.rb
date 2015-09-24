# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# ['Admin', 'Manager', 'Team Leader', 'Client', 'Staff'].each do |role|
#   Role.find_or_create_by({name: role})
# end

# [:admin, :manager, :team_leader, :client, :staff].each do |role|
#   Role.find_or_create_by({ name: role })
# end
Staff.create(
:full_name => 'Ruel Nopal 1', 
:position => 'Web Develper', 
:user_attributes => {
  :email => 'radon1@radongrafix.com', 
  :password => 'qazx1234'
  }
)
Staff.create(
:full_name => 'Ruel Nopal 2', 
:position => 'Web Develper', 
:user_attributes => {
  :email => 'radon2@radongrafix.com', 
  :password => 'qazx1234'
  }
)
Staff.create(
:full_name => 'Ruel Nopal 3', 
:position => 'Web Develper', 
:user_attributes => {
  :email => 'radon3@radongrafix.com', 
  :password => 'qazx1234'
  }
)
Staff.create(
:full_name => 'Ruel Nopal 4', 
:position => 'Web Develper', 
:user_attributes => {
  :email => 'radon4@radongrafix.com', 
  :password => 'qazx1234'
  }
)
Staff.create(
:full_name => 'Ruel Nopal 5', 
:position => 'Web Develper', 
:user_attributes => {
  :email => 'radon5@radongrafix.com', 
  :password => 'qazx1234'
  }
)
Staff.create(
:full_name => 'Ruel Nopal 6', 
:position => 'Web Develper', 
:user_attributes => {
  :email => 'radon6@radongrafix.com', 
  :password => 'qazx1234'
  }
)
Staff.create(
:full_name => 'Ruel Nopal 7', 
:position => 'Web Develper', 
:user_attributes => {
  :email => 'radon7@radongrafix.com', 
  :password => 'qazx1234'
  }
)

Staff.create(
:full_name => 'Ruel Nopal', 
:position => 'Web Develper', 
:user_attributes => {
  :email => 'radon@radongrafix.com', 
  :password => 'qazx1234'
  }
)

Client.create(
:full_name => 'Monty Hooke', 
:business_name => 'MontFox', 
:user_attributes => {
  :email => 'monty@montyghooke.com', 
  :password => 'qazx1234'
  }
)
Client.create(
:full_name => 'Monty Hooke 1', 
:business_name => 'MontFox', 
:user_attributes => {
  :email => 'monty1@montyghooke.com', 
  :password => 'qazx1234'
  }
)
Client.create(
:full_name => 'Monty Hooke 2', 
:business_name => 'MontFox', 
:user_attributes => {
  :email => 'monty2@montyghooke.com', 
  :password => 'qazx1234'
  }
)
Client.create(
:full_name => 'Monty Hooke 3', 
:business_name => 'MontFox', 
:user_attributes => {
  :email => 'monty3@montyghooke.com', 
  :password => 'qazx1234'
  }
)
Client.create(
:full_name => 'Monty Hooke 4', 
:business_name => 'MontFox', 
:user_attributes => {
  :email => 'monty4@montyghooke.com', 
  :password => 'qazx1234'
  }
)
Client.create(
:full_name => 'Monty Hooke 5', 
:business_name => 'MontFox', 
:user_attributes => {
  :email => 'monty5@montyghooke.com', 
  :password => 'qazx1234'
  }
)