 #coding: utf-8
class DriversController < ApplicationController

  before_filter :signed_in_user #перед загрузкой срабатывает функция signed_in_user . Если пользватель не авторизован, то перенаправляет на страницу авторизации
  load_and_authorize_resource  #права доступа
 
  def index #список водителей
    @search = Driver.search(params[:search])
    @drivers =  @search.page(params[:page]).per_page(7)
    @markaSpisok = Marka.order('id ASC').all
    @raztentovka_checkbox = Raztentovka.order('id ASC').all
    @title = 'Список водителей' #заголовок страницы
  end

  # def show
  #   @title = 'Просмотр водителя'

  # end

  def new
  
  end


  def edit
    @marka_select = Marka.order('id ASC').all # выборка из БД всех марок
    @raztentovka_checkbox = Raztentovka.order('id ASC').all    # выборка из БД всех растентовок
    @title = 'Редактирование водителя' #заголовок страницы
  end

  def create # функция добавление нового водителя
      if @driver.save # Сохраняем водителя
        flash[:success] = 'Водитель был успешно добавлен.'
        redirect_to drivers_path  #перенаправляем на список водителей
      else
       render 'new' #обновляем страницу
    end
  end

  def update  #функция редактирование водителя  
      if @driver.update_attributes(params[:driver])
        flash[:success] = 'Водитель был успешно обновлен.'
        redirect_to drivers_path  #перенаправляем на список водителей
      else
       render 'edit' #обновляем страницу
    end
  end

  def destroy # функция удаления водителя
    authorize! :destroy, @user # проверяем права пользователя
    @driver.destroy # удаляем
  end

def updateShow # функция просмотра выбранного водителя
  @driversJs = Driver.where('id=?', "#{params[:id]}") # выборка с БД где id водителя равно id палученного
  render :partial => "update_show", :locals => { :driversJs =>  @driversJs }  #Это отрендерит файл _update_show.html.erb с переменными  @driversJs
end 
end
 
def updateDialog # функция добавлеие отзыва
  @driverJs = Driver.where('id=?', "#{params[:dialod_id]}").first
  render :partial => "update_dialog", :locals => { :driverJs =>  @driverJs }
end

# def updateGrade # функция показа отзывов
#   @gradesJs = Driver.where('id=?', "#{params[:dial_id]}").first
#   render :partial => "grades_show", :locals => { :gradesJs =>  @gradesJs } #Это отрендерит файл _grades_show.html.erb с переменными  @gradesJs
# end 

end
