ActiveAdmin.register Cbe::CourseOffering do
  menu :parent => "CBE..."

  permit_params :program_id, :label, :title, :version

end
