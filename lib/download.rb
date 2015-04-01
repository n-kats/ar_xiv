
module ArXivDL
  def dl_pdf
    filename = "#{authors.map{|au|au[0]}.join.upcase.strip}  #{title} #{File.basename link_pdf}"
    filename += '.pdf' unless filename =~ /\.pdf$/
    filename.gsub!(/[\\,\/,:,\*,\?,",<,>,\|]/, '_')
    # 使えない文字 \  / : * ? " < > |
    lk = link_pdf
    lk += '.pdf' unless lk =~ /\.pdf$/
    url = URI.parse lk
    File.open(filename, 'wb') do |f|
      f.write(Net::HTTP.get url)
    end
  end    
end
