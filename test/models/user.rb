# frozen_string_literal: true

class User < ActiveRecord::Base
  belongs_to :account
end
