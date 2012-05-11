# coding: utf-8
class TendersController < ApplicationController
	before_filter :signed_in_user

  def new
  	@tender = Tender.new
    @update_objem = Driver.order('objem ASC').all
    @ves = Driver.select(:ves).uniq

    #@update_marka = Driver.where(:ves => 10, :objem => 20)
    #@company = current_user.companies.find_by_id(params[:id])
    #@company = Company.find(:all)
    #rescue
    #flash.now[:error] = "У пользователя нет компаний."

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  
  end

  def create
    @tender = current_user.tenders.build(params[:tender])
    if @tender.save
      flash[:success] = "Заявка была успешно добавлена."
      redirect_to @tender
    else
      @title = "Добавление заявки"
      render 'new'
  end
end

  def index
  	@title = "Главная"
  end

  def done
  end


  def update_buginfo_select
     @buginfos = Buginfo.where(:id => params[:reportview][:buginfo_ids] , :analysistool_id =>params[:id])
    render :partial => "buginfos", :locals => {:buginfos => @buginfos}
  end

  def update_objem_select
     @update_objem = Driver.select(:objem).uniq.where('ves=?', params[:vesJs]) unless params[:vesJs].blank?
    render :partial => "update_objem", :locals => { :update_objem =>  @update_objem }
    #respond_to do |format|
     # format.js #{ render :layout => false } 
    #end
  end

  def update_marka_select
    @update_marka = Driver.find_by_sql("SELECT DISTINCT markas.id, markas.name FROM markas INNER JOIN drivers ON objem = #{params[:objemJs]} AND ves = #{params[:vesJs]} AND drivers.marka_id=markas.id ORDER BY markas.id ASC")
     #@update_marka = Driver.find_by_sql("SELECT DISTINCT marka_id FROM drivers WHERE (objem = #{params[:objemJs]} AND ves = #{params[:vesJs]})") unless params[:objemJs].blank?
     render :partial => "update_marka", :locals => {:update_marka => @update_marka}
  end

   def update_tipkuzova_radio
     @update_tipkuzova = Driver.find_by_sql("SELECT DISTINCT tipkuzova FROM drivers WHERE objem = #{params[:objemJs]} AND ves = #{params[:vesJs]} AND marka_id = #{params[:markaJs]}")
    # @update_tipkuzova = Driver.select(:tipkuzova).where(:id => 11)
     render :partial => "update_tipkuzova", :locals => { :update_tipkuzova =>  @update_tipkuzova }
  end

  def update_rastentovka_checkbox
     @raztentovka_checkbox = Raztentovka.order('id ASC').all
     @update_rastentovka = @raztentovka_checkbox
    # @update_tipkuzova = Driver.select(:tipkuzova).where(:id => 11)
     render :partial => "update_rastentovka", :locals => { :update_rastentovka =>  @update_rastentovka }
  end

  def update_driver_data
    #session[:driverDate] = ['a','b']
    
     @update_driver = params[:rastentovkaJs]
      @update_tipkuzova = Driver.find_by_sql("SELECT * FROM drivers WHERE rastentovka_ids = #{params[:rastentovkaJs]}")
    # @update_tipkuzova = Driver.select(:tipkuzova).where(:id => 11)
    # @update_tipkuzova = Driver.select(:tipkuzova).where(:id => 11)
     render :partial => "update_driver", :locals => { :update_driver =>  @update_driver }
  end

end
