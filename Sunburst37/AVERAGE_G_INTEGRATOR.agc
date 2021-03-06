### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    AVERAGE_G_INTEGRATOR.agc
## Purpose:     A section of Sunburst revision 37, or Shepatin revision 0.
##              It is part of an early development version of the software
##              for Apollo Guidance Computer (AGC) on the unmanned Lunar
##              Module (LM) flight Apollo 5. Sunburst 37 was the program
##              upon which Don Eyles's offline development program Shepatin
##              was based; the listing herein transcribed was actually for
##              the equivalent revision 0 of Shepatin.
##              This file is intended to be a faithful transcription, except
##              that the code format has been changed to conform to the
##              requirements of the yaYUL assembler rather than the
##              original YUL assembler.
## Reference:   pp. 788-794
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2017-05-24 MAS  Created from Sunburst 120.

## NOTE: Page numbers below have not yet been updated to reflect Sunburst 37.

## Page 842
# *************************************************************************************************************

#          ROUTINE CALCRVG INTEGRATES THE EQUATIONS OF MOTION BY AVERAGING THE THRUST AND GRAVITATIONAL
# ACCELERATIONS OVER A TIME INTERVAL OF 2 SECONDS.

#          FOR THE EARTH-CENTERED GRAVITATIONAL FIELD, THE PERTURBATION DUE TO OBLATENESS IS COMPUTED TO THE FIRST
# HARMONIC COEFFICIENT J.

#          ROUTINE CALCRVG REQUIRES...
#                 1) THRUST ACCELERATION INCREMENTS IN DELV SCALED SAME AS PIPAX,Y,Z
#                 2) VN SCALED 2(+7)M/CS.
#                 3) PUSHDOWN COUNTER SET TO ZERO.
# IT LEAVES RN1 UPDATED (SCALED AT 2(+24)M, VN1 (SCALED AT 2(+7)M/CS), ANDGDT1/2 (SCALED AT 2(+7)M/CS).


                BANK            30
                EBANK=          EVEX

CALCGRAV        UNIT                                            # ENTER WITH RN AT 2(+24)M IN VAC
                STORE           UNITR                           
                DOT             PUSH                            
                                UNITW                           
                DSQ             DDV                            
                                DP1/10                          
                BDSU            PDDL                            
                                DP1/8TH
                                36D
                STODL           RMAG
                                J(RE)SQ
                DDV
                                34D
                STORE           32D
                DMP
                VXSC            PDDL                            
                                UNITR                           
                DMP             VXSC                            
                                32D                             
                                UNITW
                VAD             VAD                             
                                UNITR                           
                PDDL            DDV
                                -MUDT
                                34D
                VXSC            STADR
                STORE           GDT1/2

                RVQ

CALCRVG         VLOAD           VXSC                            
                                DELV                            
## Page 843
                                KPIP1                           
                PUSH            STQ                             # DV/2 TO PD SCALED AT 2(+7)M/CS
                                31D
                VAD             PUSH                            # (DV-OLDGDT)/2 TO PD SCALED AT 2(+7)M/CS
                                GDT/2                           
                VAD             VXSC                            
                                VN                              
                                2SEC(17)                        
                VAD
                                RN                              
                STCALL          RN1                             # TEMP STORAGE OF RN SCALED 2(+24)M
                                CALCGRAV                        

## Both VADs on the following line are circled.
                VAD             VAD                             
                VAD                                             
                                VN                              
                STCALL          VN1                             # TEMP STORAGE OF VN SCALED 2(+7)M/CS
                                31D                             

KPIP            2DEC            .1024                           # SCALES DELV TO 2(+4)

KPIP1           2DEC            0.0064

DP1/8TH         2DEC            0.125

DP1/10          2DEC            0.1

J(RE)SQ         2DEC            0.060066630     B-5             #      SCALED AT 2(+45)

-MUDT           2DEC*           -7.9720645      E+12 B-55*   

2SEC(17)	2DEC		200		B-17

DP2(-3)         2DEC            0.125

MUEARTH         2DEC            0.009063188                     # 3.98603223 E14 SCALED AT 2(42)M(3)/CS(2)

MUMOON          2DEC            0.007134481                     # 4.90277800 E12 SCALED AT 2(36)M(3)/CS(2)
