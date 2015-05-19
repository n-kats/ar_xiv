require 'spec_helper.rb'
require 'pp'
describe ArXiv::Category do
  Cat = ArXiv::Category
  Q = ArXiv::Query
  h = ArXiv::Category::LIST_HASH
  q = h["math"].keys.map{|k| Q.new({cat: "math.#{k}"})}.inject(:or)
  puts ArXiv::Request.new(q,{}).api_url
end
