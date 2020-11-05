# frozen_string_literal: true

class User < ActiveRecord::Base
  belongs_to :account
  belongs_to :team

  scope :active, -> { where(active: true) }
end
