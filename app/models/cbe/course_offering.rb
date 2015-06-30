module Cbe
  class CourseOffering < ActiveRecord::Base
    self.table_name = 'cbe_course_offerings'
    has_one :course_section

  end
end