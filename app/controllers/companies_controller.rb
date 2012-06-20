#coding: utf-8
class CompaniesController < ApplicationController
  before_filter :signed_in_user #перед загрузкой срабатывает функция signed_in_user . Если пользватель не авторизован, то перенаправляет на страницу авторизации
  load_and_authorize_resource #права доступа

  def index #список компаний
    @search = Company.search(params[:search]) #поиск
    @companies = @search.where("user_id=?", current_user).page(params[:page]).per_page(10) #вывод списка компаний для текущего пользоваля. по 10 компаний на странице
  end

  # def show
   
  # end

  def new
  end

  def edit    
  end

  def create # функция добавление новой компании
     @company = current_user.companies.build(params[:company]) #
      if @company.save #если компания сохранена
        flash[:success] = 'Компания была успешно добавлена.' #если успешно, то выводим флеш сообщение
        redirect_to companies_path  #перенаправляем на список компаний
      else #иначе
      render 'new' #обновляем страницу
    end
  end

  def update #функция редактирование компании
    @company = Company.find(params[:id]) #получаем id компании
      if @company.update_attributes(params[:company]) # обновляем данные в базе данных
        flash[:success] = 'Компания была успешно обновлена.' # если успешно, то выводим флеш сообщение
        redirect_to companies_path #перенаправляем на список компаний
      else #иначе
      render 'edit' #обновляем страницу
    end
  end

  def destroy # функция удаления компании
    authorize! :destroy, @user # проверяем права пользователя
    @company.destroy #удаляем компанию
  end

  def updateShow #функция ппросмотра компаний
    @companiesJs = Company.where('id=?', "#{params[:id]}") # делаем выборку из базы данных, где id компании равно полученной переменной
    render :partial => "update_show", :locals => { :companiesJs =>  @companiesJs } #передача параметров
  end

end
