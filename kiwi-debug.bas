#include once "kiwi\kiwi.bi"
#include once "kiwi\time.bi" 

' The following timestamp is from Wed Sep 28 2022 06:40:39 UTC +0
Dim timeStampUTC as LongInt = 1664347239101

' Print the utcTime
Dim utcTime as DateTime = DateTime(timeStampUTC, 0)


utcTime.addYears(10)
utcTime.addDays(5)
utcTime.addHours(4)
utcTime.addMinutes(45)
utcTime.addSeconds(10)
utcTime.addMilliseconds(20)

print utcTime.toString() ' This prints Sun Oct 03 2032 11:25:49 UTC +0






