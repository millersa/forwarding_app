# coding: utf-8
class StatisticsController < ApplicationController
	before_filter :signed_in_user
    load_and_authorize_resource

  def index
  	@companysCount = Company.count(:id)
  	@driversCount = Driver.count(:id)
  	@usersCount = User.count(:id)
  	@usersSaCount = User.where(:roles_mask => '1').count
  	@usersACount = User.where(:roles_mask => '2').count
  	@usersDCount = User.where(:roles_mask => '4').count
  	@tendersCount = Tender.count(:id)
  	@tendersDoCount = Tender.where(:status => false).count
  	@tendersDoneCount = Tender.where(:status => true).count
    @tenders = Tender.where("status=? AND user_id=?", false, current_user).page(params[:page]).per_page(10)
  	@title = "Главная"

  end

  def update_stats_period
    if "#{params[:period]}" == 'today'  
        @titleFor_stats = 'Данные за сегодня'
        params[:start_date] = Time.now.to_date
        @companiesCount = Company.where(:updated_at => (Time.now.midnight)..(Time.now)).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight)..(Time.now)).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight)..(Time.now)).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight)..(Time.now)).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight)..(Time.now)).count
        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'yesterday'
        @titleFor_stats = 'Данные добавленные вчера'
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'week'
        @titleFor_stats = 'Данные за неделю'
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 7.day)..Time.now).count
        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'month'
        @titleFor_stats = 'Данные за месяц'
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 30.day)..Time.now).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 30.day)..Time.now).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 30.day)..Time.now).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 30.day)..Time.now).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 30.day)..Time.now).count
        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'year'
        @titleFor_stats = 'Данные за год'
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 365.day)..Time.now).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 365.day)..Time.now).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 365.day)..Time.now).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 365.day)..Time.now).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 365.day)..Time.now).count
        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :titleFor_stats => @titleFor_stats}
    else
        @update_stats = 'Ошибка'
        render :partial => "update_stats", :locals => {:update_stats => @update_stats}
    end
  end

end
