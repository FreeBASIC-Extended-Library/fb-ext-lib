# define fbext_NoBuiltinInstanciations() 1
# include once "ext/testly.bi"

# include once "ext/containers/list.bi"

fbext_Instanciate(fbext_List, ((integer)))

namespace ext.tests.containers

	private sub testEmpty

		var list = fbext_List( ((integer)) )

		TESTLY_ASSERT_TRUE( list.Empty() )

		list.PushBack(1)

		TESTLY_ASSERT_TRUE( not list.Empty() )

	end sub

	private sub register constructor
		ext.testly.addSuite("ext-containers-list-empty")
		ext.testly.addTest("testEmpty", @testEmpty)
	end sub

end namespace
