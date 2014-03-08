require 'sinatra'
require 'open-uri'
require 'nokogiri'

Advice = Struct.new(:source, :text, :title, :date)
Source = Struct.new(:name, :url_base, :selector, :encoding)

SOURCES = [
	Source.new('PWN', 'http://poradnia.pwn.pl/lista.php?szukaj=', '#listapytan li', 'ISO-8859-2'),
	Source.new('UZ', 'http://www.poradnia-jezykowa.uz.zgora.pl/wordpress/?s=', 'article', 'UTF-8'),
	Source.new('WSJP', 'http://www.wsjp.pl/index.php?szukaj=', '.wyszukiwanie_wyniki .wyszukiwanie_wyniki a', 'UTF-8'),
	Source.new('SJP', 'http://sjp.pwn.pl/szukaj/', '#listahasel li', 'UTF-8')
]


get '/' do
	erb :index
end

get '/szukaj' do
	@keyword = params['keyword']

	@results = []
	SOURCES.each do |source|
		@results = @results + collection(source)
	end
	
	erb :szukaj
end
 
def collection(source)
	url = source.url_base + URI.encode(@keyword.encode(source.encoding))
	doc = Nokogiri.HTML(open(url))
	result = doc.css(source.selector)
end
