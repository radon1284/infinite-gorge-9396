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