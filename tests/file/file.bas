#include once "ext/testly.bi"
#include once "ext/file/file.bi"

namespace ext.tests.file_

    const as string test_filename = "fbexttest.tst"

    private sub create_file
        var ff = freefile
        var ret = open( test_filename, for output, access write, as #ff )
        TESTLY_ASSERT_TRUE_ERROR( ret = 0 )
        for n as integer = 0 to 9
            print #ff, "Line " & n
        next
        close #ff
    end sub

    private sub test_readline
        var x = new ext.File(test_filename)
        TESTLY_ASSERT_TRUE_ERROR( x <> 0 )
        TESTLY_ASSERT_FALSE( x->open() )
        for n as integer = 0 to 9
            TESTLY_ASSERT_STRING_EQUAL( "Line " & n, x->readLine() )
        next
        delete x
    end sub

    private sub kill_file
        kill test_filename
    end sub

    private sub register constructor
        ext.testly.addSuite("ext-file-class")
        ext.testly.addSuiteHook(ext.testly.Hook.before_all,@create_file)
        ext.testly.addSuiteHook(ext.testly.Hook.after_all,@kill_file)
        ext.testly.addTest("reading lines", @test_readline)
    end sub

end namespace
