# define fbext_NoBuiltinInstanciations() 1
# include once "ext/tests.bi"
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
            ext_assert_EQUAL( n, *array.at(n) )
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

        ext_assert_EQUAL( 9, *array.at(0) )
        ext_assert_EQUAL( 8, *array.at(1) )
        ext_assert_EQUAL( 7, *array.at(2) )

        for n as integer = 0 to 6
            ext_assert_EQUAL( n, *array.at(n+3) )
        next

    end sub

    private sub register constructor
        ext.tests.addSuite("ext-containers-array-sort")
        ext.tests.addTest("Array Sort", @Testsort)
        ext.tests.addTest("Array Range Sort", @Testsort_range)
    end sub

end namespace
