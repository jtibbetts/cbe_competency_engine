

require 'json/ld/signature'

class RecordOfPerformanceController < ApplicationController

  def post_service
    user_id = nil
    params.each do |key,value|
      if /[[:alpha:]]+, [[:alpha:]]+/.match key
        user_id = value.to_i
        break
      end
    end
    admin_user = AdminUser.find(user_id)

    cbe_user = Cbe::User.where(familyName: admin_user.last_name, givenName: admin_user.first_name).first
    if cbe_user.present?
      base_uri = Rails.application.config.tool_consumer_registry.registry['tc_deployment_url']
      organization = Cbe::Organization.first

      base_url = Rails.application.config.tool_consumer_registry.registry['tc_deployment_url']
      response = send_record_of_performance(base_url, organization, cbe_user)

      if response.code.between?( 200, 202 )
        render text: "Raw record of performance received by eTranscript engine: #{response.body}"
      else
        render text: "Error on RecordOfPerformance transmission: #{response.code}"
      end


    else
      render html: "No transcript data for user #{admin_user.first_name} #{admin_user.last_name}"
    end
  end

  private

  def send_record_of_performance(base_url, organization, user)
    tool = Lti2Tc::Tool.last
    tool_proxy_wrapper = JsonWrapper.new(tool.tool_proxy)
    service_offered = tool_proxy_wrapper.first_at('tool_profile.service_offered')
    endpoint = service_offered.first['endpoint']
    mediatype = service_offered.first['format']

    tcp = Lti2Tc::ToolConsumerProfile.last
    tcp_wrapper = JsonWrapper.new(tcp.tc_profile)

    rop_json = Cbe::RecordOfPerformance.record_of_performance_media_type(tcp_wrapper, base_url, organization, user)

    # Sign it
    rop_wrapper = JsonWrapper.new(rop_json)

    user_endpoint = rop_wrapper.root['user']['@id']

    signed = JSON::LD::SIGNATURE::Sign.sign rop_json, { 'privateKeyPem' => user.privkey, 'creator' => "#{user_endpoint}" }

    # data = CGI::escape(data)
    signed_request = create_signed_request \
        endpoint,
        'post',
        tool.key,
        tool.secret,
        {},
        signed,
        mediatype

    puts "Register request: #{signed_request.signature_base_string}"
    puts "Register secret: #{tool.secret}"

    headers = {}
    response = invoke_service(signed_request, Rails.application.config.wire_log, "Record of Performance for #{user.name}",
                              headers)

  end
end

