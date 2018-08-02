module Filterable
  extend ActiveSupport::Concern

  included do
    scope :like, ->(key, value) { where("#{key} like ?", "#{value}") }
    scope :eq, ->(key, value) { where("#{key} = ?", value) }
    scope :lt, ->(key, value) { where("#{key} < ?", "#{value}")  }
    scope :gt, ->(key, value) { where("#{key} > ?", "#{value}")  }
  end

  module ClassMethods
    def slice_params(params)
      filtering_params = params.select {
        |k,v| self.column_names.include?(k)
      }
    end

    def filter(params)
      filtering_params = self.slice_params params

      results = self.where(nil)

      filtering_params.each do | key, value |
        if value.present?
          cond_method, value = value.split(':')
          results = results.public_send(cond_method, key, value)
        end
      end

      results
    end
  end
end
