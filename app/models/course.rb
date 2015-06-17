class Course < ActiveRecord::Base

  has_many :enrollments
  has_many :grade_items
  has_many :grade_results

  alias_attribute :name, :course_label

  attr_accessor :url

  def course_resolver(fieldname)
    case fieldname
    when 'label'
      self.course_label
    when 'title'
      self.course_title
    end
  end

end
