# coding: utf-8
class UsersController < ApplicationController
  before_filter :signed_in_user
load_and_authorize_resource

  def new
  	@title = "Добавление сотрудника"
  	@legend = "Добавление сотрудника"
  	
  end

  def show
  	@title = "Данные сотрудника"
    
  end


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

  	@title = "Список сотрудников"
    @users = User.order("datework").page(params[:page]).per_page(7)
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
 
  	respond_to do |format|
    format.html { redirect_to users_url }
    format.json { head :no_content }
  end
  end

def update  #Обновление
 
 
  #respond_to do |format|
    if @user.update_attributes(params[:user])
       flash[:success] = 'Карточка сотрудника была успешно обновлена.'
       redirect_to users_path
       
      #format.html  { redirect_to(@user,
        #            :notice => 'Карточка сотрудника была успешно обновлена.') }
      #format.json  { head :no_content }
    else
       render 'edit'
      #format.html  { render :action => "edit" }
      #format.json  { render :json => @user.errors,
         #           :status => :unprocessable_entity }
   # end
  end
end

def updateShow
  @usersJs = User.where('id=?', "#{params[:id]}")
  render :partial => "update_show", :locals => { :usersJs =>  @usersJs }
end


end
