 #coding: utf-8
class DriversController < ApplicationController
  before_filter :signed_in_user
  # GET /drivers
  # GET /drivers.json
  def index
    @drivers = Driver.page(params[:page]).per_page(7)
  #@marka_index = Driver.find(drivers.marka_id)
    #@markaIn = @marka_index.marka_id
   # @marka_index = case @marka_index
   #   when 1 then "тентованный"
   #   when '2' then "контейнер"
   #   when '3' then "микроавтобус"
   #   when '4' then "фургон"
   #   when '5' then "цельнометалл"
   #   when '6' then "рефрижератор"
   #   when '7' then "изотермический"
   #   when '8' then "бортовой"
   #   when '9' then "открытый конт."
   #    when '10' then "пикап"
   #    when '11' then "шаланда"
   #    when '12' then "негабарит"
   #    when '13' then "низкорамный"
   #    when '14' then "низкорам. платф."
   #    when '15' then "телескопический"
   #    when '16' then "трал"
   #    when '17' then "автобус"
   #    when '18' then "автовоз"
   #    when '19' then "автовышка"
   #    when '20' then "автотранспортер"
   #    when '21' then "бетоновоз"
   #    when '22' then "бензовоз"
   #    when '23' then "вездеход"       
   #    when '24' then "газовоз"
   #    when '25' then "зерновоз"
   #    when '26' then "коневоз"
   #    when '27' then "конт.площадка"
   #    when '28' then "кормовоз" 
   #    when '29' then "кран"
   #    when '30' then "лесовоз"
   #    when '31' then "манипулятор"
   #    when '32' then "муковоз"
   #    when '33' then "панелевоз"
   #    when '34' then "самосвал"
   #    when '35' then "седельный тягач"
   #    when '36' then "скотовоз"
   #    when '37' then "стекловоз"
   #    when '38' then "трубовоз"
   #    when '39' then "цементовоз"
   #    when '40' then "цистерна"
   #    when '41' then "щеповоз"
   #    when '42' then "эвакуатор"
   #  else "Не заполнено"
   #  end


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
   @marka = @driver.marka_id
   @marka = case @marka
     when 1 then "тентованный"
     when 2 then "контейнер"
     when 3 then "микроавтобус"
     when 4 then "цельнометалл."
     when 5 then "рефрижератор"
     when 6 then "изотермический"
     when 7 then "бортовой"
     when 8 then "открытый конт."
      when 9 then "пикап"
      when 10 then "шаланда"
      when 11 then "негабарит"
      when 12 then "низкорамный"
      when 13 then "низкорам. платф."
      when 14 then "телескопический"
      when 15 then "трал"
      when 16 then "автобус"
      when 17 then "автовоз"
      when 18 then "автовышка"
      when 19 then "автотранспортер"
      when 20 then "бетоновоз"
      when 21 then "бензовоз"
      when 22 then "вездеход"       
      when 23 then "газовоз"
      when 24 then "зерновоз"
      when 25 then "коневоз"
      when 26 then "конт.площадка"
      when 27 then "кормовоз" 
      when 28 then "кран"
      when 29 then "лесовоз"
      when 30 then "манипулятор"
      when 31 then "муковоз"
      when 32 then "панелевоз"
      when 33 then "самосвал"
      when 34 then "седельный тягач"
      when 35 then "скотовоз"
      when 36 then "стекловоз"
      when 37 then "трубовоз"
      when 38 then "цементовоз"
      when 39 then "цистерна"
      when 40 then "щеповоз"
      when 41 then "эвакуатор"
    else "Не заполнено"
    end


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
    @marka_select = Marka.order('id ASC').all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @driver }
    end
  end

  # GET /drivers/1/edit
  def edit
    @driver = Driver.find(params[:id])
    @marka_select = Marka.order('id ASC').all
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
