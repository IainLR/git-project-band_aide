# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Musician.destroy_all 
#Relationship.destroy_all
Genre.destroy_all

funk = Genre.create(name: "funk")
pop = Genre.create(name: "pop")
rock = Genre.create(name: "rock")
hipp = Genre.create(name: "hip-hop")
indie = Genre.create(name: "indie")
garage_rock = Genre.create(name: "garage rock")
reggae = Genre.create(name: "reggae")
jazz = Genre.create(name: "jazz")
folk = Genre.create(name: "folk")
metal = Genre.create(name: "metal")
tr = Genre.create(name: "trap")
rnb = Genre.create(name: "R&B")
country = Genre.create(name: "country")
electronic = Genre.create(name: "electronic")
# m1 = Musician.create(name: "Chuck" )
# m2 = Musician.create(name: "Doug" )

# rel1 = Relationship.create( follower_id: m1.id, followed_id: m2.id )