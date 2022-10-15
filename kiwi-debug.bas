#include once "kiwi\kiwi.bi"
#include once "kiwi\time.bi" 

' The following timestamp is from Wed Sep 28 2022 06:40:39 UTC +0
Dim timeStampUTC as LongInt = 1664347239101

' Print the utcTime
Dim utcTime as DateTime = DateTime(timeStampUTC, 0) ' UTC +0

' Full date time with AM/PM and UTC TimeZone
Dim sdf as SimpleDateFormat = SimpleDateFormat("dddd dd mmm yyyy h:n:s AM/PM UTC")
print sdf.formatDateTime(utcTime)

' Date-Time (24 Hours Time)
sdf.setPattern("dd/mm/yyyy H:n:s")
print sdf.formatDateTime(utcTime)

' Date only
sdf.setPattern("dd/mm/yyyy")
print sdf.formatDateTime(utcTime)
