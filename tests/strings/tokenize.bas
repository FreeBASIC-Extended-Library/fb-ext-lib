# include once "ext/testly.bi"
# include once "ext/strings.bi"

namespace ext.tests.strings

	private sub test_token

		var test_string = "This is, a	test."
		var delimiters = !" \t,."

		dim as ubyte what = 0
		var n = 1
		var t = ext.strings.tokenize(test_string, delimiters, @what)

		while t <> ""
			select case n
			case 1
				TESTLY_ASSERT_STRING_EQUAL( "This", t )
				TESTLY_ASSERT_TRUE( asc(" ") = what )
			case 2
				TESTLY_ASSERT_STRING_EQUAL( "is", t )
				TESTLY_ASSERT_TRUE( asc(",") = what )
			case 3
				TESTLY_ASSERT_STRING_EQUAL( "a", t )
				TESTLY_ASSERT_TRUE( asc(!"\t") = what )
			case 4
				TESTLY_ASSERT_STRING_EQUAL( "test", t )
				TESTLY_ASSERT_TRUE( asc(".") = what )
			end select

			t = ext.strings.tokenize(, delimiters, @what)
			n += 1
		wend

	end sub

	private sub test_token_no_eat

		var test_string = "testing. extlib, "
		var delimiters = "., "

		dim as ubyte what = 0
		var n = 1

		var t = ext.strings.tokenize(test_string, delimiters, @what, false)

		while what <> 0

			select case n
			case 1
				TESTLY_ASSERT_STRING_EQUAL( "testing", t )
				TESTLY_ASSERT_TRUE( asc(".") = what )
			case 2
				TESTLY_ASSERT_STRING_EQUAL( "", t )
				TESTLY_ASSERT_TRUE( asc(" ") = what )
			case 3
				TESTLY_ASSERT_STRING_EQUAL( "extlib", t )
				TESTLY_ASSERT_TRUE( asc(",") = what )
			case 4
				TESTLY_ASSERT_STRING_EQUAL( "", t )
				TESTLY_ASSERT_TRUE( asc(" ") = what )
			case else
				TESTLY_ASSERT_FAIL("test-token-no-eat should not have more than 4 iterations")
			end select

			t = ext.strings.tokenize(, delimiters, @what, false)
			n += 1
		wend

	end sub

	private sub register constructor
		ext.testly.addSuite("ext-strings-tokenize")
		ext.testly.addTest("tokenize", @test_token)
		ext.testly.addTest("tokenize-no-eat",@test_token_no_eat)
	end sub

end namespace
