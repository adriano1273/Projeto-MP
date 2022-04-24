# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#User.create(name: "Teste", email: "Teste@teste", password: "Teste123", is_admin: true)

puts "Cadastrando Generos de musica"
Genre.create(id: 1,name: "Rock")
puts "Cadastrando Generos de musica"
Genre.create(id: 2,name: "MPB")
puts "Cadastrando Generos de musica"
Genre.create(id: 3,name: "Pop")


5.times do |i|
  puts "Cadastrando músicas de Rock #{i+1}"
  Music.create(title: "Rock Song #{i+1}", description: "Rock Song #{i+1} description", genre_id: 1)
end

5.times do |i|
  puts "Cadastrando músicas de MPB #{i+1}"
  Music.create(title: "MPB Song #{i+1}", description: "MPB Song #{i+1} description", genre_id: 2)
end

5.times do |i|
  puts "Cadastrando músicas de Pop #{i+1}"
  Music.create(title: "Pop Song #{i+1}", description: "Pop Song #{i+1} description", genre_id: 3)
end


3.times do |i|
  puts "Cadastrando Usuario #{i+1}"
  User.create(name: "User#{i+1}", email: "user#{i+1}@mail", password: "Teste123", is_admin: false)
end

# cenario 1

Favorite.create(user_id: 1, music_id: 1, value: 1);
Favorite.create(user_id: 1, music_id: 9, value: 1);
Favorite.create(user_id: 1, music_id: 12, value: -1);

Favorite.create(user_id: 2, music_id: 6, value: 1);
Favorite.create(user_id: 2, music_id: 14, value: 1);
Favorite.create(user_id: 2, music_id: 1, value: -1);

Favorite.create(user_id: 3, music_id: 11, value: 1);
Favorite.create(user_id: 3, music_id: 3, value: 1);
Favorite.create(user_id: 3, music_id: 6, value: -1);


#cenário 2
=begin
# quando pedir sugestao por genero tem que retornar todas as de rock menos a rock 5
Favorite.create(user_id: 1, music_id: 1, value: 1);
Favorite.create(user_id: 1, music_id: 5, value: -1);
=end


#cenário 3
=begin
# quando pedir sugestao por interesse tem que retornar Pop song 1,2 e 3
Favorite.create(user_id: 1, music_id: 1, value: 1);
Favorite.create(user_id: 1, music_id: 13, value: -1);

Favorite.create(user_id: 2, music_id: 1, value: 1);
Favorite.create(user_id: 2, music_id: 10, value: 1);
Favorite.create(user_id: 2, music_id: 11, value: 1);
Favorite.create(user_id: 2, music_id: 12, value: 1);
Favorite.create(user_id: 2, music_id: 13, value: 1);
=end



