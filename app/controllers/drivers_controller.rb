 #coding: utf-8
class DriversController < ApplicationController
  before_filter :signed_in_user
  # GET /drivers
  # GET /drivers.json
  def index
    @drivers = Driver.paginate(page: params[:page])
    @title = 'Список водителей'
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @drivers }
    end
  end

  # GET /drivers/1
  # GET /drivers/1.json
  def show
    @driver = Driver.find(params[:id])
    @title = 'Просмотр водителя'
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @driver }
    end
  end

  # GET /drivers/new
  # GET /drivers/new.json
  def new
    @driver = Driver.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @driver }
    end
  end

  # GET /drivers/1/edit
  def edit
    @driver = Driver.find(params[:id])
    @title = 'Редактирование водителя'
  end

  # POST /drivers
  # POST /drivers.json
  def create
    @driver = Driver.new(params[:driver])
 
      if @driver.save
        flash[:success] = 'Водитель был успешно добавлен.'
        redirect_to @driver
      else
       render 'new'
    end
  end

  # PUT /drivers/1
  # PUT /drivers/1.json
  def update
    @driver = Driver.find(params[:id])
      if @driver.update_attributes(params[:driver])
        flash[:success] = 'Водитель был успешно обновлен.'
        redirect_to @driver
      else
       render 'edit'
    end
  end

  # DELETE /drivers/1
  # DELETE /drivers/1.json
  def destroy
    @driver = Driver.find(params[:id])
    @driver.destroy

    respond_to do |format|
      format.html { redirect_to drivers_url }
      format.json { head :no_content }
    end
  end
end
