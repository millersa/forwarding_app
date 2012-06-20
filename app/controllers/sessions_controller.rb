# coding: utf-8
class SessionsController < ApplicationController

  def new #страница авторизации
  	@title = "Авторизация"
  end

  def create #срабатывает при нажатии на кнопку войти
    user = User.find_by_username(params[:session][:username])
    if user && user.authenticate(params[:session][:password]) # если данные введеные  совпадают с данными в БД, то запоминаем пользователя и перенаправляем на главную страницу, иначе перенаправляем на страницу авторизации
      sign_in user
      redirect_to root_path
    else
      flash.now[:error] = 'Неверный логин/пароль.'
      render 'new'
    end
  end

  def destroy # функция выхода пользователя
    sign_out
    redirect_to root_path
  end
end