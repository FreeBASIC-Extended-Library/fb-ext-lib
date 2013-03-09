# define fbext_NoBuiltinInstanciations() 1
# include once "ext/testly.bi"
# include once "ext/containers/array.bi"

fbext_Instanciate( fbext_Array, ((integer)) )

namespace ext.tests.containers

    private sub Testsort

        var array = fbext_Array( ((integer)) )( 10 )
        var i = 0
        for n as integer = 9 to 0 step -1
            *(array.at(i)) = n
            i+=1
        next

        array.sort()

        for n as integer = 0 to 9
            TESTLY_ASSERT_EQUAL( n, *array.at(n) )
        next

    end sub

    private sub Testsort_range

        var array = fbext_Array( ((integer)) )( 10 )
        var i = 0
        for n as integer = 9 to 0 step -1
            *(array.at(i)) = n
            i +=1
        next

        array.sort(array.Front()+3)

        TESTLY_ASSERT_EQUAL( 9, *array.at(0) )
        TESTLY_ASSERT_EQUAL( 8, *array.at(1) )
        TESTLY_ASSERT_EQUAL( 7, *array.at(2) )

        for n as integer = 0 to 6
            TESTLY_ASSERT_EQUAL( n, *array.at(n+3) )
        next

    end sub

    private sub register constructor
        ext.testly.addSuite("ext-containers-array-sort")
        ext.testly.addTest("Array Sort", @Testsort)
        ext.testly.addTest("Array Range Sort", @Testsort_range)
    end sub

end namespace
