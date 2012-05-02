# coding: utf-8
class UsersController < ApplicationController
  before_filter :signed_in_user

  def new
  	@title = "Добавление сотрудника"
  	@legend = "Добавление сотрудника"
  	@user = User.new
  end

  def show
  	@title = "Данные сотрудника"
    @user = User.find(params[:id])
  end


  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Сотрудник был успешно добавлен."
      redirect_to @user
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
  	@user = User.find(params[:id])	
  end

  def destroy #удаление
  	@user = User.find(params[:id])
    flash[:success] = "Сотрудник удален."
  	@user.destroy
 
  	respond_to do |format|
    format.html { redirect_to users_url }
    format.json { head :no_content }
  end
  end

def update  #Обновление
  @user = User.find(params[:id])
 
  #respond_to do |format|
    if @user.update_attributes(params[:user])
       flash[:success] = 'Карточка сотрудника была успешно обновлена.'
       redirect_to @user
       
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

end
