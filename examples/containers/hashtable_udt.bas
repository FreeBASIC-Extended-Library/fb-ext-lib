# include once "ext/containers/hashtable.bi"

namespace ns

    type PersonInfo
        ' ext.HashTable element values must be publically default-constructible
        ' and copy-assignable.
    	declare constructor
    	declare operator let ( byref x as const PersonInfo )

    	declare constructor ( byref address as const string, byval age as integer )
    	address as string
    	age as integer
    end type

    constructor PersonInfo ( )
    end constructor

    operator PersonInfo.let ( byref x as const PersonInfo )
    	this.address = x.address
    	this.age = x.age
    end operator

    constructor PersonInfo ( byref address as const string, byval age as integer )
        this.address = address
        this.age = age
    end constructor

    ' ext.HashTable element values must also be publically equality comparable.
    operator = ( byref lhs as const PersonInfo, byref rhs as const PersonInfo ) as integer

    	return (lhs.age = rhs.age) and (lhs.address = rhs.address)

    end operator

end namespace

namespace ext
	using ns
    ' Instanciate an ext.HashTable class used to store ns.PersonInfo element
    ' values. Note that this macro must be used in namespace ext, and that the
    ' fully qualified type name is required.
    fbext_Instanciate(fbext_HashTable, ((PersonInfo)))

end namespace

using ns
    ' Create a hashtable with a minimize size of 10 elements.
    var people = ext.fbext_HashTable((PersonInfo))(10)

    people.Insert("John Doe", ns.PersonInfo("1234 Lyfindafast Lane", 16))
    people.Insert("Jane Doe", ns.PersonInfo("5678 Nofrickin Way", 53))

    var p = people.Find("John Doe")
    ASSERT( p <> ext.null )
    print "John Doe, " & p->age & " of " & p->address & "."

    p = people.Find("Waldo")
    ASSERT( p = ext.null )

    people.Remove("John Doe")
    p = people.Find("John Doe")
    ASSERT( p = ext.null )


