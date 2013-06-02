# include once "ext/tests.bi"
# include once "ext/strings.bi"

namespace ext.tests.strings

	private function reverse_and_check overload (byref s as string, byref target as string) as ext.bool
	
		ext.strings.reverse(s)
		return s = target
	
	end function
	
	private sub test_reverse_string
	
		ext_assert_TRUE( reverse_and_check("", "")         )
		ext_assert_TRUE( reverse_and_check("a", "a")       )
		ext_assert_TRUE( reverse_and_check("ab", "ba")     )
		ext_assert_TRUE( reverse_and_check("abc", "cba")   )
		ext_assert_TRUE( reverse_and_check("abcd", "dcba") )
	
	end sub
	
	private function reverse_and_check (s() as string, target() as string) as ext.bool
	
		ext.strings.reverse(s())
		for i as integer = lbound(s) to ubound(s)
			if s(i) <> target(i) then return ext.false
		next
		return ext.true
	
	end function
	
	private sub test_reverse_array
	
		dim s0(0) as string = { "" }
		dim t0(0) as string = { "" }
		ext_assert_TRUE( reverse_and_check(s0(), t0()) )
	
		dim s1(0) as string = { "abc" }
		dim t1(0) as string = { "cba" }
		ext_assert_TRUE( reverse_and_check(s1(), t1()) )
		
		dim s2(1) as string = { "abc", "abc" }
		dim t2(1) as string = { "cba", "cba" }
		ext_assert_TRUE( reverse_and_check(s2(), t2()) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-strings-reverse")
		ext.tests.addTest("reverse-string", @test_reverse_string)
		ext.tests.addTest("reverse-array", @test_reverse_array)
	end sub

end namespace
