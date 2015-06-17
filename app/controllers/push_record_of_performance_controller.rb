class PushRecordOfPerformanceController < ApplicationController
  def pre_process
    Lti2Tc::Authorizer::pre_process_tenant(request)
  end

  def post_service
    user_id = nil
    params.each do |key,value|
      if /[[:alpha:]]+, [[:alpha:]]+/.match key
        user_id = value.to_i
        break
      end
    end
    user = AdminUser.find(user_id)
    render html: "<pre>#{user.inspect.html_safe}</pre>"
  end

end
