require 'nokogiri'
require 'open-uri'
require 'bundler'
Bundler.require

page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/landes.html"))
links = page.css("a.lientxt")
liste = links.each{|departement|
# la method "a" ne sert pas mais "http://annuaire-des-mairies.com" ne répondait plus au moment où j'ai voulu l'enlever :'(
	a = "http://annuaire-des-mairies.com" + departement['href'].slice!(1..33)
	c = departement.text
# puts c et b est pour éviter le 'timeout' mais je n'ai pas plus tester comme plus haut
	puts c

mailv = Nokogiri::HTML(open(a))
mailv.css('p:contains("@")').each do |node|
	b = node.text
	puts b

session = GoogleDrive::Session.from_service_account_key("client_secret.json")

spreadsheet = session.spreadsheet_by_title("autres test THP")

worksheet = spreadsheet.worksheets.first

worksheet.insert_rows(worksheet.num_rows + 1, [[c, b]])
worksheet.save

end
}
