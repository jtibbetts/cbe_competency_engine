class AddPaulFieldsToRop < ActiveRecord::Migration
  def change
    add_column :cbe_users, :middleName, :string, after: :givenName

    add_column :cbe_course_offerings, :description, :text, after: :title

    create_table :cbe_competency_outcomes do |t|
      t.string :description
    end

    create_table :cbe_competency_evidences do |t|
      t.string :description
    end
  end
end
