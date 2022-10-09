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
	Description: KObject is the building block of Kiwi. 
	Every User Defined Type (UDT) must inherit KObject in order to work
	properly with collections and other Kiwi's features.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/
#include once "GarbageCollector.bi"
#include once "KiwiCallbackManager.bi"
#include once "fbthread.bi"

Type KObject extends Object

	private:
		Dim fID as UInteger
		Dim fKObjectLock As Any Ptr = 0 
		Dim fNotifySignalThreshold As Any Ptr = 0
		Dim fNotified as Boolean = false

		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' KObject ID/HashCodeCounter
		static KIWI_Hash_Code_Counter as UInteger
		declare static function GET_HASH_CODE() as UInteger
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		
	public:
		declare constructor()						' Constructor
		declare destructor()						' Destructor
		
		#ifdef USE_GARBAGE_COLLECTOR
		declare operator let(value as KObject)
		#endif
		
		declare sub wait()
		declare sub wait(ms as LongInt)
		declare sub notify()
				
		declare virtual function toString() as String
		declare function getUniqueID() as UInteger	

End Type

' Include Thread and Threads Manager here in order to make the 
' cross reference possible
#include once "Thread.bi"
#include once "ThreadsManager.bi"

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' CAUTION: Define/Declare Garbage Collector Methods here!
MACRO_DefineGarbageCollectorMethods()
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

/'
	KObject's Constructor
'/
constructor KObject()
	' Assign a Unique ID to this KObject
	this.fID = KObject.GET_HASH_CODE()
	this.fKObjectLock = MutexCreate()
			
	#ifdef USE_GARBAGE_COLLECTOR
		' Tell GC to Register the Object
		GarbageCollector.RegisterObject(this)
	#endif
end constructor

/'
	KObject's Destructor
'/
destructor KObject()
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	' Destroy the mutex 
	if this.fKObjectLock > 0  then
		this.fKObjectLock = 0
		Mutexdestroy(this.fKObjectLock)
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	' Destroy the condition signal fNotifySignalThreshold
	if this.fNotifySignalThreshold <> 0 then
		CondDestroy(this.fNotifySignalThreshold)
	end if
	
	#ifdef USE_GARBAGE_COLLECTOR
		' Tell GC to Delete the Object
		GarbageCollector.DeleteObject(this)
	#endif
	
end destructor

/'
	Equal Operator
	Checks whether two objects are from the same reference
'/
operator = (a as KObject, b as KObject) as Integer
	return a.getUniqueID() = b.getUniqueID()
end operator

#ifdef USE_GARBAGE_COLLECTOR
/'
	Let Operator of KObject
'/
operator KObject.let(value as KObject)
	if this.getUniqueID() <> value.getUniqueID() then
		' Tell GarbageCollector to update all KObjects, with the same
		' Unique ID, to value.
		GarbageCollector.UpdateKObjects(this.getUniqueID(), value, this)
		this.fID = value.getUniqueID()
		this = value
	end if
end operator
#endif

/'
	Causes the current thread to wait until it is awakened, 
	typically by being notified or interrupted.
'/
sub KObject.wait()
	MutexLock(this.fKObjectLock)
		this.fNotifySignalThreshold = CondCreate
		this.fNotified = false
		Condwait(fNotifySignalThreshold, this.fKObjectLock)
	MutexUnLock(this.fKObjectLock)
end sub


sub KObject.wait(ms as LongInt)
	MutexLock(this.fKObjectLock)
		this.fNotifySignalThreshold = CondCreate
		this.fNotified = false
		
	
		' Ask KiwiCallbackManager to asynchronously call the "this.notify()"
		' method after a delay of ms Milliseconds
		'KiwiCallbackManager.AsynchronousSubCall(this.notify, ms)
		
		Condwait(fNotifySignalThreshold, this.fKObjectLock)
	MutexUnLock(this.fKObjectLock)
end sub

/'
	Wakes up a single thread that is waiting on this object's monitor. 
	If any threads are waiting on this object, one of them is chosen to 
	be awakened. The choice is arbitrary and occurs at the discretion of 
	the implementation. A thread waits on an object's monitor by calling 
	one of the wait methods.
'/
sub KObject.notify()
	MutexLock(this.fKObjectLock)
		this.fNotified = true
		if this.fNotifySignalThreshold <> 0 then
			CondSignal(fNotifySignalThreshold)
			MutexUnLock(this.fKObjectLock)
			exit sub
		end if
	MutexUnLock(this.fKObjectLock)
end sub

/'
	Returns a string representation of this KObject.
'/
function KObject.toString() as String
	return "KObj" & str(this.fID)
end function

/'
	Returns a unique UInteger ID of this KObject
'/
function KObject.getUniqueID() as UInteger
	return this.fID
end function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' KObject ID/HashCodeCounter
Dim Shared KIWI_Hash_Code_Counter_Lock as Any Ptr = 0
KIWI_Hash_Code_Counter_Lock = MutexCreate()
Dim KObject.KIWI_Hash_Code_Counter as UInteger = 0

/'
	USE ONLY WITH KObject CONSTRUCTOR !
	Adds 1 to KObject.Hash_Code_Counter and returns 
	KObject.Hash_Code_Counter.  
'/
function KObject.GET_HASH_CODE() as UInteger
	MutexLock(KIWI_Hash_Code_Counter_Lock)
	KObject.KIWI_Hash_Code_Counter += 1
	function = KObject.KIWI_Hash_Code_Counter
	MutexUnLock(KIWI_Hash_Code_Counter_Lock)
end function
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
