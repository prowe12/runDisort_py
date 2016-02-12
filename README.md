runDisort_mat
==============

This code runs DISORT from PYTHON 2.7 to perform radiative transfer calculations for layered model atmospheres, including absorption and scattering. Inputs include gaseous optical depths, atmospheric parameters, and cloud properties. Radiative transfer is performed using DISORT 2.0 Beta (from ftp://climate1.gsfc.nasa.gov/wiscombe/Multiple_Scatt/). Using f2py, inputs and outputs can be passed directly to and from the DISORT fortran code. This requires PYTHON 2.7, since PYTHON 3.x does not yet support f2py. This is a work in progress, and may have bugs. It is shared without guarantees of any kind. Improvements are ongoing, and we welcome feedback.

To use this code, you will need to do the following:

1) Install Python on your computer. These instructions are for Python 2.7, which uses f2py. (You can also install Python 3.4 and use the fortran magic). If you have upgraded to 3.4, you can switch back to 2.7 using $ source activate py*, where the py* depends on how you installed python; for example, it might be python2 or python2.7 or (in my case) py27. To switch back type $ source deactivate. You will also need Fortran.
2) Copy these files onto your computer.
3) Within the installation directory, modify the makefile as needed for the fortran compiler you have; here we use gfortan. Run "make" to compile disort_driver_mat (a fortran executable). This is the code that will call disort.
4) Move or copy disort_driver_py into the directory “Compare2runDisort_mat” (need to make sure this step is needed).
5) You can try out the code in Python using “sample_run.py” in the sampleRun folder.  Make sure your path information will all work out. Compare your output (disort_out.txt) to “disort_out_sample_run.txt.” Note that the output should also be the same as when running “sample_run.m” from the Matlab code in runDisort_mat.



Planned upgrades: 
1) A new version of DISORT, DISORT3 is available. I hope to incorporate this soon. 
2) This code requires gaseous optical depths as input. We use the line-by-line radiative transfer model (LBLRTM; http://rtweb.aer.com/lblrtm.html) for this purpose. A github directory for codes for running LBLRTM from MATLAB or Octave, runLBLRTM_mat, is in progress. This code is currently available on request.
3) A matlab version is also available on this github site (runDisort_mat).
4) I hope to incorporate single scattering parameter files for more realistic ice habits soon.



Acknowledging use of this code (please let us know if any references are missing):

1) If this code is used in work leading to a publication, please include an acknowledgement to P.M. Rowe, S. Neshyba, and V. P. Walden. A reference is pending, so please contact Penny Rowe (prowe@harbornet.com for proper referencing)

2) DISORT references: 

    Stamnes, K., Tsay, S.-C., Wiscombe, W. J., and Jayaweera, K.: Numerically stable algorithm for discrete-ordinate-method radiative transfer in multiple scattering and emitting layered media, Appl. Optics, 27(12), 2502–2509, doi:10.1364/AO.27.002502, 1988. 

    Stamnes, K., Tsay, S.-C., Wiscombe, W., and Laszlo, I.: DISORT, a general-purpose Fortran program for discrete-ordinate-method radiative transfer in scattering and emitting layered media: Documentation of methodology, Tech. rep., Dept. of Physics and Engineering Physics, Stevens Institute of Technology, Hoboken, NJ 07030, 2000. 

3) For use of the temperature-dependent single-scattering parameters of liquid water (pmom files), please reference: 

    Rowe, P.M., S. Neshyba, and V. P. Walden, Radiative consequences of low-temperature infrared refractive indices for supercooled water clouds, Atmos. Chem. Phys., 13, 11925–11933, 2013. www.atmos-chem-phys.net/13/11925/2013/ doi:10.5194/acp-13-11925-2013

    as well as referencing Zasetsky et al., 2005 and Wagner et al., 2005 as given within.

4) For use of the single-scattering parameters for liquid water at 300 K, please reference Downing, H. D. and Williams, D.: Optical constants of water in the Infrared, J. Geophys. Res., 80, 1656–1661, 1975.

