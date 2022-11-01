#include once "kiwi\kiwi.bi"
#include once "kiwi\net.bi" 

Dim address as URL = URL("https://freebasic.net/wiki/DocToc")

print "Host:" & address.getHost()
print "Path:" & address.getPath()
print "Protocol:" & address.getProtocol()
