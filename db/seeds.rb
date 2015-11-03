# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
	first_name: "Rowan",
	last_name: "Puppy",
	email: "rowan@woof.com",
	password: "password"
	)
User.create(
	first_name: "Max",
	last_name: "Ono",
	email: "mono@example.com",
	password: "password"
	)