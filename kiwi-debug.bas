#include once "kiwi\kiwi.bi"
#include once "kiwi\time.bi" 

' The following timestamp is from Wed Sep 28 2022 06:40:39 UTC +0
Dim timeStampUTC as LongInt = 1664347239101

' Add time to timeStampUTC 
Dim utcTime as DateTime = DateTime(timeStampUTC, 0)

utcTime.add(DateTime.YEAR, 10)
utcTime.add(DateTime.MONTH, 2)
utcTime.add(DateTime.WEEK, 2)
utcTime.add(DateTime.DAY, 5)
utcTime.add(DateTime.HOUR, 4)
utcTime.add(DateTime.MINUTE, 45)
utcTime.add(DateTime.SECOND, 10)
utcTime.add(DateTime.MILLISECOND, 20)

print utcTime.toString() ' This prints Fri Dec 17 2032 11:25:49 UTC +0






