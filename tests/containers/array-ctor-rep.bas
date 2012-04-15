# define fbext_NoBuiltinInstanciations() 1
# include once "ext/testly.bi"
# include once "ext/containers/array.bi"

fbext_Instanciate( fbext_Array, ((integer)) )

namespace ext.tests.containers

	private sub Test0
	
		var array = fbext_Array( ((integer)) )( 0, 420 )
		TESTLY_ASSERT_EQUAL( 0, array.Size() )
		TESTLY_ASSERT_EQUAL( 0, array.Capacity() )
	
	end sub

	private sub Test1
	
		var array = fbext_Array( ((integer)) )( 1, 420 )
		TESTLY_ASSERT_EQUAL( 1, array.Size() )
		TESTLY_ASSERT_EQUAL( 420, *array.Front() )
	
	end sub

	private sub register constructor
		ext.testly.addSuite("ext-containers-array-ctor-rep")
		ext.testly.addTest("Test0", @Test0)
		ext.testly.addTest("Test1", @Test1)
	end sub

end namespace
