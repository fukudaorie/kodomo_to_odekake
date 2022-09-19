# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tag.create([
  { name: '屋外施設' },
  { name: '屋内施設' },
  { name: '飲食店' },
  { name: '託児サービス' },
  { name: '授乳室' },
  { name: 'おむつ交換台' },
  { name: 'キッズスペース' },
  { name: '離乳食持ち込み可' },
  { name: '子供椅子有り' }
])

Admin.create(
    email: "kanrisya@example.com",
    password: "kanrisya"
    )
