class Space < ActiveRecord::Base

  class << self
    def end_date_is_after_start_date(start_date, end_date)
      return true if end_date.blank? || start_date.blank?

      if end_date < start_date
        return true
      end
    end
  end

  def total_price(start_date, end_date)
    day = ((end_date+1.days) - start_date).to_i  #(inclusiive)
    week = day/7
    month =  day/30
    months = month
    weeks = (day - month*30)/7
    days = day - (weeks*7) - (month*30)
    price =  (months*self.price_per_month) + (weeks*self.price_per_week) +
      (days*self.price_per_day)
  end
end
