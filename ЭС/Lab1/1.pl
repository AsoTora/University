predicates
  nondeterm result
  nondeterm menu(integer)
  nondeterm selectMenu()
  nondeterm auto(string, real, string, integer)
  nondeterm printAllAutos(string, real, string, integer)

clauses

  result:- 
   selectMenu().
  
  selectMenu():-
   write("0 - Exit"), nl,
   write("1 - Select autos by Brand"), nl,
   write("2 - Select autos by Price"), nl,
   write("3 - Select autos by Country"), nl,
   write("4 - Select autos by Year"), nl,
   write("Select an option: "), readint(Option), nl, 
   menu(Option); nl,nl, selectMenu().
   
  menu(0). 
  menu(1):- 
   write("Enter Brand: "), 
   readln(Brand),
   printAllAutos(Brand, _, _, _).
  menu(2):- 
   write("Enter Price: "), 
   readreal(Price),
   printAllAutos(_, Price, _, _).
  menu(3):- 
   write("Enter Country: "), 
   readln(Country),
   printAllAutos(_, _, Country, _).
  menu(4):- 
   write("Enter Year: "), 
   readint(Year),
   printAllAutos(_, _, _, Year).
   
  printAllAutos(AutoBrand, AutoPrice, AutoCountry, AutoYear):- 
   auto(AutoBrand, AutoPrice, AutoCountry, AutoYear), nl, 
   write("Brand: ", AutoBrand, " Price: ", AutoPrice, " Country: ", AutoCountry, " Year: ", AutoYear),
   fail.

  auto("BMW", 30000.0, "Germany", 2015).
  auto("BMW", 50000.0, "Germany", 2019).
  auto("BMW", 20000.0, "USA", 2019).
  auto("Mersedes", 50000.0, "Germany", 2010).
  auto("Mersedes", 70000.0, "USA", 2019).
  auto("Mersedes", 65000.0, "Germany", 2019).
  auto("LADA", 10000.0, "Russia", 2015).
  auto("Citroen", 20000.0, "France", 2017).

goal

  result.