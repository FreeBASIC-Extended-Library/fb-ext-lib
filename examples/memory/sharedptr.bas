''File: sharedptr.bas
''Description: Demonstration of ext.SharedPtr object.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/memory/sharedptr.bi"

type Gizmo
	declare constructor ( byval n as integer )
	declare destructor
	i as integer
end type

constructor Gizmo  ( byval n as integer )
	print "constructing Gizmo object: " & n
	i = n
end constructor

destructor Gizmo
	print "destroying Gizmo object: " & i
end destructor

namespace ext
    fbext_Instanciate(fbext_SharedPtr, ((Gizmo)))
end namespace

		''
		private sub DestroyGizmo ( byval p as Gizmo ptr )
			delete p
		end sub
		
		'' a lib could expose a factory procedure to get new Gizmo objects..
		function CreateGizmo ( byval n as integer ) as ext.fbext_SharedPtr((Gizmo))
			return ext.fbext_SharedPtr((Gizmo))(new Gizmo(n), @DestroyGizmo)
		end function
		
		scope
			var sp1 = CreateGizmo(420)
			scope
				var sp2 = sp1
			end scope
		end scope ' <- users don't need to worry about destroying the Gizmo object.
		
