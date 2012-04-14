# include once "ext/testly.bi"
# include once "ext/preprocessor/array/size.bi"
# include once "ext/preprocessor/array/data.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.array_.size

	private sub test

		# define ARRAY0 (0, ())
		# define ARRAY1 (1, (a))
		# define ARRAY2 (2, (a, b))

		TESTLY_ASSERT_TRUE( 0 = fbextPP_ArraySize(ARRAY0) )
		TESTLY_ASSERT_TRUE( 1 = fbextPP_ArraySize(ARRAY1) )
		TESTLY_ASSERT_TRUE( 2 = fbextPP_ArraySize(ARRAY2) )

	end sub

end namespace

namespace ext.tests.preprocessor.array_.data_

	private sub test

		# define ARRAY0 (0, ())
		# define ARRAY1 (1, (a))
		# define ARRAY2 (2, (a, b))

		TESTLY_ASSERT_TRUE( "()" = FBEXT_PP_STRINGIZE(fbextPP_ArrayData(ARRAY0)) )
		TESTLY_ASSERT_TRUE( "(a)" = FBEXT_PP_STRINGIZE(fbextPP_ArrayData(ARRAY1)) )
		TESTLY_ASSERT_TRUE( "(a, b)" = FBEXT_PP_STRINGIZE(fbextPP_ArrayData(ARRAY2)) )

	end sub

end namespace

namespace ext.tests.preprocessor.array_

	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-array-core")
		ext.testly.addTest("size.test", @size.test)
		ext.testly.addTest("data_.test", @data_.test)
	end sub

end namespace
