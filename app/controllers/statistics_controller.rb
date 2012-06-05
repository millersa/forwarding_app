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
    @tendersSum = Tender.sum(:price)
  	@tendersDoCount = Tender.where(:status => false).count
  	@tendersDoneCount = Tender.where(:status => true).count
    sums_f = Tender.find(:all,
      :conditions => ['status=?',false],
      :select=>'sum(price) AS totalprice').first
     sums_t = Tender.find(:all,
      :conditions => ['status=?',true],
      :select=>'sum(price) AS totalprice').first
    @tendersDoSum = sums_f[:totalprice]
    @tendersDoneSum = sums_t[:totalprice]
    @usersList = User.find(:all, :select => "id, (firstname ||  lastname || otchestvo) AS FIO")
  	@title = "Статистика"
  end

  def stats

  end

  def update_stats_period
    if "#{params[:period]}" == 'today' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'Данные за сегодня'
        @companiesCount = Company.where(:updated_at => (Time.now.midnight)..(Time.now)).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight)..(Time.now)).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight)..(Time.now)).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight)..(Time.now)).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight)..(Time.now)).count

        @tendersSum = Tender.where(:updated_at => (Time.now.midnight)..(Time.now)).sum(:price)
        @tendersDoSum = Tender.where(:status => false, :updated_at => (Time.now.midnight)..(Time.now)).sum(:price)
        @tendersDoneSum = Tender.where(:status => true, :updated_at => (Time.now.midnight)..(Time.now)).sum(:price)

        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :tendersSum => @tendersSum, 
          :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'today' &&  "#{params[:user_id]}" != 'all'
        #"#{params[:user_id]}" валидация только цифры
        @titleFor_stats = 'Данные за сегодня'       
        @companiesCount = Company.where(:updated_at => (Time.now.midnight)..(Time.now)).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight)..(Time.now)).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight)..(Time.now)).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight)..(Time.now)).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight)..(Time.now)).count
        
         @tendersSum = Tender.where(:updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").sum(:price)
         @tendersDoSum = Tender.where(:status => false, :updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").sum(:price)
         @tendersDoneSum = Tender.where(:status => true, :updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").sum(:price)
       
        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :tendersSum => @tendersSum, 
          :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'yesterday' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'Данные добавленные вчера '
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count

        @tendersSum = Tender.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersDoSum = Tender.where(:status => false, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersDoneSum = Tender.where(:status => true, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight, :user_id => "#{params[:user_id]}").sum(:price)

        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :tendersSum => @tendersSum, 
          :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'yesterday' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'Данные добавленные вчера'
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count

        @tendersSum = Tender.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).sum(:price)
        @tendersDoSum = Tender.where(:status => false, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).sum(:price)
        @tendersDoneSum = Tender.where(:status => true, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).sum(:price)

        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :tendersSum => @tendersSum, 
          :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'week' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'Данные за неделю'
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 7.day)..Time.now).count

        @tendersSum = Tender.where(:updated_at => (Time.now.midnight - 7.day)..Time.now).sum(:price)
        @tendersDoSum = Tender.where(:status => false, :updated_at => (Time.now.midnight - 7.day)..Time.now).sum(:price)
        @tendersDoneSum = Tender.where(:status => true, :updated_at => (Time.now.midnight - 7.day)..Time.now).sum(:price)

        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :tendersSum => @tendersSum, 
          :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum, :titleFor_stats => @titleFor_stats}
     elsif "#{params[:period]}" == 'week' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'Данные за неделю'
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 7.day)..Time.now).count

        @tendersSum = Tender.where(:updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersDoSum = Tender.where(:status => false, :updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersDoneSum = Tender.where(:status => true, :updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)

        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :tendersSum => @tendersSum, 
          :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'month' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'Данные за месяц'
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 30.day)..Time.now).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 30.day)..Time.now).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 30.day)..Time.now).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 30.day)..Time.now).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 30.day)..Time.now).count

        @tendersSum = Tender.where(:updated_at => (Time.now.midnight - 30.day)..Time.now).sum(:price)
        @tendersDoSum = Tender.where(:status => false, :updated_at => (Time.now.midnight - 30.day)..Time.now).sum(:price)
        @tendersDoneSum = Tender.where(:status => true, :updated_at => (Time.now.midnight - 30.day)..Time.now).sum(:price)

        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :tendersSum => @tendersSum, 
          :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'month' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'Данные за месяц'
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 30.day)..Time.now).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 30.day)..Time.now).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 30.day)..Time.now).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 30.day)..Time.now).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 30.day)..Time.now).count

        @tendersSum = Tender.where(:updated_at => (Time.now.midnight - 30.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersDoSum = Tender.where(:status => false, :updated_at => (Time.now.midnight - 30.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersDoneSum = Tender.where(:status => true, :updated_at => (Time.now.midnight - 30.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)

        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :tendersSum => @tendersSum, 
          :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'year' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'Данные за  год'
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 365.day)..Time.now).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 365.day)..Time.now).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 365.day)..Time.now).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 365.day)..Time.now).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 365.day)..Time.now).count

        @tendersSum = Tender.where(:updated_at => (Time.now.midnight - 365.day)..Time.now).sum(:price)
        @tendersDoSum = Tender.where(:status => false, :updated_at => (Time.now.midnight - 365.day)..Time.now).sum(:price)
        @tendersDoneSum = Tender.where(:status => true, :updated_at => (Time.now.midnight - 365.day)..Time.now).sum(:price)

        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :tendersSum => @tendersSum, 
          :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'year' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'Данные за год'
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 365.day)..Time.now).count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 365.day)..Time.now).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 365.day)..Time.now).count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 365.day)..Time.now).count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 365.day)..Time.now).count

        @tendersSum = Tender.where(:updated_at => (Time.now.midnight - 365.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersDoSum = Tender.where(:status => false, :updated_at => (Time.now.midnight - 365.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersDoneSum = Tender.where(:status => true, :updated_at => (Time.now.midnight - 365.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)

        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :tendersSum => @tendersSum, 
          :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum, :titleFor_stats => @titleFor_stats}
    else
        @update_stats = 'Ошибка'
        render :partial => "update_stats", :locals => {:update_stats => @update_stats}
    end
  end

end
