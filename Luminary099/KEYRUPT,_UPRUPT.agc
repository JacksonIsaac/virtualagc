### FILE="Main.annotation"
## Copyright:	Public domain.
## Filename:	KEYRUPT_UPRUPT.agc
## Purpose: 	Part of the source code for Luminary 1A build 099.
##		It is part of the source code for the Lunar Module's (LM)
##		Apollo Guidance Computer (AGC), for Apollo 11.
## Assembler:	yaYUL
## Contact:	Ron Burkey <info@sandroid.org>.
## Website:	www.ibiblio.org/apollo.
## Pages:	1338-1340
## Mod history:	2009-05-27 RSB	Adapted from the corresponding 
##				Luminary131 file, using page 
##				images from Luminary 1A.
##		2016-12-18 RSB	Proofed text comments with octopus/ProoferComments
##				and corrected the errors found.
##
## This source code has been transcribed or otherwise adapted from
## digitized images of a hardcopy from the MIT Museum.  The digitization
## was performed by Paul Fjeld, and arranged for by Deborah Douglas of
## the Museum.  Many thanks to both.  The images (with suitable reduction
## in storage size and consequent reduction in image quality as well) are
## available online at www.ibiblio.org/apollo.  If for some reason you
## find that the images are illegible, contact me at info@sandroid.org
## about getting access to the (much) higher-quality images which Paul
## actually created.
##
## Notations on the hardcopy document read, in part:
##
##	Assemble revision 001 of AGC program LMY99 by NASA 2021112-61
##	16:27 JULY 14, 1969 

## Page 1338
		BANK	14
		SETLOC	KEYRUPT
		BANK
		COUNT*	$$/KEYUP

KEYRUPT1	TS	BANKRUPT
		XCH	Q
		TS	QRUPT
		TC	LODSAMPT	# TIME IS SNATCHED IN RUPT FOR NOUN 65.
		CAF	LOW5
		EXTEND
		RAND	MNKEYIN		# CHECK IF KEYS 5M-1M ON
KEYCOM		TS	RUPTREG4
		CS	FLAGWRD5
		MASK	DSKYFBIT
		ADS	FLAGWRD5

ACCEPTUP	CAF	CHRPRIO		# (NOTE: RUPTREG4 = KEYTEMP1)
		TC	NOVAC
		EBANK=	DSPCOUNT
		2CADR	CHARIN

		CA	RUPTREG4
		INDEX	LOCCTR
		TS	MPAC		# LEAVE 5 BIT KEY CDE IN MPAC FOR CHARIN
		TC	RESUME

## Page 1339
# UPRUPT PROGRAM

UPRUPT		TS	BANKRUPT
		XCH	Q
		TS	QRUPT
		TC	LODSAMPT	# TIME IS SNATCHED IN RUPT FOR NOUN 65.
		CAF	ZERO
		XCH	INLINK
		TS	KEYTEMP1
		CAF	BIT3		# TURN ON UPACT LIGHT
		EXTEND			# (BIT 3 OF CHANNEL 11)
		WOR	DSALMOUT
UPRPT1		CAF	LOW5		# TEST FOR TRIPLE CHAR REDUNDANCY
		MASK	KEYTEMP1	# LOW5 OF WORD
		XCH	KEYTEMP1	# LOW5 INTO KEYTEMP1
		EXTEND
		MP	BIT10		# SHIFT RIGHT 5
		TS	KEYTEMP2
		MASK	LOW5		# MID 5
		AD	HI10
		TC	UPTEST
		CAF	BIT10
		EXTEND
		MP	KEYTEMP2	# SHIFT RIGHT 5
		MASK	LOW5		# HIGH 5
		COM
		TC	UPTEST

UPCK		CS	ELRCODE		# CODE IS GOOD.  IF CODE = 'ERROR RESET',
		AD	KEYTEMP1	# CLEAR UPLOCKFL (SET BIT4 OF FLAGWRD7 = 0)
		EXTEND			# IF CODE DOES NOT = 'ERROR RESET', ACCEPT
		BZF	CLUPLOCK	# CODE ONLY IF UPLOCKFL IS CLEAR (=0).

		CAF	UPLOCBIT	# TEST UPLOCKFL FOR 0 OR 1
		MASK	FLAGWRD7
		CCS	A
		TC	RESUME		# UPLOCKFL = 1
		TC	ACCEPTUP	# UPLOCKFL = 0

CLUPLOCK	CS	UPLOCBIT	# CLEAR UPLOCKFL (I.E., SET BIT 4 OF )
		MASK	FLAGWRD7	# FLAGWRD7 = 0)
		TS	FLAGWRD7
		TC	ACCEPTUP

					# CODE IS BAD
TMFAIL2		CS	FLAGWRD7	# LOCK OUT FURTHER UPLINK ACTIVITY
		MASK	UPLOCBIT	# (BY SETTING UPLOCKFL = 1) UNTIL
		ADS	FLAGWRD7	# 'ERROR RESET' IS SENT VIA UPLINK.
		TC	RESUME
UPTEST		AD	KEYTEMP1
## Page 1340
		CCS	A
		TC	TMFAIL2
HI10		OCT	77740
		TC	TMFAIL2
		TC	Q

ELRCODE		OCT	22

# 'UPLINK ACTIVITY LIGHT' IS TURNED OFF BY .....
#	1.	VBRELDSP
#	2.	ERROR RESET
#	3.	UPDATE PROGRAM (P27) ENTERED BY V70,V71,V72, AND V73.
#				     -
# THE RECEPTION OF A BAD CODE (I.E  CCC FAILURE) LOCKS OUT FURTHER UPLINK ACTIVITY BY SETTING BIT4 OF FLAGWRD7 = 1.
# THIS INDICATION WILL BE TRANSFERRED TO THE GROUND BY THE DOWNLINK WHICH DOWNLINKS ALL FLAGWORDS.
# WHEN UPLINK ACTIVITY IS LOCKED OUT, IT CAN BE ALLOWED WHEN THE GROUND UPLINKS AND 'ERROR RESET' CODE.
# (IT IS RECOMMENDED THAT THE 'ERROR LIGHT RESET' CODE IS PRECEEDED BY 16 BITS THE FIRST OF WHICH IS 1 FOLLOWED
# BY 15 ZEROES.  THIS WILL ELIMINATE EXTRANEOUS BITS FROM INLINK WHICH MAY HAVE BEEN LEFT OVER FROM THE ORIGINAL
# FAILURE)
#
# UPLINK ACTIVITY IS ALSO ALLOWED (UNLOCKED) DURING FRESH START WHEN FRESH START SETS BIT4 OF FLAGWRD7 = 0.

		CS	XDSPBIT

