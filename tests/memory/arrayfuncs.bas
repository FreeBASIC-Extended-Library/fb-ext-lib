#include once "ext/tests.bi"
#include once "ext/memory/arrays.bi"

fbext_instanciate(fbext_pushArray,((integer)))
fbext_instanciate(fbext_sliceArray,((integer)))
fbext_instanciate(fbext_copyArray,((integer)))
fbext_instanciate(fbext_remove_i_from_array,((integer)))

namespace ext.tests.memory.array

private sub test_array_push

    dim testarr() as integer

    for n as integer = 0 to 4
        pushArray(n,testarr())
    next

    for n as integer = 0 to 4
        EXT_ASSERT_TRUE(n = testarr(n))
    next

end sub

private sub test_array_slice

    dim arr1(0 to 9) as integer
    dim arr2() as integer

    for n as integer = 0 to 9
        arr1(n) = n
    next

    sliceArray(arr1(),arr2(),5,9)

    for n as integer = lbound(arr2) to ubound(arr2)
        EXT_ASSERT_TRUE((n+5) = arr2(n))
    next

end sub

private sub test_copy_array

    dim arr1(0 to 4) as integer
    dim arr2() as integer

    for n as integer = 0 to 4
        arr1(n) = n
    next

    copyArray(arr1(),arr2(),5)

    for n as integer = 0 to 4
        EXT_ASSERT_TRUE(n = arr2(n))
    next

end sub

private sub test_remove_i

    dim arr() as integer
    redim arr(0 to 2) as integer

    for n as integer = 0 to 2
        arr(n) = n
    next

    remove_i_from_array(1,arr())

    EXT_ASSERT_TRUE(0 = arr(0))
    EXT_ASSERT_TRUE(2 = arr(1))

end sub

private sub register constructor
    ext.tests.addSuite("ext-memory-arrayfuncs")
    ext.tests.addTest("array-push", @test_array_push)
    ext.tests.addTest("array-slice", @test_array_slice)
    ext.tests.addTest("array-copy", @test_copy_array)
    ext.tests.addTest("array-remove-i", @test_remove_i)
end sub

end namespace
