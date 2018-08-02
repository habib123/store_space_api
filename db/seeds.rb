# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 Store.create( title: 'title', city: 'city', street: 'street', spaces_count: 1)
 Store.create( title: 'title1', city: 'city1', street: 'street1', spaces_count: 2)
 Store.create( title: 'Test', city: 'city2', street: 'street2', spaces_count: 1)
 Space.create( store: 'store', title: 'title', size: 10, price_per_day: 1, price_per_week: 2, price_per_month: 3 )
 Space.create( store: 'store1', title: 'title1', size: 11, price_per_day: 34.90, price_per_week: 115.34, price_per_month: 235.90)
