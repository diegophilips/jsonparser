# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.integer :job_number
      t.string :title
      t.string :company_name
      t.string :url
      t.text :description
      t.string :location
      t.integer :salary
      t.date :closing_date
      t.text :required_attributes
      t.text :responsabilities
      t.text :benefits
      t.text :apply

      t.timestamps
    end
  end
end
