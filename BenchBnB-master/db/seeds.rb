# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do
  variancelat = rand(0..0.03) * 2 - 0.03
  variancelng = rand(0..0.03) * 2 - 0.03
  lat_coordinate = 37.7758 + variancelat
  lng_coordinate = -122.435 + variancelng

  seating = rand(1..10)

  Bench.create!(description: Faker::Lorem.sentence,
               lat: lat_coordinate,
               lng: lng_coordinate,
               seating: seating
               )
end
