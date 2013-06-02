#include once "ext/tests.bi"
#include once "ext/file/file.bi"

namespace ext.tests.file_

    const as string test_filename = "fbexttest.tst"

    private sub create_file
        var ff = freefile
        var ret = open( test_filename, for output, access write, as #ff )
        ext_assert_TRUE_ERROR( ret = 0 )
        for n as integer = 0 to 9
            print #ff, "Line " & n
        next
        close #ff
    end sub

    private sub test_readline
        var x = new ext.File(test_filename)
        ext_assert_TRUE_ERROR( x <> 0 )
        ext_assert_FALSE( x->open() )
        for n as integer = 0 to 9
            ext_assert_STRING_EQUAL( "Line " & n, x->readLine() )
        next
        delete x
    end sub

    private sub kill_file
        kill test_filename
    end sub

    private sub register constructor
        ext.tests.addSuite("ext-file-class")
        ext.tests.addSuiteHook(ext.tests.Hook.before_all,@create_file)
        ext.tests.addSuiteHook(ext.tests.Hook.after_all,@kill_file)
        ext.tests.addTest("reading lines", @test_readline)
    end sub

end namespace
