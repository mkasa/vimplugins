
default:
	git submodule foreach git pull
	cd ${HOME}/.vim; rake

init: ${HOME}/.vim/Rakefile default submodules
	cd ${HOME}/.janus; ${MAKE} -c vimproc

submodules:
	cd ${HOME}/.janus; git submodule init
	cd ${HOME}/.janus; git submodule update

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
	echo "Update plugins"
	echo "    make"
