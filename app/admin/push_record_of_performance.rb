ActiveAdmin.register_page "Push Record of Performance" do

  content :title => proc{ I18n.t('active_admin.dashboard') } do
    if params[:action] == 'index'
      users = AdminUser.where(:role => 'Learner').order('last_name')
      name_hash = {}
      users.each do |user|
        full_name = "#{user.last_name}, #{user.first_name}"
        name_hash[full_name] = user.id
      end
      request['name_hash'] = name_hash
      render 'push_record_of_performance'
    end
  end # content

end
