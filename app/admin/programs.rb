ActiveAdmin.register Cbe::Program do
  menu :parent => "CBE..."

  permit_params :label, :degree_level, :version

end
