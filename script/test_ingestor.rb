ENV["RAILS_ENV"] = "development"
require File.expand_path('../../config/environment', __FILE__)

def gather_uri_list(element, uri_list)
  if element.kind_of?(Array)
    element.each {|array_elmt| gather_uri_list(array_elmt, uri_list)}
  elsif element.kind_of?(Hash)
    element.each_pair do |hash_key, hash_value|
      if hash_key == '@id'
        uri_list << hash_value
      elsif hash_value.kind_of?(Array) || hash_value.kind_of?(Hash)
        gather_uri_list(hash_value, uri_list)
      end
    end
  end
  uri_list
end

def get_uri_domain(uri)
  zones = uri.split('/')
  zones[3]
end

def create_or_get_idx(domain, values_hash)
end


tcp = Lti2Tc::ToolConsumerProfile.last
tcp_wrapper = JsonWrapper.new(tcp.tc_profile)

organization = Cbe::Organization.first
user = Cbe::User.where(:name => 'Tom Arne').first

base_url = Rails.application.config.tool_consumer_registry.registry['tc_deployment_url']

rop = nil
File.open('data/comp_paul_rop.jsonld', "r") do |f|
  json_str = f.read()
  rop = JSON.load(json_str)
end

uri_list = gather_uri_list(rop, [])

uri_list.shift
uri_list.shift

uri_list.each do |elmt|
  domain = get_uri_domain(elmt)
  idx = create_or_get_idx(domain, values_hash)
  puts "Domain: #{domain}  Idx: #{idx}"
end



# puts "Rop: #{rop}"