# coding: utf-8
class MainController < ApplicationController
	before_filter :signed_in_user
  def index
  	@title = "Главная"
  end
  def new
  	
  end
end
