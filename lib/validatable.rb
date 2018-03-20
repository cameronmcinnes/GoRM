require_relative 'sql_object'
require_relative 'validator'

require 'byebug'

module Validatable
  def self.included(base)
    base.extend(ClassMethods)
  end

  attr_reader :errors

  def valid?
    self.class.validator.validate(self)
  end

  # private
  module ClassMethods
    def validates(*attr_names, options)
      # save the new validator object as class instance variable
      # self.validator = Validator.new(self, attr_name, options)

      self.validator ||= Validator.new(self)
      self.validator.add_validations(*attr_names, options)
    end
  end

  attr_writer :errors
end
