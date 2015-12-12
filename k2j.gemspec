lib = File.join(File.dirname(__FILE__), 'lib')
$:.unshift lib unless $:.include?(lib)

require 'k2j/version'

Gem::Specification.new do |s|
  s.date        = Date.today.to_s
  s.name        = 'k2j'
  s.version     = K2J::VERSION
  s.licenses    = ['MIT']
  s.summary     = 'Hangul to hiragana.'
  s.description = "Hangul to hiragana."
  s.authors     = ["SuHun Han (ssut)"]
  s.email       = 'ssut@ssut.me'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'https://github.com/ssut/k2j.rb'
end
