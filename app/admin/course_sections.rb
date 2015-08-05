ActiveAdmin.register Cbe::CourseSection do
  menu :parent => "CBE..."

  permit_params :course_offering_id, :term_id, :label, :title, :section_number
end
