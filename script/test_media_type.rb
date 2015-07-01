ENV["RAILS_ENV"] = "development"
require File.expand_path('../../config/environment', __FILE__)

organization = Cbe::Organization.first
user = Cbe::User.where(:lis_person_name_full => 'Tom Arne').first

rop_json = Cbe::RecordOfPerformance.record_of_performance_media_type('http://kinexis.com/cbe', organization, user)

puts rop_json

File.open("../../data/rop_media_type.jsonld", "w") { |file| file.write rop_json }