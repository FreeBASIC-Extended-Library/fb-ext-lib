#define fbext_NoBuiltinInstanciations() 1
#include once "ext/containers/list.bi"
#include once "vbcompat.bi"
using ext
'list example using a UDT

type USCurrency

    public:
    declare constructor () 'required by ext.List
    declare constructor ( byref cpy as const USCurrency ) 'required by ext.List, must be const parameter
    declare constructor ( byval dol as const uinteger, byval cnts as const uinteger ) 'required by ext.List, must be const parameter

    as uinteger dollars
    as uinteger cents

    declare operator cast() as string
    declare destructor()
end type

declare operator = ( byref lhs as USCurrency, byref rhs as USCurrency ) as integer
declare operator <> ( byref lhs as USCurrency, byref rhs as USCurrency ) as integer

constructor USCurrency()
    dollars = 0
    cents = 0
end constructor

destructor USCurrency()
    dollars = 0
    cents = 0
end destructor

constructor USCurrency( byref cpy as const USCurrency )
    dollars = cpy.dollars
    cents = cpy.cents
end constructor

constructor USCurrency( byval dol as const uinteger, byval cnts as const uinteger )
    dollars = dol
    dim as uinteger cnts_t = cnts
    while cnts_t > 99
        dollars += 1
        cnts_t -= 100
    wend
    cents = cnts_t
end constructor

operator = ( byref lhs as USCurrency, byref rhs as USCurrency ) as integer

    if lhs.dollars = rhs.dollars AND lhs.cents = rhs.cents then
        return true
    else
        return false
    end if

end operator

operator <> ( byref lhs as USCurrency, byref rhs as USCurrency ) as integer

    if lhs.dollars = rhs.dollars AND lhs.cents = rhs.cents then
        return false
    else
        return true
    end if

end operator

operator USCurrency.cast() as string

    return "$" & dollars & "." & format(cents,"00")

end operator

fbext_Instanciate( fbExt_List, ((USCurrency)) )


''::: Main
randomize timer
var clist = fbExt_List( ((USCurrency)) )

for n as integer = 1 to 10

    clist.PushBack( USCurrency(int(rnd()*1000),int(rnd()*1000)) )

next

var iter = clist.Begin()

print "Size of list: " & clist.Size()

while iter <> clist.End_()

    print *(iter.Get()) 'casts to string
    iter.Increment

wend

