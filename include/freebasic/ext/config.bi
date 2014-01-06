'' Title: ext/config.bi
''
''About: About this Module
''This module provides a way to configure your program easily using
''the standard locations on each platform.
''You do not need to distribute a config file either, as it will be
''generated the first time you run your application provided you
''set you default values in the getType calls. This configuration file is
''saved in somewhat human-readable XML for advanced users to modify if
''they wish to do so at a standard location.
''
''The Standard locations for each platform are:
'' Windows - %APPDATA%\appname\config.xml
'' Linux - $HOME/.config/appname/config.xml
'' DOS - EXEPATH/appname.cfg
''
''The configuration file is treated as a name-value store. Each named item
''can consist of a Boolean value, integer or double value and a String value.
''If you wish to have more than one, you should make sure that you call
''getString first so the *name* is properly created. Also, please note that
''integers and doubles are stored in the same location in *name* and will
''overwrite each other.
''
''You should generally call the get* functions (with a default value) and
''only call the set* functions if you need to change something after
''loading the configuration, i.e. the user changes something or you
''are saving a new window position at exit.
''
''You must ensure that you call setAppName before calling load else
''your application will have the default name of "UnnamedApp".
''
'' About: Code License
''  Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_CONFIG_BI__
# define FBEXT_CONFIG_BI__ -1

# include once "ext/detail/common.bi"
# include once "ext/xml/dom.bi"

#if not __FB_MT__
    #inclib "ext-config"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-config.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif

''Namespace: ext.config
namespace ext.config

''Sub: setAppName
''The Human-readable name of your application to be used when determining
''where to load/save the configuration file by default.
''
''Parameters:
''appn - the Name to use.
declare sub setAppName( byref appn as string )

''Sub: setPath
''Sets the configuration file location to a non-standard location.
''Generally you should not use this without a good reason.
''
''Parameters:
''path - where to save/load the configuration file from.
declare sub setPath( byref path as string )

''Sub: load
''Loads the configuration from disk (if available).
declare sub load()

''Sub: save
''Saves the current state of configuration to disk.
declare sub save()

''Section: Basic Usage

''Function: getBool
''
''Parameters:
''name_ - the name of the value to retrieve
''defalut - *optional* the default value to return if the name_ is not set
''
''Returns:
''The retrived value or the default if not set.
''
''Example:
''Generates the following XML
''(begin code)
''<name_ enabled="false" />
''(end code)
declare function getBool( byref name_ as string, byval default as bool = false ) as bool

''Function: getString
''
''Parameters:
''name_ - the name of the value to retrieve
''defalut - *optional* the default value to return if the name_ is not set
''
''Returns:
''The retrived value or the default if not set.
''
''Example:
''Generates the following XML
''(begin code)
''<name_>string</name_>
''(end code)
declare function getString( byref name_ as string, byref default as string = "" ) as string

''Function: getInteger
''
''Parameters:
''name_ - the name of the value to retrieve
''defalut - *optional* the default value to return if the name_ is not set
''
''Returns:
''The retrived value or the default if not set.
''
''Example:
''Generates the following XML
''(begin code)
''<name_ value="0" />
''(end code)
declare function getInteger( byref name_ as string, byval default as integer = 0 ) as integer

''Function: getDouble
''
''Parameters:
''name_ - the name of the value to retrieve
''defalut - *optional* the default value to return if the name_ is not set
''
''Returns:
''The retrived value or the default if not set.
''
''Example:
''Generates the following XML
''(begin code)
''<name_ value="0.0" />
''(end code)
declare function getDouble( byref name_ as string, byval default as double = 0.0 ) as double

''Sub: getBoolArray
''
''Parameters:
''name_ - the key to retrieve items for
''subname - *optional* the name of the subkey each item is listed as, default is "item" (see example)
''array() - the array to put the results into
''
''Example:
''XML output
''(begin code)
''<name_>
''  <item enabled="true" />
''  <item enabled="true" />
''</name>
''(end code)
declare sub getBoolArray( byref name_ as string, byref subname as string = "item", array() as bool )

