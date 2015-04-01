# coding : UTF-8
require 'active_record'
require './lib/arxiv'
require './lib/model/paper'

config = YAML.load_file('./database.yml')
ActiveRecord::Base.establish_connection(config["db"]["development"])
I18n.enforce_available_locales = false
=begin
module ArXiv
  class Entry
    def add_to_db
      Paper.create(
        title: title,
        abstract: summary,
        link_pdf: link_pdf,
        published: published      
      )
    end
  end
end
=end
hash = {
  search_query: 'cat:math.GT',
  start: 0,
  max_results: 1000,
  sort_by: 'lastUpdatedDate',
  sort_order: 'descending' 
}

ArXiv::get(hash, :it).each(&:add_to_db)

=begin
`
sqlite3 arxiv.sqlite3
.read imoprt.sql

`
=end
