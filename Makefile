
default:
	git submodule foreach git pull origin master
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
	cabal install ghc-mod
	cd lushtags
	cabal install

python:
	pip install jedi

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
	echo "Create symbolic links to startup files"
	echo "    make link"
	echo "Update plugins"
	echo "    make"
