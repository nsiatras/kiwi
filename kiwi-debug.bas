#include once "kiwi\kiwi.bi"

Dim fStringToSplit as String = "Welcome###to###Free###Basic###!"
Dim fSplitParts () as String

' Splits  fStringToSplit using "###" as a delimeter
StringUtils.Split(fStringToSplit,"###",fSplitParts())

' Print the fSplitParts
for i as Integer = 0 to ubound(fSplitParts)
    print "Part no." & i & " = " & fSplitParts(i)
next


print StringUtils.Join(fSplitParts(),",")
