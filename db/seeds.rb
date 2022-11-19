# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email: 'admin@admin',
   name: 'admin',
   password: 'testtest'
)

# 顧客の情報5人分
customer1 = Customer.new(:name => 'taka', :email => 'taka@gmail', :password => 'aaaaaa', :is_deleted => "false", :introduce => "週に二回温泉行ってます")
customer1.save!
customer2 = Customer.new(:name => 'mana', :email => 'mana@gmail', :password => 'aaaaaa', :is_deleted => "false", :introduce => "大阪に住んでます")
customer2.save!
customer3 = Customer.new(:name => 'hana', :email => 'hana@gmail', :password => 'aaaaaa', :is_deleted => "false", :introduce => "茨城に住んでます")
customer3.save!
customer4 = Customer.new(:name => 'kana', :email => 'kana@gmail', :password => 'aaaaaa', :is_deleted => "false", :introduce => "温泉最高！！")
customer4.save!
customer5 = Customer.new(:name => 'ken', :email => 'ken@gmail', :password => 'aaaaaa', :is_deleted => "false", :introduce => "名古屋に住んでます")
customer5.save!

Post.create!(customer_id: 1, :name =>"三笠の湯", :title =>"最高", :body => "こんなに最高", :ride_area =>1,:score => 1)
Post.create!(customer_id: 1, :name =>"いちの湯", :title =>"最高の思い出", :body => "露天風呂が広くて最高", :ride_area =>12,:score => 1)
Post.create!(customer_id: 1, :name =>"万座温泉", :title =>"もう行かなくていいや", :body => "正直あまり宜しくはなかった。休憩所が無いのがきつかった", :ride_area =>18,:score => -1)
Post.create!(customer_id: 1, :name =>"立花の湯", :title =>"夕日の思い出", :body => "こんなに最高", :ride_area =>3,:score => 1)
Post.create!(customer_id: 1, :name =>"蛍温泉", :title =>"彼女と言ってきたよ", :body => "こんなに最高", :ride_area =>1,:score => 1)


relationship = Relationship.create(:following_id => customer1.id, :follower_id => customer2.id)
relationship = Relationship.create(:following_id => customer2.id, :follower_id => customer3.id)
relationship = Relationship.create(:following_id => customer3.id, :follower_id => customer1.id)
relationship = Relationship.create(:following_id => customer4.id, :follower_id => customer2.id)
relationship = Relationship.create(:following_id => customer3.id, :follower_id => customer5.id)