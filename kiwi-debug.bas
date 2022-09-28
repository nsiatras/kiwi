#include once "kiwi\kiwi.bi"
#include once "kiwi\time.bi" 

' The following timestamp is from Wed Sep 28 2022 06:40:39 UTC +0
Dim timeStampUTC as LongInt = 1664347239101

' Print the utcTime
Dim utcTime as DateTime = DateTime(timeStampUTC,0)
print utcTime.toString()

' Convert the timeStampUTC to Athens/Greece timezone and print to console
Dim timeInAthens as DateTime = DateTime(timeStampUTC, 3)
print timeInAthens.toString()



