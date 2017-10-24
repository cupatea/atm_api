Banknote.kinds.each do |key,value|
  Banknote.create kind: key, quantity: 10
end  
