﻿# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Marka.create(:name=>"тентованный")
Marka.create(:name=>"контейнер")
Marka.create(:name=>"микроавтобус")
Marka.create(:name=>"цельнометалл.")
Marka.create(:name=>"рефрижератор")
Marka.create(:name=>"изотермический")
Marka.create(:name=>"бортовой")
Marka.create(:name=>"открытый конт.")
Marka.create(:name=>"пикап")
Marka.create(:name=>"шаланда")
Marka.create(:name=>"негабарит")
Marka.create(:name=>"низкорамный")
Marka.create(:name=>"низкорам. платф.")
Marka.create(:name=>"телескопический")
Marka.create(:name=>"трал")
Marka.create(:name=>"автобус")
Marka.create(:name=>"автовоз")
Marka.create(:name=>"автовышка")
Marka.create(:name=>"автотранспортер")
Marka.create(:name=>"бетоновоз")
Marka.create(:name=>"бензовоз")
Marka.create(:name=>"вездеход")
Marka.create(:name=>"газовоз")
Marka.create(:name=>"зерновоз")
Marka.create(:name=>"коневоз")
Marka.create(:name=>"конт.площадка")
Marka.create(:name=>"кормовоз")
Marka.create(:name=>"кран")
Marka.create(:name=>"лесовоз")
Marka.create(:name=>"манипулятор")
Marka.create(:name=>"муковоз")
Marka.create(:name=>"панелевоз")
Marka.create(:name=>"самосвал")
Marka.create(:name=>"седельный тягач")
Marka.create(:name=>"скотовоз")
Marka.create(:name=>"стекловоз")
Marka.create(:name=>"трубовоз")
Marka.create(:name=>"цементовоз")
Marka.create(:name=>"цистерна")
Marka.create(:name=>"щеповоз")
Marka.create(:name=>"эвакуатор")

Raztentovka.create(:name=>"верхняя")
Raztentovka.create(:name=>"боковая")
Raztentovka.create(:name=>"задняя")
Raztentovka.create(:name=>"с полной растентовкой")
Raztentovka.create(:name=>"с кониками")
Raztentovka.create(:name=>"со снятием поперечных перекладин")
Raztentovka.create(:name=>"со снятием стоек")
Raztentovka.create(:name=>"без ворот")
Raztentovka.create(:name=>"гидроборт")
Raztentovka.create(:name=>"аппарели")
Raztentovka.create(:name=>"с обрешеткой")
Raztentovka.create(:name=>"с бортами")
Raztentovka.create(:name=>"боковая с 2-х сторон")

#District.create(:state_id=>1,:name=>"Hyderabad")
 Role.create(:name=>"sadmin")
 Role.create(:name=>"admin")
 Role.create(:name=>"worker")
 
User.create(:username=>"miller", :remember_token=>"wdg4CwthPxpHWaW4tB7xYA", :password_digest=>"$2a$10$SgSJtIU7FJs8kZktW271QeQTMOJvaJwtKyz5Hcx5DFrkM8daovwea", :roles_mask=>"1")

Way.create(:name=>"Восток")
Way.create(:name=>"Запад")
Way.create(:name=>"Север")
Way.create(:name=>"Юг")
# Grade.create(:mark=> true, :more => "подробнее", :gradable_id => "1", :gradable_type => "Driver")
# Grade.create(:mark=> true, :more => "подробнее", :gradable_id => "1", :gradable_type => "Driver")
# Grade.create(:mark=> false, :more => "подробнее", :gradable_id => "1", :gradable_type => "Driver")
# Grade.create(:mark=> true, :more => "подробнее", :gradable_id => "1", :gradable_type => "Driver")
# Grade.create(:mark=> true, :more => "подробнее", :gradable_id => "2", :gradable_type => "Driver")
# Grade.create(:mark=> false, :more => "подробнее", :gradable_id => "3", :gradable_type => "Driver")