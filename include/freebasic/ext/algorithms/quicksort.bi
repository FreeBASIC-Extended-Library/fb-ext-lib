''Title: algorithms/quicksort.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_QUICKSORT_BI__
# define FBEXT_ALGORITHMS_QUICKSORT_BI__ -1

# include once "ext/algorithms/detail/common.bi"

'' Namespace: ext
namespace ext

    type quickSortComparator__ as function cdecl ( byval elem1 as const any ptr, byval elem2 as const any ptr ) as integer

end namespace

    # define quickSort_Comparator(T_) fbext_TypeID((quickSort_Comparator) T_)

    # macro fbext_quickSort_Declare(T_)
    :
    namespace ext
        type quickSort_Comparator(T_) as function cdecl ( byval elem1 as const fbext_TypeName(T_) ptr, byval elem2 as const fbext_TypeName(T_) ptr ) as integer

        declare sub quickSort overload ( byval p as fbext_TypeName(T_) ptr, byval num as ext.SizeType )
        declare sub quickSort overload ( byval p as fbext_TypeName(T_) ptr, byval num as ext.SizeType, byval comp as quickSort_Comparator(T_) )

        declare sub quickSort overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr )
        declare sub quickSort overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval comp as quickSort_Comparator(T_) )

        declare sub quickSort overload ( array() as fbext_TypeName(T_) )
        declare sub quickSort overload ( array() as fbext_TypeName(T_), byval comp as quickSort_Comparator(T_) )
    end namespace
    :
    # endmacro

    # define quickSort_DefaultComparator(T_) fbext_TypeID((quickSort_Comparator) T_)

    # macro fbext_quickSort_Define(linkage_, T_)
    :
    namespace ext
        '' :::::
        linkage_ function quickSort_DefaultComparator(T_) cdecl ( byval elem1 as const fbext_TypeName(T_) ptr, byval elem2 as const fbext_TypeName(T_) ptr ) as integer

            ' elem1 < elem2
            if *elem1 < *elem2 then
                return -1

            ' elem1 = elem2
            elseif not *elem2 < *elem1 then
                return 0

            ' elem1 > elem2
            else
                return 1

            end if

        end function

        '' :::::
        linkage_ sub quickSort ( byval p as fbext_TypeName(T_) ptr, byval num as ext.SizeType )

            qsort( _
                p,                                          _
                num,                                        _
                sizeof(fbext_TypeName(T_)),                 _
                cast( _
                    quickSortComparator__,             _
                    @quickSort_DefaultComparator(T_)   _
                )                                           _
            )

        end sub

        '' :::::
        linkage_ sub quickSort ( byval p as fbext_TypeName(T_) ptr, byval num as ext.SizeType, byval comp as quickSort_Comparator(T_) )

            qsort( _
                p,                                          _
                num,                                        _
                sizeof(fbext_TypeName(T_)),                 _
                cast( _
                    quickSortComparator__,             _
                    @comp                               _
                )                                           _
            )

        end sub

        '' :::::
        linkage_ sub quickSort ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr )

            ext.quickSort(first, last - first)

        end sub

        '' :::::
        linkage_ sub quickSort ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval comp as quickSort_Comparator(T_) )

            ext.quickSort(first, last - first, comp)

        end sub

        '' :::::
        linkage_ sub quickSort ( array() as fbext_TypeName(T_) )

            ext.quickSort(@array(lbound(array)), ubound(array) - lbound(array) + 1)

        end sub

        '' :::::
        linkage_ sub quickSort ( array() as fbext_TypeName(T_), byval comp as quickSort_Comparator(T_) )

            ext.quickSort(@array(lbound(array)), ubound(array) - lbound(array) + 1, comp)

        end sub
    end namespace
    :
    # endmacro

    fbext_InstanciateForBuiltins__(fbext_quickSort)

# endif ' include guard
