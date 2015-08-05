ENV["RAILS_ENV"] = "development"
require File.expand_path('../../config/environment', __FILE__)

tcp = Lti2Tc::ToolConsumerProfile.last
tcp_wrapper = JsonWrapper.new(tcp.tc_profile)

organization = Cbe::Organization.first
user = Cbe::User.where(:name => 'Tom Arne').first

base_url = Rails.application.config.tool_consumer_registry.registry['tc_deployment_url']
rop_json = Cbe::RecordOfPerformance.record_of_performance_media_type(tcp_wrapper, base_url, organization, user)

puts rop_json

File.open("data/rop_media_type.jsonld", "w") { |file| file.write rop_json }

# put one in purl repo
File.open("/Users/johntibbetts/git/purl_redirector/data/purl.imsglobal.org/ctx/cbe/v1/record_of_performance/sample/record_of_performance.jsonld", "w") { |file| file.write rop_json }
