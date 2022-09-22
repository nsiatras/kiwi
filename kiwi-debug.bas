#include once "kiwi\kiwi.bi"

Dim stringArray(0 to 2) as String
stringArray(0) = "Welcome"
stringArray(1) = "to"
stringArray(2) = "FreeBasic !"

' Join the array and print it on screen
print StringUtils.Join(stringArray() , ",")
