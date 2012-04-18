''File: simple.bas
''Description: Demonstration of ext.xml object.
''
''Copyright (c) 2007-2012 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

#include "ext/xml.bi" 
using ext

dim as xml.tree foo

foo.root->appendChild("root")

foo.root->child("root")->appendChild("tag")
foo.root->child("root")->appendChild("tag")
foo.root->child("root")->appendChild("tag")

foo.root->child("root")->child("tag", 1)->attribute("attribute") = "value"
foo.root->child("root")->child("tag", 2)->attribute("unicode") = "⠥⠞⠋⠤⠓"

? foo

foo.root->removeChild("root")


foo = !"<tree><branch><leaf color=\"red\"></branch></tree>"

? foo
