# frozen_string_literal: true

class Account < ActiveRecord::Base
  has_many :users
end
