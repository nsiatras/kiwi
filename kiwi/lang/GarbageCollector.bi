/'
	MIT License

	Copyright (c) 2022 Nikos Siatras

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
'/

/'
	Description: Kiwi's garbage collector
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Declare an alias Type of KObject in order to make the cross reference
' between GarbageCollector and KObject Possible.
Type as KObject _KObject
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Type GarbageCollector extends Object
        	
    private:
		Static fLiveObjects(any) as _KObject Pointer ' Holds the pointers of live KObjects
		Static fObjectsCount as UInteger
				
    public:
        Declare Static Sub RegisterObject(obj as _KObject)
        Declare Static Sub DeleteObject(obj as _KObject)
        Declare Static Sub UpdateKObjects(id as UInteger,obj as _KObject)
End Type


#macro MACRO_DefineGarbageCollectorMethods()
	#ifndef GARBAGE_COLLECTOR_METHODS_DEFINED
	
		Dim GarbageCollector.fLiveObjects(any) as _KObject Pointer 
		Dim GarbageCollector.fObjectsCount as UInteger = 0
		
		/'
			Ask GarbageCollector to register a new KObject
		'/
		Sub GarbageCollector.RegisterObject(obj as KObject)
			
			' Get the pointer of obj
			Dim p As KObject Pointer = @obj
			
			'Add the pointer to the GarbageCollector.fLiveObjects array
			GarbageCollector.fObjectsCount += 1
			redim preserve GarbageCollector.fLiveObjects(GarbageCollector.fObjectsCount)
			GarbageCollector.fLiveObjects(GarbageCollector.fObjectsCount - 1) =  p
			
			'print "KObject " & obj.getUniqueID() & " registered"
			
		End Sub

		/'
			Ask GarbageCollector to remove a KObject 
		'/
		Sub GarbageCollector.DeleteObject(obj as KObject)
			
			for i as Integer = 0 to GarbageCollector.fObjectsCount - 1	
				if (*GarbageCollector.fLiveObjects(i)).getUniqueID = obj.getUniqueID() then
				
				endif
			next i
			
			'print "Object " & obj.getUniqueID() & " deleted"
		End Sub
		
		/'
			Finds all KObjects with KObject.getUniqueID() = id and
			makes them equal to obj
		'/
		Sub GarbageCollector.UpdateKObjects(id as UInteger, obj as KObject)
			
			for i as Integer = 0 to GarbageCollector.fObjectsCount - 1	
				if (*GarbageCollector.fLiveObjects(i)).getUniqueID = obj.getUniqueID() AND @(*GarbageCollector.fLiveObjects(i)) <> @obj  then
					(*GarbageCollector.fLiveObjects(i)).setData(obj)
				endif
			next i
			
		End Sub
		
		#define GARBAGE_COLLECTOR_METHODS_DEFINED
	#endif
#endmacro

