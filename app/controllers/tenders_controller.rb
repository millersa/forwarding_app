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
    @update_objem = ActiveRecord::Base.connection().execute("SELECT objem FROM drivers WHERE ves = '#{params[:vesJs]}' ")
     #@update_objem = Driver.select(:objem).uniq.where(:ves=>params[:vesJs]) unless params[:vesJs].blank?
     #@update_objem = Driver.where('ves LIKE ?', "%#{params[:vesJs]}%").uniq unless params[:vesJs].blank?
      #@update_objem = @update_objem.uniq(true)
    render :partial => "update_objem", :locals => { :update_objem =>  @update_objem }
    #respond_to do |format|
     # format.js #{ render :layout => false } 
    #end
  end

  def update_marka_select
     @update_marka = Driver.where(:objem => params[:objemJs], :ves=>params[:vesJs]) unless params[:objemJs].blank?
     render :partial => "update_marka", :locals => {:update_marka => @update_marka}
  end

end
