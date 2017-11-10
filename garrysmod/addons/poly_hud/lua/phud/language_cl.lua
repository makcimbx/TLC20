
-----------------------------------------------------
phud.language = { }
local phrases = { }
phud.language.phrases = phrases
phud.language.addPhrase = function(phrase, translation)
  phrases[phrase] = translation
end
phud.language.addPhrase = phud.curry(phud.language.addPhrase, 2)
phud.language.getPhrase = function(phrase)
  return phrases[phrase] or (error('phrase ' .. phrase .. ' not found :('))
end
