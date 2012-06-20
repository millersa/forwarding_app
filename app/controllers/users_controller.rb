# coding: utf-8
class UsersController < ApplicationController
  before_filter :signed_in_user #перед загрузкой срабатывает функция signed_in_user . Если пользватель не авторизован, то перенаправляет на страницу авторизации
  load_and_authorize_resource  #права доступа

  def new
  	@title = "Добавление сотрудника"
  	@legend = "Добавление сотрудника"
  	
  end

  # def show
  # 	@title = "Данные сотрудника"
  # end


  def create  
    if @user.save
      flash[:success] = "Сотрудник был успешно добавлен."
      redirect_to users_path
    else
      @title = "Добавление сотрудника"
      render 'new'
  end
end

  def index #Вывод всех сотрудников
  @search = User.search(params[:search])
  	@title = "Список сотрудников"
    @users = @search.order("datework").page(params[:page]).per_page(7)
    respond_to do |format|
    format.html  # index.html.erb
    format.json  { render :json => @users }
   end
  end

  def edit  
  	@title = "Редактирование сотрудника"
  	@legend = "Редактирование карточки сотрудника"
  end

  def destroy #удаление
    flash[:success] = "Сотрудник удален."
  	@user.destroy
  end

def update  #Обновление
    if @user.update_attributes(params[:user])
       flash[:success] = 'Карточка сотрудника была успешно обновлена.'
       redirect_to users_path
    else
       render 'edit'
  end
end

def updateShow
  @usersJs = User.where('id=?', "#{params[:id]}")
  render :partial => "update_show", :locals => { :usersJs =>  @usersJs }
end


end
