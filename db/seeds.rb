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
customer = Customer.new(:name => 'taka', :email => 'taka@gmail', :password => 'aaaaaa', :is_deleted => "false", :introduce => "週に二回温泉行ってます")
customer.save!
customer = Customer.new(:name => 'mana', :email => 'mana@gmail', :password => 'aaaaaa', :is_deleted => "false", :introduce => "大阪に住んでます")
customer.save!
customer = Customer.new(:name => 'hana', :email => 'hana@gmail', :password => 'aaaaaa', :is_deleted => "false", :introduce => "茨城に住んでます")
customer.save!
customer = Customer.new(:name => 'kana', :email => 'kana@gmail', :password => 'aaaaaa', :is_deleted => "false", :introduce => "温泉最高！！")
customer.save!
customer = Customer.new(:name => 'ken', :email => 'ken@gmail', :password => 'aaaaaa', :is_deleted => "false", :introduce => "名古屋に住んでます")
customer.save!