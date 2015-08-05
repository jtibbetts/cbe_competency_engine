ActiveAdmin.register Cbe::CourseSectionMember do
  menu :parent => "CBE..."

  permit_params :program_id, :label, :title, :version

end
