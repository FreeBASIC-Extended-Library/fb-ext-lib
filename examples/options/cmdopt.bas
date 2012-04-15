#include once "ext/options.bi"
using ext

var myOpts = options.Parser

var vopt = myOpts.addBool("v","verbose","Sets program to verbose mode." )
var copt = myOpts.addOption("c","commit",true,,,,"Commits changes.") 'has optional argument
var dopt = myOpts.addOption("d","delete", true, true, true,,"Deletes temporary files." ) 'has required argument and is repeatable
var eopt = myOpts.addOption("e","erase", true, true,,,"Erases changes.") 'has required argument

myOpts.setHelpHeader(!"This is an example program provided with the FreeBASIC Extended Library.\n" & _
						!"This program does not make any changes to your computer.\n" & _
						!"\nCommand options recognized:")
myOpts.setHelpFooter(!"Copyright (c) 2010 FreeBASIC Extended Library Development Group\n")

myOpts.parse(__FB_ARGC__,__FB_ARGV__)

if myOpts.hasError then
	print myOpts.getError()
	end 42
else
	print "No Errors processing commandline, presenting results..."
end if

if myOpts.isSet( vopt ) then
	print "opt v set: ";
else
	print "opt v not set"
end if

if myOpts.isSet( copt ) then
	print "opt c set: ";
	var x = myOpts.getArg(copt)
	if len(x) > 0 then
		print x
	else
		print "argument not supplied"
	end if
else
	print "opt c not set"
end if

if myOpts.isSet( dopt ) then
	print "opt d set: ";
	print myOpts.getArg( dopt )
else
	print "opt d not set"
end if

if myOpts.isSet( eopt ) then
	print "opt e set: ";
	print myOpts.getArg( eopt )
else
	print "opt e not set"
end if

print "Non options:"
print myOpts.getRemainder()