5) For use of the single-scattering parameters for ice: Warren, S. G. and Brandt, R. E.: Optical constants of ice from the ultraviolet to the microwave: a revised compilation, J. Geophys. Res., 113, D14220, doi:10.1029/2007JD009744, 2008. 

6) For use of the solar irradiance spectra: Kurucz, R.L., Synthetic infrared spectra, in Infrared Solar Physics, IAU Symp. 154, edited by D.M. Rabin and J.T. Jefferies, Kluwer, Acad., Norwell, MA, 1992.

7) For use of cloud_2012012006_cld1.mat (used by sample_run.m), please reference: Cox, C., Rowe, P. M., Neshyba, S., & Walden, V. P. (2016). A synthetic data set of high-spectral resolution infrared spectra for the Arctic atmosphere. Earth System Science Data Discussions, 1–29. http://doi.org/10.5194/essd-2015-40, in review for Earth System Science Data. Please also see our database of atmospheric profiles and cloudy and clear sky up and downwelling radiances characteristic of the Arctic at the Arctic Observing Network (AON) Arctic data repository (at \url{https://www.aoncadis.org/dataset/AAIRO_spectra.html}; doi:10.5065/D61J97TT).



Installation Instructions (these require editing!)
1) Copy these files to your directory. 
2) Within the installation directory, modify the makefile as needed for the fortran compiler you have; here we use gfortan. Run "make".
3) A file called "disort_driver_py” should be created. This is the code that will call disort.
4) Further instructions pending ...


A note on precision: some variables in DISORT are single precision. Sensitivity studies indicate that best accuracy is achieved when all layer optical depths in typical model atmospheres are above 10^-5. For example, for a total optical depth of 0.5 and temperatures near 240 K, our studies indicate that including a layer optical depth of 10^-6 results in round-off errors in zenith downwelling radiance of ~0.2 mW/(m2 sr cm-1), whereas omitting this layer from the calculation causes an error of only ~0.004 mW/(m2 sr cm-1). Furthermore, omitting extremely thin layers saves computational time. For this reason, the code excludes upper atmospheric layers with optical depths below 10^-5 (this is done on a wavenumber-by-wavenumber basis). If such thin layers need to be included, it is possible to compile entirely in double-precision at a computational cost probably less than 20% (see DISORT documentation). As described by Istvan Laszlo (personal communication), "To run DISORT in double-precision you should use DISORTsp.f, which is currently only available in pre-version 3 distributions, like in DISORT2.0beta. To create the double-precision version it is, however, not sufficient to simply auto-double DISORTsp.f at compile time. You would first need to change all instances of R1MACH to D1MACH. Then you should compile all files with the auto-double option, except one file: RDI1MACH.f should be compiled without this option. Finally you would need to link all compiled files to create the executable."


Credits:

1) The DISORT code is DISORT2.0beta, from ftp://climate1.gsfc.nasa.gov/wiscombe/Multiple_Scatt/. Please be sure to acknowledge use of DISORT. Although provided here, it is identical to the original code except for two changes. In disort.f, the maximum number of layers, MXCLY has been increased from 6 to 120. A header that was printed to the screen has been suppressed.
2) Development of this Python suite of codes for running DISORT for layered atmospheres including both clouds and gases is by Penny Rowe, Von Walden, and Steven Neshyba, with helpful insights provided by Christopher Cox. While a small project, work has proceeded over several years, and thus was funded from a variety of sources, including the National Aeronautics and Space Administration (NASA) Research Opportunities in Space and Earth Sciences program (contract NNX08AF79G), the National Science Foundation (NSF) Idaho Experimental Program to Stimulate Competitive Research (EPSCoR), and NSF award ARC-1108451. Rowe also acknowledges support from USACH-DICYT and Neshyba acknowledges support from the University of Puget Sound and the National Science Foundation under grant CHE – 1306366.
3) Python code is written by Steven Neshyba and Penny Rowe (except as noted within). 



Please email me with any questions or problems: prowe@harbornet.com

Thank you and hope it is useful!
Dr. Penny M. Rowe
