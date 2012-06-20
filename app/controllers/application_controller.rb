# coding:utf-8 кодировка
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  rescue_from CanCan::AccessDenied do |exception| #права доступа для пользователей
  	flash[:error] = "Доступ закрыт!" # выводит сообщение
    redirect_back_or root_path #возращается назад или на главную страницу, если доступ закрыт
  end
end
