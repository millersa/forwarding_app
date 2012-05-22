# coding:utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  rescue_from CanCan::AccessDenied do |exception|
  	flash[:error] = "Доступ закрыт!"
    redirect_back_or root_path
  end
end
