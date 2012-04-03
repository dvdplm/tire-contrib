# Tire mocking
# =============
#
# Author: David Palm <dvdplm@gmail.com>
#
#
# Adds two class methods to turn Tire on and off using the WebMock library.
# Useful to mock Tire and Elasticsearch in your test/spec suite.
#
# Usage:
# ------
#
# To enable/disable Elasticsearch in an rspec example, first add a
# spec/support/tire.rb file with:
# 
#     require 'webmock'
#     require 'tire/test_utilities/mock'
# 
#     Tire.disable!
# 
#     RSpec.configure do |config|
#       config.around do |example|
#         if not example.metadata[:elasticsearch]
#           example.call
#         else
#           Tire.enable! do
#             example.call
#           end
#         end
#       end
#     end
# 
# With the above, all specs will run without ever hitting Elasticsearch.
# To enable Elasticsearch selectvely, add the `elasticsearch: true` metadata
# to your examples. E.g.:
# 
#   it "should find happines", elasticsearch: true do
#     happiness = FactoryGirl.create :happines
#     Feeling.tire.index.refresh
#     get :index
# 
#     assigns[:feelings].to_a.should include( happiness )
#   end
require 'webmock'
WebMock.disable!
require 'tire/test_utilities/mock/disabler.rb'
require 'tire/test_utilities/mock/indexer.rb'