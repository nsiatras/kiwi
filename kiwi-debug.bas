#include once "kiwi\kiwi.bi"
#include once "kiwi\locale.bi"

Dim byref isoCountries as ArrayList(Country) = Locale.getISOCountries()

for i as Integer = 0 to isoCountries.size() - 1
	print i & " " & isoCountries.get(i).getName() & ", " & isoCountries.get(i).getISOCode()
next
