module Cbe
  class CourseSection < ActiveRecord::Base
    self.table_name = 'cbe_course_sections'
    belongs_to :course_offering

  end
end