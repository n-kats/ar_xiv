require 'spec_helper.rb'

describe ArXiv::Request do
  Query = ArXiv::Query
  Request = ArXiv::Request
  it 'makes the simplest url' do
    expect(Request.new.api_url).to eq "http://export.arxiv.org/api/query?"

  end
  it 'accesses arXiv' do
    # puts Request.new(Query.new("math")).get
  end
end
