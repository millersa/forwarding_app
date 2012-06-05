 #coding: utf-8
class DriversController < ApplicationController

  before_filter :signed_in_user
  load_and_authorize_resource
 
  def index
    @search = Driver.search(params[:search])
    #@products = @search.all
    @drivers =  @search.page(params[:page]).per_page(7)
    @markaSpisok = Marka.order('id ASC').all
    @raztentovka_checkbox = Raztentovka.order('id ASC').all
    @title = 'Список водителей'
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @drivers }
    end
  end

  # GET /drivers/1
  # GET /drivers/1.json
  # def show
  #   @title = 'Просмотр водителя'
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @driver }
  #   end
  # end

  # GET /drivers/new
  # GET /drivers/new.json
  def new
 
    #params[:driver][:rastentovka_ids] ||= []
    #@marka_select = Marka.order('id ASC').all
    #@raztentovka_checkbox = Raztentovka.order('id ASC').all
  
  end

  # GET /drivers/1/edit
  def edit
   
    @marka_select = Marka.order('id ASC').all
     @raztentovka_checkbox = Raztentovka.order('id ASC').all
     
    @title = 'Редактирование водителя'
  end


  def create

      if @driver.save
        flash[:success] = 'Водитель был успешно добавлен.'
        redirect_to drivers_path
      else
       render 'new'
    end
  end

  # PUT /drivers/1
  # PUT /drivers/1.json
  def update
    
      if @driver.update_attributes(params[:driver])
        flash[:success] = 'Водитель был успешно обновлен.'
        redirect_to drivers_path
      else
       render 'edit'
    end
  end

  # DELETE /drivers/1
  # DELETE /drivers/1.json
  def destroy
    authorize! :destroy, @user
    @driver.destroy

    respond_to do |format|
      format.html { redirect_to drivers_url }
      format.json { head :no_content }
    end
  end

def updateShow
  @driversJs = Driver.where('id=?', "#{params[:id]}")
  render :partial => "update_show", :locals => { :driversJs =>  @driversJs }
end

end
