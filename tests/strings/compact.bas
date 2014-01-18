#include once "ext/tests.bi"
#include once "ext/strings.bi"

testltstr:

DATA "testing",         !"   \t\ttesting"
DATA "testing ",        "testing "
DATA "testing",         "testing"
DATA "one ring to",     "  one ring to"
DATA "rule them all",   !" \t    rule them all"
DATA "."

testrtstr:

DATA "and in the",      "and in the    "
DATA "darkness",        !"darkness \t"
DATA "bind them",       "bind them"
DATA " testing",        " testing"
DATA "llama",           !"llama \t   "
DATA "."

testtstr:

DATA "i",               "   i "
DATA "love",            !" \tlove      \t\t"
DATA "my wife",         "my wife"
DATA "testing",         " testing "
DATA "test 1 2 3",      " test 1 2 3  "
DATA "b-i-n-g-o",       !"\vb-i-n-g-o\v"
DATA "lemurs",          !"\rlemurs\r\n"
DATA "yo gabba",        !"     \nyo gabba \t"
DATA "."

testcompact:

DATA "i like cheese",   "i     like   cheese"
DATA "badger badger",   !"badger \t badger"
DATA "badger badger",   "badger badger"
DATA "mushroom mushroom","mushroom          mushroom"
DATA !"t\tt",!"t\t\tt"
DATA "."

namespace ext.tests.strings.compact_

private sub test_ltrimall
    restore testltstr
    dim as string sWanted, sValue
    read sWanted
    while sWanted <> "."
        read sValue
        var t = ext.strings.ltrimall(sValue)
        EXT_ASSERT_STRING_EQUAL(t,sWanted)
        read sWanted
    wend
end sub

private sub test_rtrimall
    restore testrtstr
    dim as string sWanted, sValue
    read sWanted
    while sWanted <> "."
        read sValue
        var t = ext.strings.rtrimall(sValue)
        EXT_ASSERT_STRING_EQUAL(t,sWanted)
        read sWanted
    wend
end sub

private sub test_trimall
    restore testtstr
    dim as string sWanted, sValue
    read sWanted
    while sWanted <> "."
        read sValue
        var t = ext.strings.trimall(sValue)
        EXT_ASSERT_STRING_EQUAL(t,sWanted)
        read sWanted
    wend
end sub

private sub test_compact
    restore testcompact
    dim as string sWanted, sValue
    read sWanted
    while sWanted <> "."
        read sValue
        var t = ext.strings.compact(sValue)
        EXT_ASSERT_STRING_EQUAL(t,sWanted)
        read sWanted
    wend
end sub

private sub register constructor
    ext.tests.addSuite("ext-strings-compact")
    ext.tests.addTest("ltrimall",@test_ltrimall)
    ext.tests.addTest("rtrimall",@test_rtrimall)
    ext.tests.addTest("trimall",@test_trimall)
    ext.tests.addTest("compact",@test_compact)
end sub

end namespace
