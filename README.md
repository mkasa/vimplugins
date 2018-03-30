# vimplugins
My vim plugins (in addition to Janus)

## How to use

```
% cd
% git --version
(make sure that you have git 1.6.5 or later)
% gcc --version
(make sure that you have a C compiler)
% rake --version
(make sure that you have rake on your system)
% git clone --recursive https://github.com/mkasa/vimplugins.git .janus
% cd .janus
% make init
% make link
```

## For RHEL 7 users
To prepare the requisites:

```
% sudo yum install -y gvim ruby gcc make git
% gem install rake
```

# License
Individual submodules have different licenses.
Other materials can be distributed under MIT License.
