''File: simple.bas
''Description: Demonstration of ext.xml object.
''
''Copyright (c) 2007-2024 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING)

#include "ext/xml.bi"
using ext

dim as xml.tree foo

foo.root->appendChild("root")

foo.root->child("root")->appendChild("tag")
foo.root->child("root")->appendChild("tag")
foo.root->child("root")->appendChild("tag")

foo.root->child("root")->child("tag", 1)->attribute("attribute") = "value"
foo.root->child("root")->child("tag", 2)->attribute("unicode") = "你好，世界！"

? foo

foo.clear()

foo = !"<tree><branch><leaf color=\"red\"></branch></tree>"

? foo
