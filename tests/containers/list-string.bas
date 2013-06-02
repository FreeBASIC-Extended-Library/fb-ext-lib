# define fbext_NoBuiltinInstanciations() 1
# include once "ext/tests.bi"

# include once "ext/containers/list.bi"

fbext_Instanciate(fbext_List, ((string)))

namespace ext.tests.containers

    private sub testSimple

        var list = ext.fbext_List( ((string)) )

        list.PushBack("one")
        list.PushBack("two")

        ext_assert_STRING_EQUAL( "one", *list.cFront() )
        ext_assert_STRING_EQUAL( "two", *list.cBack() )

    end sub

	private sub register constructor
		ext.tests.addSuite("ext-containers-list-string")
		ext.tests.addTest("testSimple", @testSimple)
	end sub

end namespace
