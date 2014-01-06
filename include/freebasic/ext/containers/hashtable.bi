''Title: containers/hashtable.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_CONTAINERS_HASHTABLE_BI__
# define FBEXT_CONTAINERS_HASHTABLE_BI__ -1

# include once "ext/detail/common.bi"
# include once "ext/algorithms/detail/common.bi"
# include once "ext/debug.bi"

#if not __FB_MT__
    #inclib "ext-containers"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-containers"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif

'' Namespace: ext
namespace ext

    const as single max_load_factor = .65
    const as SizeType prime_table_length = 25

    declare function m_IndexFor ( byval hashvalue as uinteger, byval tablelength as SizeType ) as uinteger
    declare function m_HTprimes ( byval index as SizeType ) as uinteger
    declare function m_HThash ( byref key_ as const string ) as uinteger

    # define fbext_HashTable(T_) fbext_TypeID((HashTable) T_)
    # define fbext_HashTableEntry(T_) fbext_TypeID((HashTableEntry) T_)
    # define fbext_HashTableIterator(T_) fbext_TypeID((HashTableIterator) T_)

    '' Macro: FBEXT_DECLARE_HASHTABLE
    ''
    # macro fbext_HashTable_Declare(T_)
    :
        ' forward declaration..
        type fbext_HashTableEntry(T_)##__ as fbext_HashTableEntry(T_)

        ''Type: HashTableIterator(type)
        ''This is a prototype for a subroutine for iterating through a hashtable.
        type fbext_HashTableIterator(T_) as sub ( byref key as const string, byval value as fbext_TypeName(T_) ptr )

        '' Class: fbext_HashTable(T_)
        '' Simple to use but powerful HashTable overloaded for all built-in numerical types.
        ''
        ''Notes:
        ''This class also supports UDTs.
        ''The requirements for UDTs are:
        ''* A default constructor.
        ''* Operator let.
        ''* Operator = (equality).
        ''If you are experiencing a large number of collisions, you should increase the size of the hashtable.
        ''
        ''See Also:
        ''<Basic Usage of the HashTable Class> |
        ''<Using HashTable with UDTs>
        ''
        type fbext_HashTable(T_)
        public:

            declare constructor ( )
            ''Sub: constructor
            ''Defines an initial size for the hashtable. When necessary the HashTable will expand itself to ensure enough room for proper operation.
            ''
            ''Parameters:
            ''minsize - the MINIMUM size of table to create, the actual table size could be larger.
            ''
            declare constructor ( byval minsize as ext.SizeType )

            ''Sub: Insert
            ''Inserts a value into the hashtable.
            ''
            ''Parameters:
            ''key_ - the string key to associate with the value.
            ''value - the value to insert into the table.
            ''
            ''Usage:
            ''It is very important that you REMOVE a value with a key that would overlap another. If the key is already
            ''located in the table, the value will NOT be overwritten.
            ''
            declare sub Insert ( byref key_ as string, byref value as fbext_TypeName(T_) )

            ''Function: Find
            ''Searches for a key in the table.
            ''
            ''Parameters:
            ''key_ - the key to search for.
            ''
            ''Returns:
            ''A pointer to value associated with the passed key. This value is NOT removed from the table.
            ''
            declare function Find ( byref key_ as string ) as fbext_TypeName(T_) ptr

            ''Function: Find
            ''Searches for a value in the table and returns its key.
            ''
            ''Parameters:
            ''value - the value to search for.
            ''
            ''Returns:
            ''ptr to String containing the key associated with a value or "" if the value was not found.
            ''
            declare function Find ( byref value as const fbext_TypeName(T_) ptr ) as string

            ''Sub: ForEach
            ''Iterates through the table calling the passed subroutine with each key pair.
            ''
            ''Parameters:
            ''iter - the address of the subroutine to call, this subroutine is of the type HashTableIterator(type).
            ''
            ''Notes:
            ''You may freely change the value passed to the subroutine, but you may not change the key.
            ''To change the key you must remove the current key from the table and insert a new one.
            ''
            ''See Also:
            ''<Simple HashTable Iterator example>
            ''
            declare sub ForEach ( byval iter as fbext_HashTableIterator(T_) )

            ''Function: Remove
            ''Searches for a key in the table and removes it.
            ''
            ''Parameters:
            ''key_ - the key to search for.
            ''
            declare sub Remove ( byref key_ as string )

            ''Property: Count
            ''Returns the number of key pairs in the table.
            ''
            declare property Count ( ) as SizeType
            declare destructor ( )
            declare operator let ( byref x as fbext_HashTable(T_) )
        'private:
            declare sub m_Expand ( )
            declare sub m_Insert ( byval thash as SizeType, byval index as SizeType, byref key_ as string, byref value as fbext_TypeName(T_) )

            m_tableLength   as SizeType
            m_entryCount    as SizeType
            m_loadLimit     as SizeType
            m_primeIndex    as SizeType
            m_table         as fbext_HashTableEntry(T_)##__ ptr

        end type
    :
    # endmacro

    # macro fbext_HashTable_Define(linkage_, T_)
    :
        type fbext_HashTableEntry(T_)

            as string key
            as fbext_TypeName(T_) ptr value
            as uinteger hash

            declare operator let ( byref x as fbext_HashTableEntry(T_) )

        end type

        '' :::::
        linkage_ operator fbext_HashTableEntry(T_).let ( byref x as fbext_HashTableEntry(T_) )
            this.key = x.key
            this.value = x.value
            this.hash = x.hash
        end operator

        '' :::::
        linkage_ operator fbext_HashTable(T_).let( byref x as fbext_HashTable(T_) )

            this.m_tableLength = x.m_tableLength : x.m_tableLength = 0
            this.m_entryCount = x.m_entryCount : x.m_entryCount = 0
            this.m_loadLimit = x.m_loadLimit : x.m_loadLimit = 0
            this.m_primeIndex = x.m_primeindex : x.m_primeindex = 0
            this.m_table = x.m_table : x.m_table = null

        end operator

        '' :::::
        linkage_ property fbext_HashTable(T_).Count ( ) as uinteger

            return m_entryCount

        end property

        '' :::::
        linkage_ constructor fbext_HashTable(T_) ( byval minsize as SizeType )

            dim as SizeType pindex = 0, size = m_HTprimes(0)

            if (minsize < (1 shl 30)) then

                while pindex < prime_table_length
                    if (m_HTprimes(pindex) > minsize) then
                        size = m_HTprimes(pindex)
                        exit while

                    end if

                pindex += 1
                wend

            this.m_table = new fbext_HashTableEntry(T_) [size]
            this.m_tablelength = size
            this.m_primeIndex = pindex
            this.m_entryCount = 0
            this.m_loadLimit = cuint(size * max_load_factor)

            end if

        end constructor

        '' :::::
        linkage_ constructor fbext_HashTable(T_) ( )

            constructor(97)

        end constructor

        '' :::::
        linkage_ destructor fbext_HashTable(T_) ( )

            for n as SizeType = 0 to m_tablelength - 1

                if m_table[n].value <> null then
                    delete m_table[n].value

                end if

            next

            delete[] m_table

        end destructor

        '' :::::
        linkage_ sub fbext_HashTable(T_).m_Expand ( )

            if m_primeIndex < (prime_table_length -1) then

                m_primeIndex += 1
                var newsize = m_HTprimes(m_primeIndex)
                var newtable = new fbext_HashTableEntry(T_) [newsize]

                if newtable <> null then

                    var index = 0
                    while index < m_tablelength -1
                        if m_table[index].hash <> null then
                            var newindex = m_indexFor(m_table[index].hash, newsize)
                            newtable[newindex] = m_table[index]
                        end if
                    index += 1
                    wend

                    memcpy( newtable, m_table, m_entryCount * sizeof( fbext_HashTableEntry(T_) ) )
                    delete[] m_table
                    m_table = newtable
                    m_tablelength = newsize
                    m_loadLimit = cuint(newsize * max_load_factor)
                end if
            end if

        end sub

        '' :::::
        linkage_ sub fbext_HashTable(T_).m_Insert( byval thash as SizeType, byval index as SizeType, byref key_ as string, byref value as fbext_TypeName(T_) )

            var cindex = index +1

            while cindex<= m_tablelength

                if m_table[cindex].value = null then
            # if fbext_TypeName(T_) = string
                    m_table[cindex].value = cast(string ptr, new byte[sizeof(string)])
            # else
                    m_table[cindex].value = new fbext_TypeName(T_)
            # endif
                end if

                if m_table[cindex].key = "" then
                    m_table[cindex].key = key_
                    *(m_table[cindex].value) = value
                    m_table[cindex].hash = thash
                    m_entryCount += 1
                    return
                end if

            cindex += 1

            wend

            if index >= 2 then
                cindex = index - 2
            else
                return
            end if

            while cindex >= 0

                if m_table[cindex].value = null then
            # if fbext_TypeName(T_) = string
                    m_table[cindex].value = cast(string ptr, new byte[sizeof(string)])
            # else
                    m_table[cindex].value = new fbext_TypeName(T_)
            # endif
                end if

                if m_table[cindex].key = "" then
                    m_table[cindex].key = key_
                    *(m_table[cindex].value) = value
                    m_table[cindex].hash = thash
                    m_entryCount += 1
                end if

                if cindex > 0 then cindex -= 1

            wend

        end sub

        '' :::::
        linkage_ sub fbext_HashTable(T_).Insert ( byref key_ as string, byref value as fbext_TypeName(T_) )

            if (m_entryCount + 1 > m_loadLimit) then
                m_Expand()
            end if

            var thash = m_HThash(key_)
            var index = m_IndexFor(thash, m_tablelength)

            if m_table[index].value = null then
        # if fbext_TypeName(T_) = string
                m_table[index].value = cast(string ptr, new byte[sizeof(string)])
        # else
                m_table[index].value = new fbext_TypeName(T_)
        # endif
                m_table[index].key = key_
                *(m_table[index].value) = value
                m_table[index].hash = thash
                m_entryCount += 1
            else
                if m_table[index].key = "" then
                    m_table[index].key = key_
                    *(m_table[index].value) = value
                    m_table[index].hash = thash
                    m_entryCount += 1
                else
                    if m_table[index].key = key_ then
                        return
                    end if

                    m_Insert(thash, index, key_, value)
                end if
            end if


        end sub

        '' :::::
        linkage_ function fbext_HashTable(T_).Find ( byref key_ as string ) as fbext_TypeName(T_) ptr

            var shash = m_HThash(key_)
            var index = m_IndexFor(shash, m_tablelength)

            if (shash = m_table[index].hash)  then return m_table[index].value
            if (shash = m_table[index+1].hash)  then return m_table[index+1].value
            if (shash = m_table[index+2].hash)  then return m_table[index+2].value

            return null


        end function

        '' :::::
        linkage_ function fbext_HashTable(T_).Find ( byref value as const fbext_TypeName(T_) ptr ) as string

            var retval = ""

            for n as uinteger = 0 to m_tablelength -1

                if m_table[n].value <> null then

                    if *value = *(m_table[n].value) then
                        retval = m_table[n].key
                        exit for
                    end if

                end if

            next

            return retval

        end function

        '' :::::
        linkage_ sub fbext_HashTable(T_).ForEach ( byval iter as fbext_HashTableIterator(T_) )

            for n as uinteger = 0 to m_tablelength -1
                if m_table[n].hash <> 0 then iter(m_table[n].key, m_table[n].value)
            next


        end sub

        '' :::::
        linkage_ sub fbext_HashTable(T_).Remove ( byref key_ as string )

            var shash = m_HThash(key_)
            var index = m_IndexFor(shash, m_tablelength)

            while index <= m_tablelength

                if (shash = m_table[index].hash) AND (key_ = m_table[index].key) then
                    m_table[index].hash = 0
                    m_table[index].key = ""
                    m_entryCount -= 1
            # if fbext_TypeName(T_) = string
                    delete cast(byte ptr, m_table[index].value)
            # else
                    delete m_table[index].value
            # endif
                    return

                end if

                index += 1

            wend

            index = m_IndexFor(shash, m_tablelength)

            for m as integer = (index - 1) to 0 step -1

                    if (shash = m_table[m].hash) AND (key_ = m_table[m].key) then
                    m_table[m].hash = 0
                    m_table[m].key = ""
                    m_entryCount -= 1
                    delete m_table[m].value
                    return

                    end if

            next

        end sub
    :
    # endmacro

    fbext_InstanciateForBuiltins__(fbext_HashTable)

    ''Example: Basic Usage of the HashTable Class
    ''(begin code)
    ''# include once "ext/containers/hashtable.bi"
    ''
    ''using ext
    ''
    ''var myHT = HashTable(single)(16)
    ''
    ''print "Count before insertion: " & myHT.count
    ''
    ''print !"Inserting \"One\" as 1.0"
    ''myHT.insert("One", 1.0)
    ''
    ''print !"Inserting \"Two\" as 2.0"
    ''myHT.insert("Two", 2.0)
    ''
    ''print !"Inserting \"Three\" as 3.0"
    ''myHT.insert("Three", 3.0)
    ''
    ''print !"Inserting \"Tacos\" as 4.2"
    ''myHT.insert("Tacos", 4.2)
    ''
    ''print !"Inserting \"FBEXT\" as 5.6"
    ''myHT.insert("FBEXT", 5.6)
    ''
    ''print "Count after insertion: " & myHT.count
    ''
    ''print "One: " & *(myHT.find("One"))
    ''
    ''print "Removing Tacos"
    ''myHT.remove("Tacos")
    ''
    ''print "Two: " & *(myHT.find("Two"))
    ''
    ''print "Removing Three"
    ''myHT.remove("Three")
    ''
    ''print "FBEXT: " & *(myHT.find("FBEXT"))
    ''
    ''print "Count after 2 removes: " & myHT.count
    ''(end code)
    ''

    ''Example: Using HashTable with UDTs
    ''(begin code)
    ''# include once "ext/containers/hashtable.bi"
    ''
    ''type UDT
    ''   x as integer
    ''   y as integer
    ''   declare constructor( ) 'Required by ext.HashTable
    ''   declare operator let( byref t as UDT ) 'Required by ext.HashTable
    ''end type
    ''
    ''constructor UDT( )
    ''   x = 0
    ''   y = 0
    ''end constructor
    ''
    '''This operator is only used by the Find by value and return the key method,
    '''so if you are not using that method you can safely make this operator simply
    '''return 0
    ''operator = ( byref lhs as UDT, byref rhs as UDT ) as integer 'Required by ext.HashTable
    ''  return iif( (lhs.x + lhs.y) = ( rhs.x + rhs.y ), ext.true, ext.false )
    ''end operator
    ''
    ''operator UDT.let( byref t as UDT )
    ''   this.x = t.x
    ''   this.y = t.y
    ''end operator
    ''
    ''namespace ext 'must be declared within ext's namespace
    ''fbext_Instanciate( fbExt_HashTable, ((UDT)) )
    ''end namespace
    ''
    ''dim as FBEXT_HASHTABLE(UDT) MyUDTHT(10)
    ''
    ''dim as UDT t1, t2, t3
    ''
    ''t1.x = 42  : t1.y = 12
    ''t2.x = 134 : t2.y = 1
    ''t3.x = 0   : t3.y = 396
    ''
    ''MyUDTHT.Insert("First One", t1)
    ''MyUDTHT.Insert("Third One", t3)
    ''MyUDTHT.Insert("Ext Rocks", t2)
    ''
    ''print MyUDTHT.Find("Ext Rocks")->x 'prints 134
    ''(end code)
    ''

    ''Example: Simple HashTable Iterator example
    ''(begin code)
    ''# include once "ext/containers/hashtable.bi"
    ''
    ''declare sub MyIterator ( byref key as const string, byval value as integer ptr )
    ''
    ''var MyHT = FBEXT_HASHTABLE(integer)(10)
    ''
    ''for n as integer = 1 to 10
    ''  MyHT.Insert("Number: " & n, n)
    ''next
    ''
    ''MyHT.ForEach( @MyIterator )
    ''
    ''sub MyIterator ( byref key as const string, byval value as integer ptr )
    ''
    ''  print !"\"" & key & !"\" => " & *value
    ''
    ''end sub
    ''(end code)

end namespace

# endif ' include guard
