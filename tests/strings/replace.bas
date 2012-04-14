# include once "ext/testly.bi"
# include once "ext/strings.bi"

namespace ext.tests.strings

	type TestInput
		subject as const zstring ptr
		oldtext as const zstring ptr
		newtext as const zstring ptr
		result as const zstring ptr
	end type
	
	private sub testEqualNewText
	
		dim test_input(1 to 4) as TestInput = _
		{ _
			( @"a", 		@"a", 		@"x", 	@"x" )			, _
			( @"aa", 		@"a", 		@"x", 	@"xx" )		, _
			( @"aa..a.",	@"a", 		@"x", 	@"xx..x." )		, _
			( @".a..aa",	@"a", 		@"x", 	@".x..xx" )		_
		}
		
		var subject = ""
		
		for i as integer = lbound(test_input) to ubound(test_input)
			subject = *test_input(i).subject
			ext.strings.Replace(subject, _
				*test_input(i).oldtext, _
				*test_input(i).newtext _
			)
			TESTLY_ASSERT_STRING_EQUAL(*test_input(i).result, subject)
		next
	
	end sub
	
	private sub testSmallerNewText
	
		dim test_input(1 to 4) as TestInput = _
		{ _
			( @"[a]", 			@"[a]", 	@"x", 	@"x" )			, _
			( @"[a][a]", 		@"[a]", 	@"x", 	@"xx" )			, _
			( @"[a][a]..[a].",	@"[a]", 	@"x", 	@"xx..x." )		, _
			( @".[a]..[a][a]",	@"[a]", 	@"x", 	@".x..xx" )		_
		}
		
		var subject = ""
		
		for i as integer = lbound(test_input) to ubound(test_input)
			subject = *test_input(i).subject
			ext.strings.Replace(subject, _
				*test_input(i).oldtext, _
				*test_input(i).newtext _
			)
			TESTLY_ASSERT_STRING_EQUAL(*test_input(i).result, subject)
		next
	
	end sub
	
	private sub testLargerNewText
	
		dim test_input(1 to 4) as TestInput = _
		{ _
			( @"a", 		@"a", 	@"[x]", 	@"[x]" )			, _
			( @"aa", 		@"a", 	@"[x]", 	@"[x][x]" )			, _
			( @"aa..a.",	@"a", 	@"[x]", 	@"[x][x]..[x]." )	, _
			( @".a..aa",	@"a", 	@"[x]", 	@".[x]..[x][x]" )	_
		}
		
		var subject = ""
		
		for i as integer = lbound(test_input) to ubound(test_input)
			subject = *test_input(i).subject
			ext.strings.Replace(subject, _
				*test_input(i).oldtext, _
				*test_input(i).newtext _
			)
			TESTLY_ASSERT_STRING_EQUAL(*test_input(i).result, subject)
		next
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-strings-replace")
		ext.testly.addTest("testEqualNewText", @testEqualNewText)
		ext.testly.addTest("testSmallerNewText", @testSmallerNewText)
		ext.testly.addTest("testLargerNewText", @testLargerNewText)
	end sub

end namespace
