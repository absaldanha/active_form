# frozen_string_literal: true

require "active_record"

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :accounts, force: true do |t|
    t.string :name

    t.timestamps
  end

  create_table :teams, force: true do |t|
    t.string :name

    t.references :account

    t.timestamps
  end

  create_table :users, force: true do |t|
    t.string :first_name
    t.string :last_name
    t.string :email

    t.references :account
    t.references :team

    t.timestamps
  end
end
