sed "s/###/`svn info | grep 'Revision'`/g" Menu.auto > Menu.txt

