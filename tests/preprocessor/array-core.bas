# include once "ext/tests.bi"
# include once "ext/preprocessor/array/size.bi"
# include once "ext/preprocessor/array/data.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.array_.size

	private sub test

		# define ARRAY0 (0, ())
		# define ARRAY1 (1, (a))
		# define ARRAY2 (2, (a, b))

		ext_assert_TRUE( 0 = fbextPP_ArraySize(ARRAY0) )
		ext_assert_TRUE( 1 = fbextPP_ArraySize(ARRAY1) )
		ext_assert_TRUE( 2 = fbextPP_ArraySize(ARRAY2) )

	end sub

end namespace

namespace ext.tests.preprocessor.array_.data_

	private sub test

		# define ARRAY0 (0, ())
		# define ARRAY1 (1, (a))
		# define ARRAY2 (2, (a, b))

		ext_assert_TRUE( "()" = FBEXT_PP_STRINGIZE(fbextPP_ArrayData(ARRAY0)) )
		ext_assert_TRUE( "(a)" = FBEXT_PP_STRINGIZE(fbextPP_ArrayData(ARRAY1)) )
		ext_assert_TRUE( "(a, b)" = FBEXT_PP_STRINGIZE(fbextPP_ArrayData(ARRAY2)) )

	end sub

end namespace

namespace ext.tests.preprocessor.array_

	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-array-core")
		ext.tests.addTest("size.test", @size.test)
		ext.tests.addTest("data_.test", @data_.test)
	end sub

end namespace
