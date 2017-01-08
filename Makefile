
default:
	git submodule foreach git pull --rebase origin master
	make -C vimproc.vim
	cd ${HOME}/.vim; rake

init: ${HOME}/.vim/Rakefile default submodules
	cd ${HOME}/.janus; ${MAKE} -c vimproc.vim

submodules:
	cd ${HOME}/.janus; git submodule init
	cd ${HOME}/.janus; git submodule update

link:
	cd ${HOME}; ln -s .janus/.vimrc.before .
	cd ${HOME}; ln -s .janus/.vimrc.after .

ghc:
	stack install ghc-mod
	cd lushtags; stack install

python:
	pip install jedi

markdowntagbar:
	-mkdir -p ${HOME}/.local/bin
	cd ${HOME}/.local/bin; wget https://raw.githubusercontent.com/jszakmeister/markdown2ctags/master/markdown2ctags.py
	cd ${HOME}/.local/bin; chmod 755 markdown2ctags.py

${HOME}/.vim/Rakefile:
	cd ${HOME}
	curl -Lo- https://bit.ly/janus-bootstrap | bash

help:
	echo "Initialize vim plugins"
	echo "    make init"
	echo "Initialize ghc related stuff"
	echo "    make ghc"
	echo "Initialize Python related stuff"
	echo "    make python"
	echo "Initialize Tagbar+Markdown"
	echo "    make markdowntagbar"
	echo "Create symbolic links to startup files"
	echo "    make link"
	echo "Update plugins"
	echo "    make"
