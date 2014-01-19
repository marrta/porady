require 'sinatra'
require 'open-uri'
require 'nokogiri'

get '/' do
	erb :index
end

get '/szukaj' do
	@keyword = params['keyword']

	@result_poradnia = result("http://poradnia.pwn.pl/lista.php?szukaj=", "ISO-8859-2", '#listapytan')
	@result_uz = result("http://www.poradnia-jezykowa.uz.zgora.pl/wordpress/?s=", "UTF-8", "#content")
	@result_wsjp = result("http://www.wsjp.pl/index.php?szukaj=", "UTF-8", ".wyszukiwanie_wyniki .wyszukiwanie_wyniki")
	@result_sjp = result("http://sjp.pwn.pl/szukaj/", "UTF-8", "#tresc")

	erb :szukaj
end
 
def result(url_base, encoding, selector)
	url = url_base + URI.encode(@keyword.encode(encoding))
	doc = Nokogiri.HTML(open(url))
	result = doc.at_css(selector).to_s.encode("UTF-8")	
end
