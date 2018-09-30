
.SUFFIXES: .dump .s

all:
	sintetize /tmp${subst $(HOME),,${PWD}} DE0_Nano

# define a suffix rule for .s -> .dump
.s.dump :
	masm $<
