include modules_versions

dep_modules=iolite-provider iolite-web3
modules=ethjs-iolite-signer $(dep_modules) vscode-solidity-iolite 

all: build


$(dep_modules):
	git clone $($@_url) 
	cd $@; git checkout $($@_revision)
	cd $@; rm -f package-lock.json
	cd $@; npm install

ethjs-iolite-signer: 
	git clone $($@_url) 
	cd $@; git checkout $($@_revision)
	cd $@; rm -f package-lock.json
	cd $@; npm install
	cd $@; npm prune --production 

vscode-solidity-iolite:
	git clone $($@_url) 
	cd $@; git checkout $($@_revision)
	cd $@; rm -f package-lock.json

build: $(modules)
	cd vscode-solidity-iolite; npm install
	cd vscode-solidity-iolite; ./node_modules/.bin/electron-rebuild -v 1.8

package:
	cd vscode-solidity-iolite; rm -f package-lock.json
	cd vscode-solidity-iolite; vsce package

clean:
	rm -fr $(modules)
