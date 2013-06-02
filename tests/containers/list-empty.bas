# define fbext_NoBuiltinInstanciations() 1
# include once "ext/tests.bi"

# include once "ext/containers/list.bi"

fbext_Instanciate(fbext_List, ((integer)))

namespace ext.tests.containers

	private sub testEmpty

		var list = fbext_List( ((integer)) )

		ext_assert_TRUE( list.Empty() )

		list.PushBack(1)

		ext_assert_TRUE( not list.Empty() )

	end sub

	private sub register constructor
		ext.tests.addSuite("ext-containers-list-empty")
		ext.tests.addTest("testEmpty", @testEmpty)
	end sub

end namespace
