#include once "kiwi\kiwi.bi"
#include once "kiwi\time.bi" 

Dim dateTimeNow as DateTime = DateTime(System.currentTimeMillis())

print dateTimeNow.toString() ' This prints current date and time
