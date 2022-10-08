#include once "kiwi\kiwi.bi"
#include once "kiwi\locale.bi" ' Include Kiwi Locale package

Dim country as ISOCountry = Locale.getCountry("US")
print "Country Name:        " & country.getName()
print "3166 ISO Code:       " & country.getISOCode()
print "3 letter ISO Code:   " &country.getISO3Code()

