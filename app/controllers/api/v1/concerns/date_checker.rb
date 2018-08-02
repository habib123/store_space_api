module DateChecker
  extend ActiveSupport::Concern

  included do
    def self.end_date_is_after_start_date(start_date, end_date)
      return true if end_date.blank? || start_date.blank?

      if end_date < start_date
        return true
      end
    end
  end
end
