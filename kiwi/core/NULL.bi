#undef NULL

Type nullA extends Object 
	protected:
		Dim fCount as UInteger = 0 
	public:
		declare constructor()
End Type

constructor nullA()
	fCount = 0
end constructor
