# include once "ext/tests.bi"
# include once "ext/strings.bi"

namespace ext.tests.strings

    private sub test_insertinto

        ext_assert_TRUE("Ext insert rocks!" = ext.strings.InsertInto(" insert", "Ext rocks!", 3))
        ext_assert_TRUE("You can even prepend strings!" = ext.strings.InsertInto("You can", " even prepend strings!", 0))
        ext_assert_TRUE("Or even append them!" = ext.strings.InsertInto(" append them!", "Or even", 6))
        ext_assert_TRUE("You can even use negative indexing!" = ext.strings.InsertInto(" negative", "You can even use indexing!", -10))
        ext_assert_TRUE("Negative index can't go below zero when added to the string length" = ext.strings.InsertInto("Negative ", "index can't go below zero when added to the string length", -160))
    
    end sub

    private sub register constructor
        ext.tests.addSuite("ext-strings-insertinto")
        ext.tests.addTest("InsertInto", @test_insertinto)
    end sub

end namespace
