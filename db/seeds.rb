# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

exapmle_user = User.create(
  name: 'Example User',
  email: 'example@example.com',
  target_weight: 65.0,
  password: 'password',
  password_confirmation: 'password'
)

exapmle_user.weights.create([
  { date: '2014-05-01', weight: 67.0 },
  { date: '2014-05-02', weight: 67.2 },
  { date: '2014-05-03', weight: 67.5 },
  { date: '2014-05-04', weight: 66.2 },
  { date: '2014-05-05', weight: 68.0 },
  { date: '2014-05-06', weight: 67.0 },
  { date: '2014-05-07', weight: 66.5 },
  { date: '2014-05-08', weight: 66.5 }
])
