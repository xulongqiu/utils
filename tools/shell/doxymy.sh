#########################################################################
# File Name: doxymy.sh
# Author: xulongqiu
# mail: xulongqiu@xiaomi.com
# Created Time: 2018-06-08 11:49:04
#########################################################################
#!/bin/bash

if ! [ -f ./Doxyfile ]; then
    cp ~/work_source/github/utils/tools/shell/Doxyfile .
fi

doxygen Doxyfile > /dev/null
sed -i -e 's,begin{document},usepackage{CJKutf8}\n\\begin{document}\n\\begin{CJK}{UTF8}{gbsn},' ./doxydoc/latex/refman.tex
sed -i -e 's,end{document},end{CJK}\n\\end{document},' ./doxydoc/latex/refman.tex
cd doxydoc/latex/; make > /dev/null
cd -
