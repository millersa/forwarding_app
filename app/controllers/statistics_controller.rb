# coding: utf-8
class StatisticsController < ApplicationController
	before_filter :signed_in_user #перед загрузкой срабатывает функция signed_in_user . Если пользватель не авторизован, то перенаправляет на страницу авторизации
    load_and_authorize_resource  #права доступа

  def index # главная страница статистики
  	@companysCount = Company.count(:id) #подсчитываем количество компаний
  	@driversCount = Driver.count(:id)  #подсчитываем количество водителей
  	@usersCount = User.count(:id)  #подсчитываем количество пользователей
  	@usersSaCount = User.where(:roles_mask => '1').count #подсчитываем количество пользователей с правами суперадминистратора
  	@usersACount = User.where(:roles_mask => '2').count  #подсчитываем количество пользователей с правами администратора
  	@usersDCount = User.where(:roles_mask => '4').count  #подсчитываем количество пользователей с правами диспетчера
  	@tendersCount = Tender.count(:id)
    @tendersSum = Tender.sum(:price) #подсчитываем сумму всех заявок
  	@tendersDoCount = Tender.where(:status => false).count  #подсчитываем количество текущих заявок
  	@tendersDoneCount = Tender.where(:status => true).count  #подсчитываем количество выполенных  заявок
    sums_f = Tender.find(:all,
      :conditions => ['status=?',false],
      :select=>'sum(price) AS totalprice').first
     sums_t = Tender.find(:all,
      :conditions => ['status=?',true],
      :select=>'sum(price) AS totalprice').first
    @tendersDoSum = sums_f[:totalprice] #подсчитываем сумму текущих заявок
    @tendersDoneSum = sums_t[:totalprice] #подсчитываем сумму выполненных заявок
    @usersList = User.find(:all, :select => "id, (firstname ||  lastname || otchestvo) AS FIO")
  	@title = "Статистика" #заголовок страницы
  end

  def stats # по напра-ям пользователи
    @tendersCountWayV = Tender.where('way_id=?', '1').count #подсчитываем количество направления "восток"
    @tendersCountWayZ = Tender.where('way_id=?', '2').count #подсчитываем количество направления "запад"
    @tendersCountWayS = Tender.where('way_id=?', '3').count #подсчитываем количество направления "север"
    @tendersCountWayY = Tender.where('way_id=?', '4').count #подсчитываем количество направления "юг"
    @tendersSumWayV = Tender.where('way_id=?', '1').sum(:price) #подсчитываем сумму направления "восток"
    @tendersSumWayZ = Tender.where('way_id=?', '2').sum(:price) #подсчитываем сумму направления "запад"
    @tendersSumWayS = Tender.where('way_id=?', '3').sum(:price) #подсчитываем сумму направления "север"
    @tendersSumWayY = Tender.where('way_id=?', '4').sum(:price) #подсчитываем сумму направления "юг"
     @usersList = User.find(:all, :select => "id, (firstname ||  lastname || otchestvo) AS FIO")
    @title = "Статистика" #заголовок страницы
  end

  def statsCompany # по напра-ям компании
    @tendersCountCoV = Tender.where('way_id=?', '1').count(:company_id)
    @tendersCountCoZ = Tender.where('way_id=?', '2').count(:company_id)
    @tendersCountCoS = Tender.where('way_id=?', '3').count(:company_id)
    @tendersCountCoY = Tender.where('way_id=?', '4').count(:company_id)
     @companysList = Company.find(:all)
    @title = "Статистика" #заголовок страницы

  end

  # def statsGrade
  #    @driversCount = Driver.count(:id)
  #    @driversList = Driver.find(:all, :select => "id, (fname ||  lname || oname) AS FIO")
  #    @gradeall = Grade.where(:gradable_type => 'Driver').count
  #    @gradepo = Grade.where(:gradable_type => 'Driver', :mark => true).count
  #    @gradeot = Grade.where(:gradable_type => 'Driver', :mark => false).count
  # end

    def update_stats_n #стоимость заявок по направлениям
    if "#{params[:period]}" == 'today' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'сегодня'
        @tendersSumjsV = Tender.where(:way_id => '1', :updated_at => (Time.now.midnight)..(Time.now)).sum(:price) #  way_id это направления(1- Восток; 2- Запад; 3- Север; 4- Юг)
        @tendersSumjsZ = Tender.where(:way_id => '2', :updated_at => (Time.now.midnight)..(Time.now)).sum(:price)
        @tendersSumjsS = Tender.where(:way_id => '3', :updated_at => (Time.now.midnight)..(Time.now)).sum(:price)
        @tendersSumjsY = Tender.where(:way_id => '4', :updated_at => (Time.now.midnight)..(Time.now)).sum(:price)
        
        render :partial => "update_stats_n", :locals => {:tendersSumjsV => @tendersSumjsV, :tendersSumjsZ => @tendersSumjsZ,
         :tendersSumjsS => @tendersSumjsS, :tendersSumjsY => @tendersSumjsY, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'today' &&  "#{params[:user_id]}" != 'all'
        #"#{params[:user_id]}" валидация только цифры
        @titleFor_stats = 'сегодня'       
         @tendersSumjsV = Tender.where(:way_id => '1', :updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").sum(:price)
         @tendersSumjsZ = Tender.where(:way_id => '2', :updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").sum(:price)
         @tendersSumjsS = Tender.where(:way_id => '3', :updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").sum(:price)
         @tendersSumjsY = Tender.where(:way_id => '4', :updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").sum(:price)
         
       
      render :partial => "update_stats_n", :locals => {:tendersSumjsV => @tendersSumjsV, :tendersSumjsZ => @tendersSumjsZ,
         :tendersSumjsS => @tendersSumjsS, :tendersSumjsY => @tendersSumjsY, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'yesterday' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'вчера '
        
        @tendersSumjsV = Tender.where(:way_id => '1', :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersSumjsZ = Tender.where(:way_id => '2', :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersSumjsS = Tender.where(:way_id => '3', :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersSumjsY = Tender.where(:way_id => '4', :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight, :user_id => "#{params[:user_id]}").sum(:price)

        render :partial => "update_stats_n", :locals => {:tendersSumjsV => @tendersSumjsV, :tendersSumjsZ => @tendersSumjsZ,
         :tendersSumjsS => @tendersSumjsS, :tendersSumjsY => @tendersSumjsY, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'yesterday' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'вчера'
        
        @tendersSumjsV = Tender.where(:way_id => '1', :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).sum(:price)
        @tendersSumjsZ = Tender.where(:way_id => '2', :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).sum(:price)
        @tendersSumjsS = Tender.where(:way_id => '3', :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).sum(:price)
        @tendersSumjsY = Tender.where(:way_id => '4', :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).sum(:price)
        

      render :partial => "update_stats_n", :locals => {:tendersSumjsV => @tendersSumjsV, :tendersSumjsZ => @tendersSumjsZ,
         :tendersSumjsS => @tendersSumjsS, :tendersSumjsY => @tendersSumjsY, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'week' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'неделю'
       
        @tendersSumjsV = Tender.where(:way_id => '1', :updated_at => (Time.now.midnight - 7.day)..Time.now).sum(:price)
        @tendersSumjsZ = Tender.where(:way_id => '2', :updated_at => (Time.now.midnight - 7.day)..Time.now).sum(:price)
         @tendersSumjsS = Tender.where(:way_id => '3', :updated_at => (Time.now.midnight - 7.day)..Time.now).sum(:price)
          @tendersSumjsY = Tender.where(:way_id => '4', :updated_at => (Time.now.midnight - 7.day)..Time.now).sum(:price)
       
        render :partial => "update_stats_n", :locals => {:tendersSumjsV => @tendersSumjsV, :tendersSumjsZ => @tendersSumjsZ,
         :tendersSumjsS => @tendersSumjsS, :tendersSumjsY => @tendersSumjsY, :titleFor_stats => @titleFor_stats}
     elsif "#{params[:period]}" == 'week' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'неделю'
       
        @tendersSumjsV = Tender.where(:way_id => '1', :updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersSumjsZ = Tender.where(:way_id => '2', :updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersSumjsS = Tender.where(:way_id => '3', :updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersSumjsY = Tender.where(:way_id => '4', :updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        
        render :partial => "update_stats_n", :locals => {:tendersSumjsV => @tendersSumjsV, :tendersSumjsZ => @tendersSumjsZ,
         :tendersSumjsS => @tendersSumjsS, :tendersSumjsY => @tendersSumjsY, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'month' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'месяц'
       
        @tendersSumjsV = Tender.where(:way_id => '1', :updated_at => (Time.now.midnight - 30.day)..Time.now).sum(:price)
        @tendersSumjsZ = Tender.where(:way_id => '2', :updated_at => (Time.now.midnight - 30.day)..Time.now).sum(:price)
        @tendersSumjsS = Tender.where(:way_id => '3', :updated_at => (Time.now.midnight - 30.day)..Time.now).sum(:price)
        @tendersSumjsY = Tender.where(:way_id => '4', :updated_at => (Time.now.midnight - 30.day)..Time.now).sum(:price)
        

       render :partial => "update_stats_n", :locals => {:tendersSumjsV => @tendersSumjsV, :tendersSumjsZ => @tendersSumjsZ,
         :tendersSumjsS => @tendersSumjsS, :tendersSumjsY => @tendersSumjsY, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'month' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'месяц'
        
        @tendersSumjsV = Tender.where(:way_id => '1', :updated_at => (Time.now.midnight - 30.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersSumjsZ = Tender.where(:way_id => '2', :updated_at => (Time.now.midnight - 30.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersSumjsS = Tender.where(:way_id => '3', :updated_at => (Time.now.midnight - 30.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersSumjsY = Tender.where(:way_id => '4', :updated_at => (Time.now.midnight - 30.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
       

        render :partial => "update_stats_n", :locals => {:tendersSumjsV => @tendersSumjsV, :tendersSumjsZ => @tendersSumjsZ,
         :tendersSumjsS => @tendersSumjsS, :tendersSumjsY => @tendersSumjsY, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'year' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'год'
       
        @tendersSumjsV = Tender.where(:way_id => '1', :updated_at => (Time.now.midnight - 365.day)..Time.now).sum(:price)
         @tendersSumjsZ = Tender.where(:way_id => '2', :updated_at => (Time.now.midnight - 365.day)..Time.now).sum(:price)
          @tendersSumjsS = Tender.where(:way_id => '3', :updated_at => (Time.now.midnight - 365.day)..Time.now).sum(:price)
           @tendersSumjsY = Tender.where(:way_id => '4', :updated_at => (Time.now.midnight - 365.day)..Time.now).sum(:price)
        

        render :partial => "update_stats_n", :locals => {:tendersSumjsV => @tendersSumjsV, :tendersSumjsZ => @tendersSumjsZ,
         :tendersSumjsS => @tendersSumjsS, :tendersSumjsY => @tendersSumjsY, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'year' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'год'
       
        @tendersSumjsV = Tender.where(:way_id => '1', :updated_at => (Time.now.midnight - 365.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersSumjsZ = Tender.where(:way_id => '2', :updated_at => (Time.now.midnight - 365.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersSumjsS = Tender.where(:way_id => '3', :updated_at => (Time.now.midnight - 365.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersSumjsY = Tender.where(:way_id => '4', :updated_at => (Time.now.midnight - 365.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        

        render :partial => "update_stats_n", :locals => {:tendersSumjsV => @tendersSumjsV, :tendersSumjsZ => @tendersSumjsZ,
         :tendersSumjsS => @tendersSumjsS, :tendersSumjsY => @tendersSumjsY, :titleFor_stats => @titleFor_stats}
    else
        @update_statse = 'Ошибка'
        sums_f = Tender.find(:all,
      :conditions => ['status=?',false],
      :select=>'sum(price) AS totalprice').first
     sums_t = Tender.find(:all,
      :conditions => ['status=?',true],
      :select=>'sum(price) AS totalprice').first
    @tendersDoSum = sums_f[:totalprice]
    @tendersDoneSum = sums_t[:totalprice]
        render :partial => "update_stats_d", :locals => {:update_statse => @update_statse, :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum}
    end
  end

  def update_stats_all # вывод на страницы общая круговой диаграммы
    if "#{params[:period]}" == 'today' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'Данные за сегодня'
        @tendersDoSumjs = Tender.where(:status => false, :updated_at => (Time.now.midnight)..(Time.now)).sum(:price) #данные за сегодня по текущим заявкам, сумма
        @tendersDoneSumjs = Tender.where(:status => true, :updated_at => (Time.now.midnight)..(Time.now)).sum(:price) #данные за сегодня по выполненным заявкам, сумма

        render :partial => "update_stats_d", :locals => {:tendersDoSumjs => @tendersDoSumjs, :tendersDoneSumjs => @tendersDoneSumjs, 
          :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'today' &&  "#{params[:user_id]}" != 'all'
        #"#{params[:user_id]}" валидация только цифры
        @titleFor_stats = 'Данные за сегодня'       
         @tendersDoSumjs = Tender.where(:status => false, :updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").sum(:price) #данные за вчера по текущим заявкам, сумма
         @tendersDoneSumjs = Tender.where(:status => true, :updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").sum(:price)
       
       render :partial => "update_stats_d", :locals => {:tendersDoSumjs => @tendersDoSumjs, :tendersDoneSumjs => @tendersDoneSumjs, 
          :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'yesterday' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'Данные добавленные вчера '
        
        @tendersDoSumjs = Tender.where(:status => false, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersDoneSumjs = Tender.where(:status => true, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight, :user_id => "#{params[:user_id]}").sum(:price)

        render :partial => "update_stats_d", :locals => {:tendersDoSumjs => @tendersDoSumjs, :tendersDoneSumjs => @tendersDoneSumjs, 
          :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'yesterday' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'Данные добавленные вчера'
        
        @tendersDoSumjs = Tender.where(:status => false, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).sum(:price)
        @tendersDoneSumjs = Tender.where(:status => true, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).sum(:price)

       render :partial => "update_stats_d", :locals => {:tendersDoSumjs => @tendersDoSumjs, :tendersDoneSumjs => @tendersDoneSumjs, 
          :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'week' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'Данные за неделю'
       
        @tendersDoSumjs = Tender.where(:status => false, :updated_at => (Time.now.midnight - 7.day)..Time.now).sum(:price)
        @tendersDoneSumjs = Tender.where(:status => true, :updated_at => (Time.now.midnight - 7.day)..Time.now).sum(:price)

        render :partial => "update_stats_d", :locals => {:tendersDoSumjs => @tendersDoSumjs, :tendersDoneSumjs => @tendersDoneSumjs, 
          :titleFor_stats => @titleFor_stats}
     elsif "#{params[:period]}" == 'week' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'Данные за неделю'
       
        @tendersDoSumjs = Tender.where(:status => false, :updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersDoneSumjs = Tender.where(:status => true, :updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)

        render :partial => "update_stats_d", :locals => {:tendersDoSumjs => @tendersDoSumjs, :tendersDoneSumjs => @tendersDoneSumjs, 
          :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'month' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'Данные за месяц'
       
        @tendersDoSumjs = Tender.where(:status => false, :updated_at => (Time.now.midnight - 30.day)..Time.now).sum(:price)
        @tendersDoneSumjs = Tender.where(:status => true, :updated_at => (Time.now.midnight - 30.day)..Time.now).sum(:price)

       render :partial => "update_stats_d", :locals => {:tendersDoSumjs => @tendersDoSumjs, :tendersDoneSumjs => @tendersDoneSumjs, 
          :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'month' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'Данные за месяц'
        
        @tendersDoSumjs = Tender.where(:status => false, :updated_at => (Time.now.midnight - 30.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersDoneSumjs = Tender.where(:status => true, :updated_at => (Time.now.midnight - 30.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)

        render :partial => "update_stats_d", :locals => {:tendersDoSumjs => @tendersDoSumjs, :tendersDoneSumjs => @tendersDoneSumjs, 
          :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'year' &&  "#{params[:user_id]}" == 'all'
        @titleFor_stats = 'Данные за  год'
       
        @tendersDoSumjs = Tender.where(:status => false, :updated_at => (Time.now.midnight - 365.day)..Time.now).sum(:price)
        @tendersDoneSumjs = Tender.where(:status => true, :updated_at => (Time.now.midnight - 365.day)..Time.now).sum(:price)

        render :partial => "update_stats_d", :locals => {:tendersDoSumjs => @tendersDoSumjs, :tendersDoneSumjs => @tendersDoneSumjs, 
          :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'year' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'Данные за год'
       
        @tendersDoSumjs = Tender.where(:status => false, :updated_at => (Time.now.midnight - 365.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)
        @tendersDoneSumjs = Tender.where(:status => true, :updated_at => (Time.now.midnight - 365.day)..Time.now, :user_id => "#{params[:user_id]}").sum(:price)

        render :partial => "update_stats_d", :locals => {:tendersDoSumjs => @tendersDoSumjs, :tendersDoneSumjs => @tendersDoneSumjs, 
          :titleFor_stats => @titleFor_stats}
    else
        @update_statse = 'Ошибка'
        sums_f = Tender.find(:all,
      :conditions => ['status=?',false],
      :select=>'sum(price) AS totalprice').first
     sums_t = Tender.find(:all,
      :conditions => ['status=?',true],
      :select=>'sum(price) AS totalprice').first
    @tendersDoSum = sums_f[:totalprice]
    @tendersDoneSum = sums_t[:totalprice]
        render :partial => "update_stats_d", :locals => {:update_statse => @update_statse, :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum}
    end
  end

  def update_stats_period # на общей странице вывод текстовой информации по каждому пользователю
    if "#{params[:period]}" == 'today' &&  "#{params[:user_id]}" == 'all' # для всех пользоватлей за сегодня
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
    elsif "#{params[:period]}" == 'today' &&  "#{params[:user_id]}" != 'all' # для выбранного пользователя за сегодня
        #"#{params[:user_id]}" валидация только цифры
        @titleFor_stats = 'Данные за сегодня'       
        @companiesCount = Company.where(:updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight)..(Time.now)).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").count
        
         @tendersSum = Tender.where(:updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").sum(:price)
         @tendersDoSum = Tender.where(:status => false, :updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").sum(:price)
         @tendersDoneSum = Tender.where(:status => true, :updated_at => (Time.now.midnight)..(Time.now), :user_id => "#{params[:user_id]}").sum(:price)
       
        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :tendersSum => @tendersSum, 
          :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum, :titleFor_stats => @titleFor_stats}
    elsif "#{params[:period]}" == 'yesterday' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'Данные добавленные вчера '
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight, :user_id => "#{params[:user_id]}").count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 1.day)..Time.now.midnight, :user_id => "#{params[:user_id]}").count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight, :user_id => "#{params[:user_id]}").count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 1.day)..Time.now.midnight, :user_id => "#{params[:user_id]}").count

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
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").count

        @tendersSum = Tender.where(:updated_at => (Time.now.midnight - 7.day)..Time.now).sum(:price)
        @tendersDoSum = Tender.where(:status => false, :updated_at => (Time.now.midnight - 7.day)..Time.now).sum(:price)
        @tendersDoneSum = Tender.where(:status => true, :updated_at => (Time.now.midnight - 7.day)..Time.now).sum(:price)

        render :partial => "update_stats", :locals => {:companiesCount => @companiesCount, :driversACount => @driversACount, 
          :tendersACount => @tendersACount, :tendersADoCount => @tendersADoCount, :tendersADoneCount => @tendersADoneCount, :tendersSum => @tendersSum, 
          :tendersDoSum => @tendersDoSum, :tendersDoneSum => @tendersDoneSum, :titleFor_stats => @titleFor_stats}
     elsif "#{params[:period]}" == 'week' &&  "#{params[:user_id]}" != 'all'
        @titleFor_stats = 'Данные за неделю'
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 7.day)..Time.now).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 7.day)..Time.now, :user_id => "#{params[:user_id]}").count

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
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 30.day)..Time.now, :user_id => "#{params[:user_id]}").count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 30.day)..Time.now).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 30.day)..Time.now, :user_id => "#{params[:user_id]}").count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 30.day)..Time.now, :user_id => "#{params[:user_id]}").count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 30.day)..Time.now, :user_id => "#{params[:user_id]}").count

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
        @companiesCount = Company.where(:updated_at => (Time.now.midnight - 365.day)..Time.now, :user_id => "#{params[:user_id]}").count
        @driversACount = Driver.where(:updated_at => (Time.now.midnight - 365.day)..Time.now).count
        @tendersACount = Tender.where(:updated_at => (Time.now.midnight - 365.day)..Time.now, :user_id => "#{params[:user_id]}").count
        @tendersADoCount = Tender.where(:status => false, :updated_at => (Time.now.midnight - 365.day)..Time.now, :user_id => "#{params[:user_id]}").count
        @tendersADoneCount = Tender.where(:status => true, :updated_at => (Time.now.midnight - 365.day)..Time.now, :user_id => "#{params[:user_id]}").count

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
