ActiveAdmin.register Cbe::Organization do
  menu :parent => "CBE..."

  permit_params :legal_name, :label, :description, :website

end
