''Title: algorithms/gnomesort.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_GNOMESORT_BI__
# define FBEXT_ALGORITHMS_GNOMESORT_BI__ -1

# include once "ext/algorithms/detail/common.bi"

    # macro fbext_GnomeSort_Declare(T_)
    :
    namespace ext
    	declare sub GnomeSort overload ( byval p as fbext_TypeName(T_) ptr, byval num as ext.SizeType )
    	declare sub GnomeSort overload ( byval p as fbext_TypeName(T_) ptr, byval num as ext.SizeType, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool )
    	
    	declare sub GnomeSort overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr )
    	declare sub GnomeSort overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool )
    	
    	declare sub GnomeSort overload ( array() as fbext_TypeName(T_) )
    	declare sub GnomeSort overload ( array() as fbext_TypeName(T_), byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool )
    end namespace
    :
    # endmacro
    
    # macro fbext_GnomeSort_Define(linkage_, T_)
    :
    namespace ext
    	'' :::::
    	linkage_ sub GnomeSort ( byval p as fbext_TypeName(T_) ptr, byval num as ext.SizeType )
    	
            dim n as ext.SizeType
            
            do while n < num
            
                if 0 = n then
                    n += 1
                
                else
                    if p[n-1] <= p[n] then
                        n += 1
                    
                    else
                        swap p[(n-1)], p[(n)]
                        n -= 1
                    
                    end if
                
                end if
            
            loop
    	
    	end sub
    	
    	'' :::::
    	linkage_ sub GnomeSort ( byval p as fbext_TypeName(T_) ptr, byval num as ext.SizeType, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool )
    	
            dim n as ext.SizeType
            
            do while n < num
            
                if 0 = n then
                    n += 1
                
                else
                    if pred(p[n-1], p[n]) then
                        n += 1
                    
                    else
                        swap p[(n-1)], p[(n)]
                        n -= 1
                    
                    end if
                
                end if
            
            loop
    	
    	end sub
    	
    	'' :::::
    	linkage_ sub GnomeSort ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr )
    	
    	    ext.GnomeSort(first, last - first)
    	
    	end sub
    	
    	'' :::::
    	linkage_ sub GnomeSort ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool )
    	
    	    ext.GnomeSort(first, last - first, pred)
    	
    	end sub
    	
    	'' :::::
    	linkage_ sub GnomeSort ( array() as fbext_TypeName(T_) )
    	
    	    ext.GnomeSort(@array(lbound(array)), ubound(array) - lbound(array) + 1)
    	
    	end sub
    	
    	'' :::::
    	linkage_ sub GnomeSort ( array() as fbext_TypeName(T_), byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool )
    	
    	    ext.GnomeSort(@array(lbound(array)), ubound(array) - lbound(array) + 1, pred)
        
    	end sub
    end namespace
    :
    # endmacro
    
    fbext_InstanciateForBuiltins__(fbext_GnomeSort)

# endif ' include guard