''Sub: getIntegerArray
''
''Parameters:
''name_ - the key to retrieve items for
''subname - *optional* the name of the subkey each item is listed as, default is "item" (see example)
''array() - the array to put the results into
''
''Example:
''XML output
''(begin code)
''<name_>
''  <item value="0" />
''  <item value="0" />
''</name>
''(end code)
declare sub getIntegerArray( byref name_ as string, byref subname as string = "item", array() as integer )

''Sub: getDoubleArray
''
''Parameters:
''name_ - the key to retrieve items for
''subname - *optional* the name of the subkey each item is listed as, default is "item" (see example)
''array() - the array to put the results into
''
''Example:
''XML output
''(begin code)
''<name_>
''  <item value="0.0" />
''  <item value="0.0" />
''</name>
''(end code)
declare sub getDoubleArray( byref name_ as string, byref subname as string = "item", array() as double )

''Sub: getStringArray
''
''Parameters:
''name_ - the key to retrieve items for
''subname - *optional* the name of the subkey each item is listed as, default is "item" (see example)
''array() - the array to put the results into
''
''Example:
''XML output
''(begin code)
''<name_>
''  <item>string</item>
''  <item>string</item>
''</name>
''(end code)
declare sub getStringArray( byref name_ as string, byref subname as string = "item", array() as string )

''Sub: setBool
''
''Parameters:
''name_ - the key to set the value of
''v - the value to assign to name_
''
''Notes:
''Changes take effect immediately in memory but do not persist on disk until <save> is called.
declare sub setBool( byref name_ as string, byval v as bool )

''Sub: setString
''
''Parameters:
''name_ - the key to set the value of
''v - the value to assign to name_
''
''Notes:
''Changes take effect immediately in memory but do not persist on disk until <save> is called.
declare sub setString( byref name_ as string, byref v as string )

''Sub: setInteger
''
''Parameters:
''name_ - the key to set the value of
''v - the value to assign to name_
''
''Notes:
''Changes take effect immediately in memory but do not persist on disk until <save> is called.
declare sub setInteger( byref name_ as string, byval v as integer )

''Sub: setDouble
''
''Parameters:
''name_ - the key to set the value of
''v - the value to assign to name_
''
''Notes:
''Changes take effect immediately in memory but do not persist on disk until <save> is called.
declare sub setDouble( byref name_ as string, byval v as double )

''Sub: setBoolArray
''
''Parameters:
''name_ - the key to set items for
''subname - *optional* the name of the subkey each item is listed as, default is "item" (see example)
''array() - the array to get the values from
declare sub setBoolArray( byref name_ as string, byref subname as string = "item", array() as bool )

''Sub: setIntegerArray
''
''Parameters:
''name_ - the key to set items for
''subname - *optional* the name of the subkey each item is listed as, default is "item" (see example)
''array() - the array to get the values from
declare sub setIntegerArray( byref name_ as string, byref subname as string = "item", array() as integer )

''Sub: setDoubleArray
''
''Parameters:
''name_ - the key to set items for
''subname - *optional* the name of the subkey each item is listed as, default is "item" (see example)
''array() - the array to get the values from
declare sub setDoubleArray( byref name_ as string, byref subname as string = "item", array() as double )

''Sub: setStringArray
''
''Parameters:
''name_ - the key to set items for
''subname - *optional* the name of the subkey each item is listed as, default is "item" (see example)
''array() - the array to get the values from
declare sub setStringArray( byref name_ as string, byref subname as string = "item", array() as string )

''Function: exists
''Check if the specified name exists in the configuration file.
''
''Parameters:
''name_ - the key to check for.
''
''Returns:
''TRUE if the key exists, FALSE otherwise.
''
declare function exists( byref name_ as string ) as bool

''Sub: remove
''Remove the specified key from the configuration file.
''
''Parameters:
''name_ - the key to remove.
''
''Notes:
''This change will not take effect on disk until you call <save>.
''
declare sub remove( byref name_ as string )

''Section: Advanced Usage

''Function: get_rawxml
''This function allows you to access the raw xml tree associated with a key
''in order to do things that are too advanced for the simple api above.
''
''Parameters:
''name_ - the key to retrieve
''
''Returns:
''<ext.xml.node> pointer or NULL if the key does not exist
declare function get_rawxml( byref name_ as string ) as ext.xml.node ptr

end namespace

#endif
