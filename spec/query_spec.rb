require 'spec_helper.rb'

# TODO: ()を%28%29へ直す
describe ArXiv::Query do

  Query = ArXiv::Query
  it 'make simple query by string' do
    str = "math"
    expect(Query.new(str).to_query_string).to eq "all:%28%22math%22%29"
  end

  it 'make simple query' do
    k = "all"
    v = "math"
    expect(Query.new(k, v).to_query_string).to eq "all:%28%22math%22%29"
  end

  it 'make simple phrase query by string' do
    option = "up to homotopy"
    expect(Query.new(option).to_query_string).to eq "all:%28%22up to homotopy%22%29"
  end

  it 'make simple phrase query' do
    option = {all: "up to homotopy"}
    expect(Query.new(option).to_query_string).to eq "all:%28%22up to homotopy%22%29"
  end

  it 'make query with several words' do
    option = {all: %w{math topology}}
    expect(Query.new(option).to_query_string).to eq "all:%28%22math%22+AND+%22topology%22%29"
  end

  it 'is composable' do
    expect(Query.new("math").and(Query.new("physics")).to_query_string).to eq "%28all:%28%22math%22%29%29+AND+%28all:%28%22physics%22%29%29"
    expect(Query.new("math").or(Query.new("physics")).to_query_string).to eq "%28all:%28%22math%22%29%29+OR+%28all:%28%22physics%22%29%29"
    expect(Query.new("math").andnot(Query.new("physics")).to_query_string).to eq "%28all:%28%22math%22%29%29+ANDNOT+%28all:%28%22physics%22%29%29"
  end
end

