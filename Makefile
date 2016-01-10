# get them all
everything: disort.so #moms.so

# This is the disort fortran library
disort.so: disort_py.f errpack.f linpak.f rdi1mach.f bdref.f   
	f2py -c -m disort disort_py.f errpack.f linpak.f rdi1mach.f bdref.f --fcompiler=gnu95

# getmom.f 
# getmom.f 

# This is the legendre moments fortran library
#moms.so: getmompf.f getmom.f
#	f2py -c -m moms getmompf.f getmom.f  --fcompiler=gnu95

