require 'spec_helper.rb'

describe ArXiv do
  it 'has a version number' do
    expect(ArXiv::VERSION).not_to be nil
  end

  it 'loads ArXiv::Query' do
    expect(ArXiv::Query).not_to be nil
  end
  
end














