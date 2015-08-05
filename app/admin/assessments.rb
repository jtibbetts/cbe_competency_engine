ActiveAdmin.register Cbe::Assessment do
  menu :parent => "CBE..."

  permit_params :title, :description, :type, :scoring_method

end
