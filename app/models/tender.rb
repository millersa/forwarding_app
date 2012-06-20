class Tender < ActiveRecord::Base

	attr_accessible :company_id, :driver_id, :user_id, :status, :price, :form_oplata, :route, :adress_pogruzka, 
	:adress_razgruzki, :gruzotpravitel, :gruzopoluhatel, :date_pogruzki, :vremy_pogruzki, :data_razgruzki, :vremy_razgruzlki,
	:nomer_tender, :forma_oplati2, :way_id, :licoP_id, :licoR_id #перечень атрибутов, которые будут доступны

	validates :company_id, :presence => true #поле обязательно для заполнения
	validates :price, :presence => true
	validates :form_oplata, :presence => true
	validates :route, :presence => true #поле обязательно для заполнения
	validates :adress_pogruzka, :presence => true
	validates :adress_razgruzki, :presence => true
	validates :gruzotpravitel, :presence => true
	validates :date_pogruzki, :presence => true
	validates :data_razgruzki, :presence => true
	validates :nomer_tender, :presence => true
	validates :forma_oplati2, :presence => true #поле обязательно для заполнения
	validates :way_id, :presence => true
	validates :licoP_id, :presence => true
	validates :licoR_id, :presence => true



	belongs_to :driver #создает отношение один-к-одному с моделью driver
	belongs_to :company #создает отношение один-к-одному с моделью company
	belongs_to :user #создает отношение один-к-одному с моделью  user
	belongs_to :way #создает отношение один-к-одному с моделью  way
 
end
