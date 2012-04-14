# define fbext_NoBuiltinInstanciations() 1
# include once "ext/testly.bi"

# include once "ext/containers/list.bi"

fbext_Instanciate(fbext_List, ((string)))

namespace ext.tests.containers

    private sub testSimple

        var list = ext.fbext_List( ((string)) )

        list.PushBack("one")
        list.PushBack("two")

        TESTLY_ASSERT_STRING_EQUAL( "one", *list.cFront() )
        TESTLY_ASSERT_STRING_EQUAL( "two", *list.cBack() )

    end sub

	private sub register constructor
		ext.testly.addSuite("ext-containers-list-string")
		ext.testly.addTest("testSimple", @testSimple)
	end sub

end namespace
