
class GradesController < ApplicationController

def create #создание отзыва
    @driver = Driver.find(params[:driver_id])
    @grades = @driver.grades.create(params[:grade])
    redirect_to drivers_path
  end

  # def create
  #   @gradable = find_gradable
  #   @grade = @gradable.grades.build(params[:grade])
  #   if @grade.save
  #     flash[:notice] = "df"
  #    # redirect_to :id => nil
  #   else
  #    # render :action => 'new'
  #   end
  # end

  #  private
  
  # def find_gradable
  #   params.each do |name, value|
  #     if name =~ /(.+)_id$/
  #       return $1.classify.constantize.find(value)
  #     end
  #   end
  #   nil
  # end

end
